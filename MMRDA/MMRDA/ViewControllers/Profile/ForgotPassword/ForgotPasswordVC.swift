//
//  ForgotPasswordVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 18/08/22.
//

import UIKit
import ACFloatingTextfield_Swift

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var textMobileEmail: ACFloatingTextfield!
    var objsetPasswordViewModel = setPasswordViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.callBarButtonForHome(leftBarLabelName: "", isHomeScreen:false,isDisplaySOS:false)
        self .initialize()
        // Do any additional setup after loading the view.
    }
    
    func initialize(){
        objsetPasswordViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
        //objsetPasswordViewModel.dict = param
        objsetPasswordViewModel.bindViewModelToForgotController =  { param  in
            let vc = UIStoryboard.OTPVerifyVC()
            vc?.param = param
            vc?.isVerifyOTPFor = OTPVerify.ForgotPassword
            self.navigationController?.pushViewController(vc!, animated:true)
        }
    }
   
    

    @IBAction func actionVerifyOTP(_ sender: Any) {
        
        objsetPasswordViewModel.strMobilOReEmail = textMobileEmail.text ?? ""
        objsetPasswordViewModel.forgotSendOTP()
        
        
       
    }
}
