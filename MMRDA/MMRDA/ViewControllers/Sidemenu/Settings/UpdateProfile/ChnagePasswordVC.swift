//
//  ChnagePasswordVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 02/09/22.
//

import UIKit
import ACFloatingTextfield_Swift

class ChnagePasswordVC: UIViewController {

    
    @IBOutlet weak var txtNewPassword: ACFloatingTextfield!
    @IBOutlet weak var txtConfirmPassword: ACFloatingTextfield!
    var objsetPasswordViewModel = setPasswordViewModel()
    @IBOutlet weak var popupView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 6
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        objsetPasswordViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
        objsetPasswordViewModel.bindViewModelToController =  {sucess  in
            let firstPresented = UIStoryboard.SuccessRegisterVC()
            firstPresented?.isVerifyOTPFor = .ForgotMPIN
            self.navigationController?.pushViewController(firstPresented!, animated: true)
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func actionChnage(_ sender: Any) {
        
        
        
        if txtNewPassword.text?.trim().isEmpty ?? false {
            self.showAlertViewWithMessage("", message: "plsenternewpassword".LocalizedString)
        }
        else if txtConfirmPassword.text?.trim().isEmpty ?? false {
            self.showAlertViewWithMessage("", message: "plsenterconfirmpassword".LocalizedString)
        }else {
            
            objsetPasswordViewModel.dict = ["strPhoneNo":Helper.shared.objloginData?.strMobileNo]
            objsetPasswordViewModel.strPassword = txtNewPassword.text ?? ""
            objsetPasswordViewModel.strConfirm = txtConfirmPassword.text ?? ""
            objsetPasswordViewModel.resetPassword()
            objsetPasswordViewModel.bindViewModelToController  = { sucess in
                
                self.showAlertViewWithMessageAndActionHandler("", message:"passwordupdatesuccess".LocalizedString) {
                    self.dismiss(animated: true, completion: nil)
                }
                
                
            }
        }
        
        
//        if txtNewPassword.text?.trim().isEmpty ?? false {
//            self.showAlertViewWithMessage("", message: "plsenternewpassword".LocalizedString)
//        }
//        else if txtConfirmPassword.text?.trim().isEmpty ?? false {
//            self.showAlertViewWithMessage("", message: "plsenterconfirmpassword".LocalizedString)
//        }else {
//
//
//
//            self.dismiss(animated: true)
//            let root = UIWindow.key?.rootViewController!
//            let firstPresented = UIStoryboard.ChnagepasswordVerifyOtpVC()!
//            firstPresented.modalTransitionStyle = .crossDissolve
//            firstPresented.modalPresentationStyle = .overCurrentContext
//            root?.present(firstPresented, animated: false, completion: nil)
//        }
    }
     

    
   

}
