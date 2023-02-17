//
//  LoginVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 17/08/22.
//

import UIKit
import ACFloatingTextfield_Swift
import LocalAuthentication
import CountryPickerView

class LoginVC: UIViewController {

    @IBOutlet weak var mpinContainerView: UIView!
    @IBOutlet weak var SegmentUserID: UIButton!
    @IBOutlet weak var btnRememberMe: UIButton!
    @IBOutlet weak var userIDView: UIStackView!
    @IBOutlet weak var SegmentMPIN: UIButton!
    @IBOutlet weak var mpinView: UIStackView!
    @IBOutlet weak var userIDContainerView: UIView!
    
    @IBOutlet weak var textMPin: ACFloatingTextfield!
    @IBOutlet weak var textPassword: ACFloatingTextfield!
    @IBOutlet weak var textMobilEmail: ACFloatingTextfield!
    @IBOutlet weak var lblLoginLink: UILabel!
    @IBOutlet weak var lblRegisterLink: UILabel!
    
    @IBOutlet weak var lblErroMpin: UILabel!
    
    @IBOutlet weak var btntouchID: UIButton!
    @IBOutlet weak var countryView: CountryPickerView!
    @IBOutlet weak var lblerror: UILabel!
    var context = LAContext()
    var objLoginViewModel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        textMobilEmail.text = "9624946132"
//        textPassword.text = "Test@123"
        
