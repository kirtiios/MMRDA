//
//  ForgotPasswordVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 17/08/22.
//

import UIKit
import ACFloatingTextfield_Swift

class SetPasswordVC: UIViewController {
    
    @IBOutlet weak var textPassword: ACFloatingTextfield!
    @IBOutlet weak var textConfirmPassword: ACFloatingTextfield!
    var objsetPasswordViewModel = setPasswordViewModel()
    var param = [String:Any]()
    @IBOutlet weak var lblerror: UILabel!
    
    
    @IBOutlet var btnComfimPassword:UIButton!
    @IBOutlet var btnPassword:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        lblerror.textColor = UIColor(hexString: "#FF0000")
        self.setBackButton()
        //        self.callBarButtonForHome(leftBarLabelName: "", isHomeScreen:false,isDisplaySOS:false)
        objsetPasswordViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    
                    self?.lblerror.text = message
                }
            }
        }
        let barButton = UIBarButtonItem(image: UIImage(named:"back"), style:.plain, target: self, action: #selector(self.gotoBackRegisterScreen))
        barButton.tintColor = UIColor.black
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = barButton
        
        objsetPasswordViewModel.dict = param
        objsetPasswordViewModel.bindViewModelToController =  {sucess,message  in
            
            UserDefaults.standard.set(false, forKey: userDefaultKey.isMpinEnable.rawValue)
            UserDefaults.standard.synchronize()
            
            let firstPresented = UIStoryboard.SuccessRegisterVC()
            firstPresented?.isVerifyOTPFor = .Register
            self.navigationController?.pushViewController(firstPresented!, animated: true)
        }
        textPassword.delegate = self
        textConfirmPassword.delegate = self
        
        // Do any additional setup after loading the view.
    }
    @objc func gotoBackRegisterScreen(){
        self.navigationController?.popToViewController(ofClass:SignupVC.self)
    }
    
    @IBAction func btnConfirmPasswordClick(_ sender: Any) {
        if btnComfimPassword.currentImage == UIImage(named: "passwordHide"){
            textConfirmPassword.isSecureTextEntry = false
            btnComfimPassword.setImage(UIImage(named: "passwordShow"), for: .normal)

        }
        else{
            textConfirmPassword.isSecureTextEntry = true
            btnComfimPassword.setImage(UIImage(named: "passwordHide"), for: .normal)
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
    
    @IBAction func actionPasswoedinstruction(_ sender: Any) {
        let root = UIWindow.key?.rootViewController!
        if let firstPresented = UIStoryboard.PasswordInstructionVC() {
            firstPresented.message = "password_instructions_text".LocalizedString
            firstPresented.titleName = "password_instructions".LocalizedString
            firstPresented.modalTransitionStyle = .crossDissolve
            firstPresented.modalPresentationStyle = .overCurrentContext
            root?.present(firstPresented, animated: false, completion: nil)
        }
    }
    
    
    @IBAction func actionPasswordChnagesSuccessFully(_ sender: Any) {
        
        
        objsetPasswordViewModel.strPassword = textPassword.text ?? ""
        objsetPasswordViewModel.strConfirm = textConfirmPassword.text ?? ""
        
        objsetPasswordViewModel.submitSignUP()
        
        
        
       
    }
        
        
}



extension SetPasswordVC:UITextFieldDelegate {
    
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
