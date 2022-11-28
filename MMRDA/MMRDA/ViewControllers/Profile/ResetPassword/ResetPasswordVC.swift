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
                   // self?.showAlertViewWithMessage("", message:message)
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
        
    }
    @objc func gotoBackForgotScreen(){
        self.navigationController?.popToViewController(ofClass:ForgotPasswordVC.self)
    }
    

   

    @IBAction func actionShowPasswordInstruction(_ sender: Any) {
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
        objsetPasswordViewModel.resetPassword()
       
    }
}
