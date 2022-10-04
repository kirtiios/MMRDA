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
        textMobileEmail.delegate = self
        self.initialize()
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
extension ForgotPasswordVC:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let maxLength = 10
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        if (newString as String).isNumeric {
            return newString.length <= maxLength
        }
        return true
    }
    
}
