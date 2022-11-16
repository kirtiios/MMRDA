//
//  GrivinaceSubmitVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 01/09/22.
//

import UIKit
import ACFloatingTextfield_Swift
import DropDown

class GrivinaceSubmitVC: UIViewController {

    @IBOutlet weak var lblFileName: UILabel!
    @IBOutlet weak var btnUploadFile: UIButton!
    @IBOutlet weak var txtProblemDescription: ACFloatingTextfield!
    @IBOutlet weak var txtIncidentTime: ACFloatingTextfield!
    @IBOutlet weak var btnBus: UIButton!
    @IBOutlet weak var btnSubcategory: UIButton!
    @IBOutlet weak var btnCategory: UIButton!
  
    @IBOutlet weak var btnRoute: UIButton!
    @IBOutlet weak var btnVehcile: UIButton!
    @IBOutlet weak var btnMetro: UIButton!
    
    private var objViewModel = GrivanceViewModel()
    var arrcategory:[grivanceCategory]?
    var arrSubcategory:[grivanceSubCategory]?
    var arrVechicle:[grivanceVechicleList]?
    var arrRouteList:[grivanceRouteList]?
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
        objViewModel.getCategoryList { arr in
            self.arrcategory = arr
        }
        
        
        objViewModel.getRouteList { arr in
            self.arrRouteList = arr
        }

        self.setDatePicker()
        self.initialize()
        btnMetro.sendActions(for: .touchUpInside)
        self.doneDatePicker()
//        objViewModel.getVechicleList { arr in
//            self.arrVechicle = arr
//        }

        // Do any additional setup after loading the view.
    }
    

    @IBAction func actionTransportMediaChnage(_ sender: UIButton) {
        if sender.tag == 101 {
            btnMetro.setBackgroundImage(UIImage(named: "metroSelected"), for:.normal)
            btnBus.setBackgroundImage(UIImage(named:"busUnselected"), for:.normal)
        }else if sender.tag == 102 {
            btnMetro.setBackgroundImage(UIImage(named:"metroUnselected"), for:.normal)
            btnBus.setBackgroundImage(UIImage(named:"busSelected"), for:.normal)
        }
        
    }
    func setDatePicker() {
        //Format Date
        datePicker.datePickerMode = .dateAndTime
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
        let doneButton = UIBarButtonItem(title: "done".localized(), style: .plain, target: self, action: #selector(doneDatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "cancel".localized(), style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        txtIncidentTime.inputAccessoryView = toolbar
        txtIncidentTime.inputView = datePicker
        txtIncidentTime.text = ""
    }
    // SET UP DATE PICKER
    @objc func doneDatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = displayDate
        txtIncidentTime.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
        formatter.dateFormat = serverDate
        objViewModel.strDate = formatter.string(from:  datePicker.date)
        
       
    }
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    
    @IBAction func actionSelectRoute(_ sender: UIButton) {
        let arr = arrRouteList?.compactMap { obj in
            return obj.strRouteName
        }
        let dropDown = DropDown()
        dropDown.anchorView = sender
        dropDown.dataSource = arr ?? [String]()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.objViewModel.objRoute = arrRouteList?[index]
            sender.setTitle(item, for: .normal)
        }
        dropDown.show()
        
    }
    @IBAction func actionSelectVehcile(_ sender: UIButton) {
        let arr = arrVechicle?.compactMap { obj in
            return obj.strVehicleCode
        }
        let dropDown = DropDown()
        dropDown.anchorView = sender
        dropDown.dataSource = arr ?? [String]()
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self?.objViewModel.objVechicle = self?.arrVechicle?[index]
            sender.setTitle(item, for: .normal)
        }
        dropDown.show()
    }
    @IBAction func acrionSubCategory(_ sender: UIButton) {
        let arr = arrSubcategory?.compactMap { obj in
            return obj.strItemName
        }
        let dropDown = DropDown()
        dropDown.anchorView = sender
        dropDown.dataSource = arr ?? [String]()
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self?.objViewModel.objSubCategory = self?.arrSubcategory?[index]
            sender.setTitle(item, for: .normal)
            
        }
        dropDown.show()
    }
    @IBAction func actionSelectCategory(_ sender: UIButton) {
        let arr = arrcategory?.compactMap { obj in
            return obj.strComplainCategoryName
        }
        let dropDown = DropDown()
        dropDown.anchorView = sender
        dropDown.dataSource = arr ?? [String]()
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            sender.setTitle(item, for: .normal)
            self?.objViewModel.objCategory = self?.arrcategory?[index]
            self?.objViewModel.objSubCategory = nil
            self?.btnSubcategory.setTitle("txtSelectSubcategory".localized(), for: .normal)
            self?.objViewModel.getSubCategoryList(categoryid: self?.arrcategory?[index].intComplainCategoryID ?? 0) { arr in
                self?.arrSubcategory = arr
            }
           
        }
        dropDown.show()
        
    }
    @IBAction func actionUploadFile(_ sender: UIButton) {
        DocumentPicker.shared.showActionSheet(vc: self) { doc in
            if let docName = doc{
                self.btnUploadFile.setBackgroundImage(docName, for: .normal)
                self.lblFileName.text = self.randomString(8) + ".jpg"
            }
            self.dismiss(animated:true)
        }
    }
    func randomString(_ length: Int) -> String {

        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)

        var randomString = ""

        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }

        return randomString
    }
   private func initialize(){
        txtProblemDescription.text = nil
        self.btnCategory .setTitle("select_category".localized(), for: .normal)
        self.btnSubcategory .setTitle("txtSelectSubcategory".localized(), for: .normal)
        self.btnRoute .setTitle("txtSelectRoute".localized(), for: .normal)
        self.btnVehcile .setTitle("txtSelectBus".localized(), for: .normal)
        
        objViewModel.objCategory = nil
        objViewModel.objSubCategory = nil
        objViewModel.objVechicle = nil
        objViewModel.objRoute = nil
        objViewModel.strDescription = nil
       self.btnUploadFile.setBackgroundImage(UIImage(named: "upload"), for: .normal)
     
    }
    @IBAction func actionSubmit(_ sender: UIButton) {
        
        let img = btnUploadFile.backgroundImage(for: .normal)
        var data:Data?
        if img?.pngData() != UIImage(named:"upload")?.pngData() {
            data = img?.jpegData(compressionQuality: 0.5)
        }
        self.objViewModel.data = data
        self.objViewModel.strDescription = txtProblemDescription.text
        
        
        self.objViewModel.submitGrinacne { sucess in
            
            if sucess {
                let firstPresented = AlertViewVC(nibName:"AlertViewVC", bundle: nil)
                firstPresented.strMessage = "thanksforfeedback".LocalizedString
                firstPresented.img = UIImage(named:"ic_thanks_feedback")!
                firstPresented.isHideCancel = true
                firstPresented.okButtonTitle = "ok".LocalizedString
                firstPresented.completionOK = {
                    self.initialize()
                    NotificationCenter.default.post(name:Notification.GrivanceUpdated, object: nil)
                }
                firstPresented.modalPresentationStyle = .overCurrentContext
                APPDELEGATE.topViewController!.present(firstPresented, animated: true, completion: nil)
                
            }
        }
    }
}
