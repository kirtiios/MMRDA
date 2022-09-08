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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.callBarButtonForHome(leftBarLabelName: "", isHomeScreen:false,isDisplaySOS:false)
        objsetPasswordViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
        objsetPasswordViewModel.dict = param
        objsetPasswordViewModel.bindViewModelToController =  {sucess  in
            
            
            
            UserDefaults.standard.set(false, forKey: userDefaultKey.isMpinEnable.rawValue)
            UserDefaults.standard.synchronize()
            
            let firstPresented = UIStoryboard.SuccessRegisterVC()
            firstPresented?.isVerifyOTPFor = .Register
            self.navigationController?.pushViewController(firstPresented!, animated: true)
        }
       
        // Do any additional setup after loading the view.
    }
    
    
   
    
    @IBAction func actionPasswoedinstruction(_ sender: Any) {
        let root = UIWindow.key?.rootViewController!
        if let firstPresented = UIStoryboard.PasswordInstructionVC() {
            firstPresented.message = "password_instructions_text".LocalizedString
            firstPresented.titleName = " password_instructions".LocalizedString
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