        lblerror.textColor = UIColor(hexString: "#FF0000")
        lblErroMpin.textColor = UIColor(hexString: "#FF0000")
        if UserDefaults.standard.bool(forKey: userDefaultKey.logedRememberMe.rawValue) {
            if let usernameData = KeyChain.load(key:keyChainConstant.username) {
                textMobilEmail.text = String(decoding: usernameData, as: UTF8.self)
            }
            if let passwordData = KeyChain.load(key:keyChainConstant.password) {
                textPassword.text = String(decoding:passwordData, as: UTF8.self)
            }
            btnRememberMe.isSelected = true
        }
        
   
        
//        ApiRequest.shared.requestGetMethod(strurl: "https://maps.kdmc.gov.in/agserver/rest/services/SKDCL_BASEMAP_24_03_2022/MapServer/13/query?where=&text=&objectIds=&time=&geometry=%7B%22x%22%20:%2773.10990785145411%27,%20%22y%22%20:%2719.20997951660038%27,%20%22spatialReference%22%20:%20%7B%22wkid%22%20:%204326%7D%7D&geometryType=esriGeometryPoint&inSR=4326&spatialRel=esriSpatialRelWithin&relationParam=&outFields=WARD_ID&returnGeometry=false&returnTrueCurves=false&maxAllowableOffset=&geometryPrecision=&outSR=&having=&returnIdsOnly=false&returnCountOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&gdbVersion=&historicMoment=&returnDistinctValues=false&resultOffset=&resultRecordCount=&queryByDistance=&returnExtentOnly=false&datumTransformation=&parameterValues=&rangeValues=&quantizationParameters=&featureEncoding=esriDefault&f=geojson", params:[String:String](), showProgress: true) { sucess, data in
//
//        }
        
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialize()
        btntouchID.isHidden = false
        if Helper.shared.objloginData == nil {
            btntouchID.isHidden = true
        }
    }
    
    @IBAction func actionSegmentChnage(_ sender: UIButton) {
        lblerror.text = nil
        lblErroMpin.text = nil
        if sender.tag == 101 {
            userIDView.isHidden = true
            mpinView.isHidden = false
            mpinContainerView.backgroundColor = Colors.APP_Theme_color.value
            userIDContainerView.backgroundColor = UIColor.lightGray
            SegmentMPIN.setTitleColor(Colors.APP_Theme_color.value, for:.normal)
            SegmentMPIN.backgroundColor = UIColor.white
            SegmentUserID.setTitleColor(UIColor.gray, for:.normal)
        }else{
            userIDView.isHidden = false
            mpinView.isHidden = true
            userIDContainerView.backgroundColor = Colors.APP_Theme_color.value
            mpinContainerView.backgroundColor = UIColor.lightGray
            SegmentUserID.setTitleColor(Colors.APP_Theme_color.value, for:.normal)
            SegmentUserID.backgroundColor = UIColor.white
            SegmentMPIN.setTitleColor(UIColor.gray, for:.normal)
        }
        
        
    }
    
    @IBAction func actionLogin(_ sender: Any) {
        
       
        
        if userIDView.isHidden == false {
            if textMobilEmail.text?.trim().isEmpty ?? false {
                objLoginViewModel.inputErrorMessage.value = "pls_enter_email_id".LocalizedString
            }
            else if textMobilEmail.text?.trim().isNumeric ?? false &&  textMobilEmail.text?.trim().mobileNumberValidation() == false {
                objLoginViewModel.inputErrorMessage.value = "enter_valid_mobile_number".LocalizedString
            }else if  textMobilEmail.text?.trim().isValidEmail() == false && textMobilEmail.text?.trim().isNumeric ?? false == false  {
                objLoginViewModel.inputErrorMessage.value = "pls_enter_valid_emailid".LocalizedString
            }
            else if textPassword.text?.trim().count ?? 0 < 1 {
                objLoginViewModel.inputErrorMessage.value =  "pls_enter_valid_pass".LocalizedString
            }
            else {
                
                objLoginViewModel.isloginViaMPIN = false
                objLoginViewModel.strEmailMobile = textMobilEmail.text ?? ""
                objLoginViewModel.isRememberMe = self.btnRememberMe.isSelected
                objLoginViewModel.strPassword = Helper.shared.passwordEncryptedsha256(str: textPassword.text ?? "")
                objLoginViewModel.submitLogin()
                
                // UserDefaults.standard.set((self.btnRememberMe.isSelected) ? true : false, forKey: userDefaultKey.logedRememberMe.rawValue)
                
                if  let data = self.textMobilEmail.text?.data(using: .utf8) {
                    let status = KeyChain.save(key: keyChainConstant.username, data:data)
                    print(status)
                }
                if let data = self.textPassword.text?.data(using: .utf8) {
                    let status =  KeyChain.save(key: keyChainConstant.password, data:data)
                    print(status)
                }
                UserDefaults.standard.synchronize()
                
                
            }
        }else {
            
             if textMPin.text?.trim().count ?? 0 < 1 {
                 objLoginViewModel.inputErrorMessage.value = "entermobilepin".LocalizedString
             }else {
                 objLoginViewModel.strMobilePIN =  Helper.shared.passwordEncryptedsha256(str:textMPin.text ?? "")
                 objLoginViewModel.strEmailMobile = Helper.shared.objloginData?.strMobileNo ?? ""
                 objLoginViewModel.isloginViaMPIN = true
                 objLoginViewModel.submitLogin()
             }
            
        }
        
        
        
//        self.showAlertViewWithMessageCancelAndActionHandler("APPTITLE".LocalizedString, message:"tv_are_you_want_to_set_mpin".LocalizedString) {
//            let root = UIWindow.key?.rootViewController!
//            if let firstPresented = UIStoryboard.SetupMPINVC() {
//                firstPresented.modalTransitionStyle = .crossDissolve
//                firstPresented.modalPresentationStyle = .overCurrentContext
//                root?.present(firstPresented, animated: false, completion: nil)
//            }
//        }
        
    }
    
    
    // MARK:Open SingupPage
    
    @IBAction func actionpenRegisterVC(_ sender: Any) {
        let vc = UIStoryboard.SignUpVC()
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func actionTickMark(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
    }
    
    @IBAction func actionForgotPIN(_ sender: Any) {
        let vc = UIStoryboard.ForgotMobilePINVC()
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func actionForgotPassword(_ sender: Any) {
        let vc = UIStoryboard.ForgotPasswordVC()
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func actionTouchid(_ sender: UIButton) {
        
        
        Helper.shared.authenticationWithTouchID { sucess in
            if sucess {
                DispatchQueue.main.async {
                    self.objLoginViewModel.strEmailMobile = ""
                    self.objLoginViewModel.strPassword = ""
                    self.objLoginViewModel.submitLogin()
                }
            }
        }
       
    }
    
   

}


extension LoginVC {
    private func initialize() {
        self.navigationController?.navigationBar.isHidden = true
     
        textMPin.keyboardType = .numberPad
        lblRegisterLink.attributedText =  "donthaveaccount".LocalizedString.getAttributedStrijng(titleString: "donthaveaccount".LocalizedString, subString:"signup".LocalizedString, subStringColor: Colors.APP_Theme_color.value)
        lblLoginLink.attributedText = "donthaveaccount".LocalizedString.getAttributedStrijng(titleString: "donthaveaccount".LocalizedString, subString:"signup".LocalizedString, subStringColor: Colors.APP_Theme_color.value)
        
        lblRegisterLink.isUserInteractionEnabled = true
        lblRegisterLink.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
        
        textMPin.delegate = self
        
        lblLoginLink.isUserInteractionEnabled = true
        lblLoginLink.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
        
        objLoginViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.lblerror.text = message
                    self?.lblErroMpin.text =  message
                }
            }
        }
        countryView.dataSource = self
        countryView.setCountryByCode("IN")
        countryView.showCountryNameInView = false
        countryView.showCountryCodeInView = false
        countryView.isHidden = true
        
        mpinContainerView.superview?.superview?.isHidden = true
        if UserDefaults.standard.bool(forKey:userDefaultKey.isMpinEnable.rawValue) && Helper.shared.objloginData?.strMobileNo?.isEmpty == false  {
            mpinContainerView.superview?.superview?.isHidden = false
            self.actionSegmentChnage(SegmentMPIN)
        }else {
            self.actionSegmentChnage(SegmentUserID)
        }
        
        if textMobilEmail.text?.isNumeric ?? false {
            countryView.isHidden = false
        }
    }
    @objc func tapLabel(gesture: UITapGestureRecognizer) {
        let termsRange = (lblRegisterLink.text! as NSString).range(of: "signup".LocalizedString)
        // comment for now
        //let privacyRange = (text as NSString).range(of: "Privacy Policy")
        
        if gesture.didTapAttributedTextInLabel(label: lblRegisterLink, inRange: termsRange) {
            let vc = UIStoryboard.SignUpVC()
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }
        
        else if gesture.didTapAttributedTextInLabel(label: lblLoginLink, inRange: termsRange) {
            let vc = UIStoryboard.SignUpVC()
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }

    }
}
extension LoginVC:ViewcontrollerSendBackDelegate {
    func getInformatioBack<T>(_ handleData: inout T) {
        
    }
    
    // 72290 46094
}
extension LoginVC {
    

    
    
}
extension LoginVC:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == textMPin {
            let maxLength = 4
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
         
        }else if textField == textMobilEmail{
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            if (newString as String).isNumeric {
                countryView.isHidden = false
                textField.placeholder = "lbl_mobile_number".localized()
                return newString.length <= maxLength
            }else {
                textField.placeholder = "tv_enter_email_mobile".localized()
                countryView.isHidden = true
            }
            return true
        }else {
            return true
        }
    }
}
extension LoginVC: CountryPickerViewDataSource {
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
