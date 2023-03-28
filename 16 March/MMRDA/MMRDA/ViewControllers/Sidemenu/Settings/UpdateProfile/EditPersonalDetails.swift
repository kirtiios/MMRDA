//
//  EditPersonalDetails.swift
//  MMRDA
//
//  Created by Sandip Patel on 02/09/22.
//

import UIKit
import SDWebImage

class EditPersonalDetails: UIViewController, ViewcontrollerSendBackDelegate {
    func getInformatioBack<T>(_ handleData: inout T) {
        if let data = handleData as? [EditProfileModel] {
            objProfile = data.first
        }
    }
    
    
    @IBOutlet weak var btnImgProfile: UIButton!
    @IBOutlet weak var imgprofile: UIImageView!
    @IBOutlet weak var btnOther: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var popupView: UIView!
    var objProfile:EditProfileModel?
    var isProfileUpdate = Bool()
    var completionblock:(()->Void)?
    private var  objViewModel = EditProfileModelView()
    @IBOutlet weak var lblerror: UILabel!
    
    var profileSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 6
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        txtFullName.text = objProfile?.strFullName ?? Helper.shared.objloginData?.strFullName
        txtFullName.delegate = self
        lblerror.textColor = UIColor(hexString: "#FF0000")
        
        
        if objProfile?.strGender?.trim().isEmpty ?? false == false {
            if  objProfile?.strGender?.lowercased() == "male".lowercased() {
                btnMale.isSelected = true
            }
            else if  objProfile?.strGender?.lowercased() == "female".lowercased() {
                btnFemale.isSelected = true
            }else {
                btnOther.isSelected = true
            }
        }
        self.btnImgProfile.layer.cornerRadius = self.btnImgProfile.frame.size.width/2
        self.btnImgProfile.layer.masksToBounds = true
      
        if let url = URL(string: (objProfile?.strProfileURL ?? "").addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? "") {
            btnImgProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
            btnImgProfile.sd_setImage(with: url, for: .normal, placeholderImage: UIImage(named:"Profile"), context: [:])
         
        }else {
//
            
            if let url = URL(string: Helper.shared.objloginData?.strProfileURL?.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? "") {
                btnImgProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
                btnImgProfile.sd_setImage(with: url, for: .normal, placeholderImage: UIImage(named:"Profile"), context: nil)
            }else{
                btnImgProfile .setImage(UIImage(named:"Profile"), for: .normal)
            }
        }
        
       
      
        // Do any additional setup after loading the view.
    }
    

    @IBAction func actionClose(_ sender: Any) {
        objViewModel.delegate = self
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
        objViewModel.getProfileDetail()
        self.dismiss(animated:true)
    }
    
    
    @IBAction func actionEditProfile(_ sender: Any) {
        DocumentPicker.shared.showActionSheet(vc: self,captureType: .photo) { doc in
            if let docName = doc{
               // self.btnProfile .setImage(docName, for: .normal)
              //  self.imgProfile.image = docName
                self.btnImgProfile .setImage(docName as! UIImage, for: .normal)
                self.isProfileUpdate = true
                self.profileSelected = true
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func actionGenderChange(_ sender: UIButton) {
        
        btnMale.isSelected = false
        btnFemale.isSelected = false
        btnOther.isSelected = false
        
        sender.isSelected = true
        
    }
    
    @IBAction func actionSaveDetails(_ sender: Any) {
        
        if txtFullName.text?.trim().isEmpty ?? false {
            self.lblerror.text = "pls_enter_fullname".LocalizedString
        }
        else if txtFullName.text?.trim().isAlphabet == false || txtFullName.text?.isValidHtmlString() ?? false {
            self.lblerror.text = "pls_enter_name".LocalizedString
        }
        else if btnMale.isSelected == false && btnFemale.isSelected == false && btnOther.isSelected == false {
            self.lblerror.text = "pls_sel_gender".LocalizedString
        }
        else {
            var gender = "other"
            if btnMale.isSelected {
                gender = "male"
            }
            else if btnFemale.isSelected {
                gender = "female"
            }
            //            intUserID
            //            strFullName
            //            strGender  // male or female or other
            //            lan
            //            strProfileURL
            
            let img = btnImgProfile.image(for: .normal)
            var param = [String:Any]()
            var data:Data?
            if isProfileUpdate {
                data = img?.jpegData(compressionQuality: 0.5)
            }
            else if Helper.shared.objloginData?.strProfileURL != nil {
                if profileSelected == true{
                    param["strProfileURL"] = Helper.shared.objloginData?.strProfileURL
                }else{
                    param["strProfileURL"] = ""
                }
                
            }
             
          
            param["strFullName"] = txtFullName.text
            param["strGender"] = gender
            param["intUserID"] = Helper.shared.objloginData?.intUserID
            
            ApiRequest.shared.requestPostMethodForMultipart(strurl: apiName.updateProfile, fileName: "profile.jpg", fileParam: "strProfileURL", fileData: data, params: param, showProgress: true) { suces, param in
                if suces ,let issuccess = param?["issuccess"] as? Bool,issuccess {
                    self.completionblock?()
                    self.showAlertViewWithMessageAndActionHandler("update_personal_details".localized(), message: "") {
                        self.objViewModel.delegate = self
                        self.objViewModel.inputErrorMessage.bind { [weak self] in
                            if let message = $0,message.count > 0 {
                                DispatchQueue.main.async {
                                    self?.showAlertViewWithMessage("", message:message)
                                }
                            }
                        }
                     
                        self.dismiss(animated: true)
                    }
                }
            }
            
        }
    }

}
extension EditPersonalDetails:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         if textField == txtFullName {
            let maxLength = 50
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
         }else {
             return true
         }
    }
}
