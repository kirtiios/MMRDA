//
//  EditLoginDetailsVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 05/09/22.
//

import UIKit
import Localize_Swift
import CountryPickerView

class EditLoginDetailsVC: UIViewController {
    
    @IBOutlet weak var txtEmailOrMobile: UITextField!
    @IBOutlet weak var btnMobileNumber: UIButton!
    
    @IBOutlet weak var countryView: CountryPickerView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var viewMobile: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var lblerror: UILabel!
    var objProfile:EditProfileModel?
    var completionblock:(()->Void)?
    var objViewModel = setPasswordViewModel()
    var isEmail = false
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 6
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        txtEmailOrMobile.delegate = self
        actionSegmentChnage(btnEmail)
        lblerror.textColor = UIColor(hexString: "#FF0000")
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    //self?.showAlertViewWithMessage("", message:message)
                    self?.lblerror.text = message
                }
            }
        }
        //objsetPasswordViewModel.dict = param
        objViewModel.bindViewModelToForgotController =  { param,message  in
            //            let vc = UIStoryboard.OTPVerifyVC()
            //            vc?.param = param
            //            vc?.isVerifyOTPFor = OTPVerify.ForgotPassword
            //            self.navigationController?.pushViewController(vc!, animated:true)
            
            let firstPresented = UIStoryboard.ChnagepasswordVerifyOtpVC()!
            firstPresented.param = param
            firstPresented.completionBlock = {
                self.dismiss(animated: true)
                self.completionblock?()
            }
            firstPresented.strMobileorEmail = self.objViewModel.strMobilOReEmail
            firstPresented.modalTransitionStyle = .crossDissolve
            firstPresented.modalPresentationStyle = .overCurrentContext
            self.present(firstPresented, animated: false, completion: nil)
            
        }
        countryView.dataSource = self
        countryView.setCountryByCode("IN")
        countryView.showCountryNameInView = false
        countryView.showCountryCodeInView = false
        countryView.isHidden = true
       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionSegmentChnage(_ sender: UIButton) {
        if sender.tag == 101 {
           // btnEmail.titleLabel?.textColor = UIColor.white
            btnEmail .setTitleColor(UIColor.white, for: .normal)
            btnEmail.backgroundColor = Colors.APP_Theme_color.value
            btnMobileNumber.setTitleColor(Colors.APP_Theme_color.value, for: .normal)
            btnMobileNumber.backgroundColor = UIColor.white
            txtEmailOrMobile.placeholder = "email".LocalizedString
            lblTitle.text = "email".LocalizedString
            txtEmailOrMobile.text = objProfile?.strEmailID ?? Helper.shared.objloginData?.strEmailID
            txtEmailOrMobile.keyboardType = .default
            isEmail = true
            countryView.isHidden = true
            
        }else{
            btnMobileNumber.setTitleColor( UIColor.white, for: .normal)
            btnMobileNumber.backgroundColor = Colors.APP_Theme_color.value
          //  btnEmail.titleLabel?.textColor = Colors.APP_Theme_color.value
            btnEmail .setTitleColor(Colors.APP_Theme_color.value, for: .normal)
            btnEmail.backgroundColor = UIColor.white
            txtEmailOrMobile.placeholder = "lbl_mobile_number".LocalizedString
            lblTitle.text = "lbl_mobile_number".LocalizedString
            txtEmailOrMobile.text = objProfile?.strMobileNo ??  Helper.shared.objloginData?.strMobileNo
            txtEmailOrMobile.keyboardType = .numberPad
            isEmail = false
            countryView.isHidden = false
            
        }
        
    }
    
    
    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func actionSave(_ sender: Any) {
        
        if isEmail && txtEmailOrMobile.text != objProfile?.strEmailID || isEmail == false &&  txtEmailOrMobile.text != objProfile?.strMobileNo {
            
            if isEmail && (txtEmailOrMobile.text ?? "").isValidEmail() == false {
                objViewModel.inputErrorMessage.value = "pls_enter_valid_email_id".LocalizedString
            } else if isEmail == false && (txtEmailOrMobile.text ?? "").mobileNumberValidation() == false {
                objViewModel.inputErrorMessage.value = "pls_enter_valid_mobile_number".LocalizedString
            }else {
                objViewModel.strMobilOReEmail = txtEmailOrMobile.text ?? ""
                objViewModel.loginChangeSendOTP()
            }
        }
        
        
        
        //self.dismiss(animated: true)
        
    }
}
extension EditLoginDetailsVC:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if isEmail {
            return true
        }else {
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
    }
}
extension EditLoginDetailsVC: CountryPickerViewDataSource {
    func preferredCountries(in countryPickerView: CountryPickerView) -> [Country] {
        return ["IN"].compactMap { countryPickerView.getCountryByCode($0) }
    }
    
    func sectionTitleForPreferredCountries(in countryPickerView: CountryPickerView) -> String? {
        return "Select a Country"
    }
    
    func showOnlyPreferredSection(in countryPickerView: CountryPickerView) -> Bool {
        return true
    }
    
    func navigationTitle(in countryPickerView: CountryPickerView) -> String? {
        return ""
    }
        
    func searchBarPosition(in countryPickerView: CountryPickerView) -> SearchBarPosition {
        return .tableViewHeader
    }
    
    func showPhoneCodeInList(in countryPickerView: CountryPickerView) -> Bool {
        return true
    }
    
    func showCountryCodeInList(in countryPickerView: CountryPickerView) -> Bool {
       return false
    }
}
