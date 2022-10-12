//
//  LoginVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 17/08/22.
//

import UIKit
import ACFloatingTextfield_Swift
import LocalAuthentication

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
    
    @IBOutlet weak var btntouchID: UIButton!
    var context = LAContext()
    var objLoginViewModel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        textMobilEmail.text = "9624946132"
//        textPassword.text = "Test@123"
        
        if UserDefaults.standard.bool(forKey: userDefaultKey.logedRememberMe.rawValue) {
            if let usernameData = KeyChain.load(key: keyChainConstant.username) {
                textMobilEmail.text = String(decoding: usernameData, as: UTF8.self)
            }
            if let passwordData = KeyChain.load(key: keyChainConstant.password) {
                textPassword.text = String(decoding: passwordData, as: UTF8.self)
            }
            btnRememberMe.isSelected = true
        }
        mpinContainerView.superview?.superview?.isHidden = true
        mpinContainerView.superview?.superview?.isHidden = true
        if UserDefaults.standard.bool(forKey:userDefaultKey.isMpinEnable.rawValue) && Helper.shared.objloginData?.strMobileNo?.isEmpty == false  {
            mpinContainerView.superview?.superview?.isHidden = false
            mpinContainerView.superview?.superview?.isHidden = false
        }
        
        if Helper.shared.objloginData != nil {
            
        }
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialize()
    }
    
    @IBAction func actionSegmentChnage(_ sender: UIButton) {
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
                if textMobilEmail.text?.trim().isNumeric ?? false &&  textMobilEmail.text?.trim().mobileNumberValidation() == false {
                    objLoginViewModel.inputErrorMessage.value = "pls_enter_email_id".LocalizedString
                }else if  textMobilEmail.text?.trim().isValidEmail() == false  {
                    objLoginViewModel.inputErrorMessage.value = "pls_enter_valid_emailid".LocalizedString
                }
                
                
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
            
             if textMPin.text?.trim().count ?? 0 < 4 {
                 objLoginViewModel.inputErrorMessage.value = "entervalidmpin".LocalizedString
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
        
        self.authenticationWithTouchID()
    }
    
   

}


extension LoginVC {
    private func initialize() {
        self.navigationController?.navigationBar.isHidden = true
        self.actionSegmentChnage(SegmentUserID)
        textMPin.keyboardType = .numberPad
        lblRegisterLink.attributedText =  "donthaveaccount".LocalizedString.getAttributedStrijng(titleString: "donthaveaccount".LocalizedString, subString:"signup".LocalizedString, subStringColor: Colors.APP_Theme_color.value)
        lblLoginLink.attributedText =  "donthaveaccount".LocalizedString.getAttributedStrijng(titleString: "donthaveaccount".LocalizedString, subString:"signup".LocalizedString, subStringColor: Colors.APP_Theme_color.value)
        
        lblRegisterLink.isUserInteractionEnabled = true
        lblRegisterLink.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
        
        textMPin.delegate = self
        
        lblLoginLink.isUserInteractionEnabled = true
        lblLoginLink.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
        
        objLoginViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
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
    
    func authenticationWithTouchID() {
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = "Use Passcode"

        var authError: NSError?
        let reasonString = "To access the secure data"

        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError) {
            
            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reasonString) { success, evaluateError in
                
                if success {
                    
                    DispatchQueue.main.async {
                        self.objLoginViewModel.strEmailMobile = ""
                        self.objLoginViewModel.strPassword = ""
                        self.objLoginViewModel.submitLogin()
                    }
                    //TODO: User authenticated successfully, take appropriate action
                    
                } else {
                    //TODO: User did not authenticate successfully, look at error and take appropriate action
                    guard let error = evaluateError else {
                        return
                    }
                    let message = self.evaluateAuthenticationPolicyMessageForLA(errorCode: error._code)
                    DispatchQueue.main.async {
                        self.showAlertViewWithMessage("", message:message)
                    }
                   
                  //  print(self.evaluateAuthenticationPolicyMessageForLA(errorCode: error._code))
                    
                    //TODO: If you have choosen the 'Fallback authentication mechanism selected' (LAError.userFallback). Handle gracefully
                    
                }
            }
        } else {
            
            guard let error = authError else {
                return
            }
            DispatchQueue.main.async {
                self.showAlertViewWithMessage("", message:self.evaluateAuthenticationPolicyMessageForLA(errorCode: error.code))
            }
            //TODO: Show appropriate alert if biometry/TouchID/FaceID is lockout or not enrolled
            print(self.evaluateAuthenticationPolicyMessageForLA(errorCode: error.code))
        }
    }
    
    func evaluatePolicyFailErrorMessageForLA(errorCode: Int) -> String {
        var message = ""
        if #available(iOS 11.0, macOS 10.13, *) {
            switch errorCode {
                case LAError.biometryNotAvailable.rawValue:
                    message = "Authentication could not start because the device does not support biometric authentication."
                
                case LAError.biometryLockout.rawValue:
                    message = "Authentication could not continue because the user has been locked out of biometric authentication, due to failing authentication too many times."
                
                case LAError.biometryNotEnrolled.rawValue:
                    message = "Authentication could not start because the user has not enrolled in biometric authentication."
                
                default:
                    message = "Did not find error code on LAError object"
            }
        } else {
            switch errorCode {
                case LAError.touchIDLockout.rawValue:
                    message = "Too many failed attempts."
                
                case LAError.touchIDNotAvailable.rawValue:
                    message = "TouchID is not available on the device"
                
                case LAError.touchIDNotEnrolled.rawValue:
                    message = "TouchID is not enrolled on the device"
                
                default:
                    message = "Did not find error code on LAError object"
            }
        }
        
        return message;
    }
    
    func evaluateAuthenticationPolicyMessageForLA(errorCode: Int) -> String {
        
        var message = ""
        
        switch errorCode {
            
        case LAError.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials"
            
        case LAError.appCancel.rawValue:
            message = "Authentication was cancelled by application"
            
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.notInteractive.rawValue:
            message = "Not interactive"
            
        case LAError.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"
            
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
            
        case LAError.userCancel.rawValue:
            message = "The user did cancel"
            
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"

        default:
            message = evaluatePolicyFailErrorMessageForLA(errorCode: errorCode)
        }
        
        return message
    }
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
                return newString.length <= maxLength
            }
            return true
        }else {
            return true
        }
    }
}
