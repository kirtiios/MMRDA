//
//  ResetPasswordVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 18/08/22.
//

import UIKit
import ACFloatingTextfield_Swift

class ResetPasswordVC: UIViewController {

    @IBOutlet weak var textPassword: ACFloatingTextfield!
    @IBOutlet weak var textConfirmPassword: ACFloatingTextfield!
    var objsetPasswordViewModel = setPasswordViewModel()
    @IBOutlet weak var lblerror: UILabel!
    var params = [String:Any]()
    
    
    @IBOutlet var btnPassword:UIButton!
    @IBOutlet var btnConfirmPassword:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
//        self.callBarButtonForHome(leftBarLabelName: "", isHomeScreen:false,isDisplaySOS:false)
        let barButton = UIBarButtonItem(image: UIImage(named:"back"), style:.plain, target: self, action: #selector(self.gotoBackForgotScreen))
        barButton.tintColor = UIColor.black
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = barButton
      
        lblerror.textColor = UIColor(hexString: "#FF0000")
        objsetPasswordViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                  
                    self?.lblerror.text = message
                }
            }
        }
        objsetPasswordViewModel.dict = params
        objsetPasswordViewModel.bindViewModelToController =  { sucess,message  in
            let firstPresented = UIStoryboard.SuccessRegisterVC()
            firstPresented?.isVerifyOTPFor = .ForgotPassword
            self.navigationController?.pushViewController(firstPresented!, animated: true)
        }
        textPassword.delegate = self
        textConfirmPassword.delegate = self
        
    }
    @objc func gotoBackForgotScreen(){
        self.navigationController?.popToViewController(ofClass:ForgotPasswordVC.self)
    }
    @IBAction func actionShowPasswordInstruction(_ sender: Any) {
        let root = UIWindow.key?.rootViewController!
        if let firstPresented = UIStoryboard.PasswordInstructionVC() {
            firstPresented.message = "password_instructions_text".LocalizedString
            firstPresented.titleName = "password_instructions".LocalizedString
            firstPresented.modalTransitionStyle = .crossDissolve
            firstPresented.modalPresentationStyle = .overCurrentContext
            root?.present(firstPresented, animated: false, completion: nil)
        }
    }
    @IBAction func btnConfirmPasswordClick(_ sender: Any) {
        if btnConfirmPassword.currentImage == UIImage(named: "passwordHide"){
            textConfirmPassword.isSecureTextEntry = false
            btnConfirmPassword.setImage(UIImage(named: "passwordShow"), for: .normal)

        }
        else{
            textConfirmPassword.isSecureTextEntry = true
            btnConfirmPassword.setImage(UIImage(named: "passwordHide"), for: .normal)
        }
    }
    @IBAction func btnPasswordClick(_ sender: Any) {
        if btnPassword.currentImage == UIImage(named: "passwordHide"){
            textPassword.isSecureTextEntry = false
            btnPassword.setImage(UIImage(named: "passwordShow"), for: .normal)

        }
        else{
            textPassword.isSecureTextEntry = true
            btnPassword.setImage(UIImage(named: "passwordHide"), for: .normal)
        }
    }
    @IBAction func actionPasswordChnagesSuccessFully(_ sender: Any) {
        
        objsetPasswordViewModel.strPassword = textPassword.text ?? ""
        objsetPasswordViewModel.strConfirm = textConfirmPassword.text ?? ""
        objsetPasswordViewModel.resetPassword()
       
    }
}
extension ResetPasswordVC:UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let whitespaceSet = NSCharacterSet.whitespaces
        if let _ = string.rangeOfCharacter(from: whitespaceSet) {
            return false
        }
        else {
            return true
        }
    }
    
}
