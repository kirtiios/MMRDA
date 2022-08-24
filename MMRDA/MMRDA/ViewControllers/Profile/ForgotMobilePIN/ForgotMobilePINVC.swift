//
//  ForgotMobilePINVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 17/08/22.
//

import UIKit
import ACFloatingTextfield_Swift

class ForgotMobilePINVC: UIViewController {

    @IBOutlet weak var textMobileEmail: ACFloatingTextfield!
    var objsetPasswordViewModel = setPasswordViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.callBarButtonForHome(leftBarLabelName: "", isHomeScreen:false,isDisplaySOS:false)
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
            vc?.isVerifyOTPFor = OTPVerify.ForgotMPIN
            self.navigationController?.pushViewController(vc!, animated:true)
        }
    }
    
     @IBAction func actionMoveGetOTp(_ sender: Any) {
         
         objsetPasswordViewModel.strMobilOReEmail = textMobileEmail.text ?? ""
         objsetPasswordViewModel.forgotSendOTP()
         
       
     }
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
