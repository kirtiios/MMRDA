//
//  FeedbackVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 31/08/22.
//

import UIKit
import DropDown

let displayDate = "dd/MM/yyyy HH:mm:ss"
let serverDate = "yyyy-MM-dd HH:mm:ss"

class FeedbackVC: UIViewController {
    
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var buttonBus: UIButton!
    @IBOutlet weak var buttonMetro: UIButton!
    @IBOutlet weak var ratingView: StarRatingView!
    @IBOutlet weak var btnCategory: UIButton!
    @IBOutlet weak var lblChraCount: UILabel!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var txtLine: UITextField!
    @IBOutlet weak var btnDateTime: UIButton!
    @IBOutlet weak var txtDescription: PlaceHolderTextView!
    let datePicker = UIDatePicker()
    
    var objViewModel = FeedBackViewModel()
    var arrCategory = [feedbackCategoryModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.actionTransportMediaChnage(buttonMetro)
        setDatePicker()
        
        objViewModel.delegate = self
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
        objViewModel.getFeeddBackCategory()
        
        txtDescription.placeholder = "description".LocalizedString
        
        let formatter = DateFormatter()
        formatter.dateFormat = displayDate
        txtDate.text = formatter.string(from:Date())
        
        
        
        buttonMetro.setImage(UIImage(named: "metroSelected"), for:.selected)
        buttonMetro.setImage(UIImage(named: "metroUnselected"), for:.normal)
        buttonBus.setImage(UIImage(named: "busUnselected"), for:.normal)
        buttonBus.setImage(UIImage(named: "busSelected"), for:.selected)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func setDatePicker() {
        //Format Date
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        datePicker.maximumDate = Date()
        datePicker.minimumDate = Calendar.current.date(byAdding: .month, value: -1, to: Date())
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        } else {
            // Fallback on earlier versions
        }
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        txtDate.inputAccessoryView = toolbar
        txtDate.inputView = datePicker
        txtDate.text = ""
    }
    
    
    // SET UP DATE PICKER
    @objc func doneDatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = displayDate
        txtDate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    
    @IBAction func actionUploadDocument(_ sender: Any) {
        DocumentPicker.shared.showActionSheet(vc: self) { doc in
            if let docName = doc{
               // self.btnProfile .setImage(docName, for: .normal)
              //  self.imgProfile.image = docName
                self.btnUpload .setImage(docName, for: .normal)
            }
            
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    @IBAction func actionSelectDateTime(_ sender: Any) {
        
    }
    
    @IBAction func actionTransportMediaChnage(_ sender: UIButton) {
        if sender == buttonMetro {
            buttonMetro.isSelected = true
            buttonBus.isSelected = false
           
        }else if sender == buttonBus {
            buttonMetro.isSelected = false
            buttonBus.isSelected = true
        }
    }
    

    @IBAction func actionSelectCategory(_ sender: UIButton) {
        
        
        let arr = arrCategory.compactMap { obj in
            return obj.strFeedbackCategory
        }
        let dropDown = DropDown()
        // The view to which the drop down will appear on
        dropDown.anchorView = sender // UIView or UIBarButtonItem

        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = arr
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
           // currenIndex = index
            sender .setTitle(item, for: .normal)
        }
        dropDown.show()
        
    }
    
    @IBAction func actionSubmit(_ sender: Any) {
        
        if btnCategory.titleLabel?.text == "select_category".LocalizedString {
            objViewModel.inputErrorMessage.value = "sel_feedback_cat".LocalizedString
        }else if txtDescription.text.trim().isEmpty {
            objViewModel.inputErrorMessage.value = "enter_desc".LocalizedString
        }else {
            
            let objdata = arrCategory.first { obj in
                return obj.strFeedbackCategory == btnCategory.titleLabel?.text
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = displayDate
            let date = formatter.date(from: txtDate.text ?? "")  ?? Date()
            formatter.dateFormat = serverDate
          
            
            let img = btnUpload.image(for: .normal)
            
            var data:Data?
            if img?.pngData() != UIImage(named: "upload")?.pngData() {
                data = img?.jpegData(compressionQuality: 0.5)
            }
            
            
            
            var param = [String:Any]()
            param["strRating"] = ratingView.rating
            param["strDescription"] =  txtDescription.text
            param["strLine"] = txtLine.text
            param["dteFeedback"] = formatter.string(from: date)
            param["intUserID"] = Helper.shared.objloginData?.intUserID
            param["intFeedbackCategoryID"] = objdata?.intFeedbackCategoryID
            param["intTransportMode"] = buttonMetro.isSelected ? TransportMode.Metro.rawValue :TransportMode.Bus.rawValue
            
            
       
            ApiRequest.shared.requestPostMethodForMultipart(strurl: apiName.insertFeedback, fileName: "feedback.jpg", fileData: data, params: param, showProgress: true) { suces, param in
                
                if suces ,let issuccess = param?["issuccess"] as? Bool,issuccess {
                    
                }
                
            }

        }
        
        
        
    }
   

}
extension FeedbackVC:ViewcontrollerSendBackDelegate {
    func getInformatioBack<T>(_ handleData: inout T) {
        if let data = handleData as? [feedbackCategoryModel] {
            arrCategory = data
        }
        
       
    }
}
