//
//  LoginVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 17/08/22.
//

import UIKit
import ACFloatingTextfield_Swift


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
    
    var objLoginViewModel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textMobilEmail.text = "9624946132"
        textPassword.text = "Test@123"
        
        if UserDefaults.standard.bool(forKey: userDefaultKey.logedRememberMe.rawValue) {
            if let usernameData = KeyChain.load(key: keyChainConstant.username) {
                textMobilEmail.text = String(decoding: usernameData, as: UTF8.self)
                
            }
            if let passwordData = KeyChain.load(key: keyChainConstant.password) {
                textPassword.text = String(decoding: passwordData, as: UTF8.self)
            }
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
                
                objLoginViewModel.strEmailMobile = textMobilEmail.text ?? ""
                objLoginViewModel.strPassword = Helper.shared.passwordEncryptedsha256(str: textPassword.text ?? "")
                objLoginViewModel.submitLogin()
                
                UserDefaults.standard.set(self.btnRememberMe.isSelected ? true :false, forKey: userDefaultKey.logedRememberMe.rawValue)
                  
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
                 objLoginViewModel.inputErrorMessage.value =  "entervalidmpin".LocalizedString
             }else {
                 objLoginViewModel.strMobilePIN = textMPin.text ?? ""
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
    
   

}


extension LoginVC {
    private func initialize() {
        self.navigationController?.navigationBar.isHidden = true
        self.actionSegmentChnage(SegmentMPIN)
        textMPin.keyboardType = .numberPad
        lblRegisterLink.attributedText =  "donthaveaccount".LocalizedString.getAttributedStrijng(titleString: "donthaveaccount".LocalizedString, subString:"signup".LocalizedString, subStringColor: Colors.APP_Theme_color.value)
        lblLoginLink.attributedText =  "donthaveaccount".LocalizedString.getAttributedStrijng(titleString: "donthaveaccount".LocalizedString, subString:"signup".LocalizedString, subStringColor: Colors.APP_Theme_color.value)
        
        lblRegisterLink.isUserInteractionEnabled = true
        lblRegisterLink.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
        
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
    
    
}
