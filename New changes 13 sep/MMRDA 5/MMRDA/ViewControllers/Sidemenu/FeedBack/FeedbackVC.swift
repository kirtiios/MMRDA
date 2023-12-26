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
    @IBOutlet weak var ratingView: SwiftyStarRatingView!
    @IBOutlet weak var btnCategory: UIButton!
    @IBOutlet weak var lblChraCount: UILabel!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var txtLine: UITextField!
    @IBOutlet weak var btnDateTime: UIButton!
    @IBOutlet weak var txtDescription: PlaceHolderTextView!
    let datePicker = UIDatePicker()
    @IBOutlet weak var lblFileName: UILabel!
    var objViewModel = FeedBackViewModel()
    var arrCategory = [feedbackCategoryModel]()
    var objdoc:docsModel?
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
        txtDescription.delegate = self
        
        self.initialize()
        
        
        
        buttonMetro.setImage(UIImage(named: "metroSelected"), for:.selected)
        buttonMetro.setImage(UIImage(named: "metroUnselected"), for:.normal)
        buttonBus.setImage(UIImage(named: "busUnselected"), for:.normal)
        buttonBus.setImage(UIImage(named: "busSelected"), for:.selected)
        
        
        // Do any additional setup after loading the view.
    }
    func initialize(){
        txtDescription.text = nil
        txtDescription.placeholder = "description".LocalizedString
        self.btnCategory .setTitle("select_category".localized(), for: .normal)
        let formatter = DateFormatter()
        formatter.dateFormat = displayDate
        txtDate.text = formatter.string(from:Date())
        self.txtLine.text = ""
        self.btnUpload .setImage(UIImage(named: "upload"), for: .normal)
     
        self.ratingView.minimumValue = 1
        self.ratingView.maximumValue = 5
        self.ratingView.value = 5
        self.ratingView.continuous = false
        
        self.lblFileName.text = "uploaddoc".localized()
        
        self.ratingView.tintColor  = UIColor.systemOrange
        self.ratingView.shouldBeginGestureHandler = { _ in return false }
        
        
    }
    
    
    func setDatePicker() {
        //Format Date
        datePicker.datePickerMode = .dateAndTime
        datePicker.backgroundColor = .white
        datePicker.maximumDate = Date()
      //  datePicker.minimumDate = Calendar.current.date(byAdding: .month, value: -1, to: Date())
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        } else {
            // Fallback on earlier versions
        }
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "done".localized(), style: .plain, target: self, action: #selector(doneDatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "cancel".localized(), style: .plain, target: self, action: #selector(cancelDatePicker));
        
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
//            if let docName = doc{
//               // self.btnProfile .setImage(docName, for: .normal)
//              //  self.imgProfile.image = docName
//                self.btnUpload .setImage(docName as! UIImage, for: .normal)
//                self.lblFileName.text = self.randomString(8) + ".jpg"
//            }
            if let docName = doc{
                //                self.btnUploadFile.setBackgroundImage(docName as! UIImage, for: .normal)
                //                self.lblFileName.text = self.randomString(8) + ".jpg"
                if let image = docName as? UIImage {
                    // docName is an image
                    self.btnUpload.setImage(image, for: .normal)
                    //  self.btnUpload.setBackgroundImage(image, for: .normal)
                    self.lblFileName.text = self.randomString(8) + ".jpg"
                }
                
                else {
                    let a  =  docName as? docsModel
                    let b = a?.docPath
                    self.objdoc =  docName as? docsModel
                    let fileName = NSString(string:b!).lastPathComponent // "sample.pdf"
                    if let path = a?.url {
                        let url = URL(string:path)
                        if url?.fileSize ?? 0 > 10*(1024*1024) {
                            self.objViewModel.inputErrorMessage.value = "uploadLimit".LocalizedString
                            return
                        }
                    }
                    self.lblFileName.text = fileName
                  
                    
                }
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
        }else if txtDescription.text.trim().isEmpty  || txtDescription.text.trim() == "description".LocalizedString    {
            objViewModel.inputErrorMessage.value = "enter_desc".LocalizedString
        }
        else if  txtDescription.text.isValidHtmlString() {
            objViewModel.inputErrorMessage.value = "enter_vali_desc".localized()
        }
        else if  txtLine.text?.isValidHtmlString() ?? false {
            objViewModel.inputErrorMessage.value = "enter_vali_line".localized()
        }
        else {
            
            let objdata = arrCategory.first { obj in
                return obj.strFeedbackCategory == btnCategory.titleLabel?.text
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = displayDate
            let date = formatter.date(from: txtDate.text ?? "")  ?? Date()
            formatter.dateFormat = serverDate
          
            
            let img = btnUpload.image(for: .normal)
            var data:Data?
            var MimeType = "image/jpeg"
            var filename = "feedback.jpg"
            if img?.pngData() != UIImage(named: "upload")?.pngData() {
                data = img?.jpegData(compressionQuality: 0.5)
                filename = self.lblFileName.text ?? ""
            }
            else if objdoc != nil {
                MimeType = "application/pdf"
                if let url = URL(string:(objdoc?.url ?? "")) {
                    data = try? Data(contentsOf: url)
                }
                
             //   self.objViewModel.isPDFFile = true
                filename = self.lblFileName.text ?? ""
            }
            
            
            var param = [String:Any]()
            param["strRating"] = String(format:"%.f",ratingView.value)
            param["strDescription"] =  txtDescription.text
            param["strLine"] = txtLine.text
            param["dteFeedback"] = formatter.string(from: date)
            param["intUserID"] = Helper.shared.objloginData?.intUserID
            param["intFeedbackCategoryID"] = objdata?.intFeedbackCategoryID
            param["intTransportMode"] = buttonMetro.isSelected ? TransportMode.Metro.rawValue :TransportMode.Bus.rawValue
         
            
            ApiRequest.shared.requestPostMethodForMultipart(strurl: apiName.insertFeedback, fileName:filename, fileParam: "strDocumentPath", fileData: data, params: param,MimeType: MimeType, showProgress: true) { suces, param in
                
                if suces ,let issuccess = param?["issuccess"] as? Bool,issuccess {
                    
                    let firstPresented = AlertViewVC(nibName:"AlertViewVC", bundle: nil)
                    firstPresented.strMessage = "thanksforfeedback".LocalizedString
                    firstPresented.img = UIImage(named:"ic_thanks_feedback")!
                    firstPresented.isHideCancel = true
                    firstPresented.okButtonTitle = "ok".LocalizedString
                    firstPresented.completionOK = {
                        self.initialize()
                        NotificationCenter.default.post(name:Notification.FeedbackUpdated, object: nil)
                    }
                    firstPresented.modalTransitionStyle = .crossDissolve
                    firstPresented.modalPresentationStyle = .overCurrentContext
                    APPDELEGATE.topViewController!.present(firstPresented, animated: true, completion: nil)
     
                }
                else if let message = param?["message"] as? String {
                    self.objViewModel.inputErrorMessage.value = message
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
extension FeedbackVC:UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //300 chars restriction
     
        let status = textView.text.count + (text.count - range.length) <= 500
        if status {
            lblChraCount.text = "\(textView.text.count + (text.count - range.length))/500"
        }
        return status
    }
}
