//
//  SuccessRegisterVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 18/08/22.
//

import UIKit

class SuccessRegisterVC: UIViewController {

    @IBOutlet weak var popupview: UIView!
    @IBOutlet weak var lblMessage: UILabel!
    var isVerifyOTPFor:OTPVerify?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        if isVerifyOTPFor == .ForgotPassword {
            lblMessage.text = "passwordupdatesuccess".LocalizedString
        }
        else if isVerifyOTPFor == .ForgotMPIN {
            lblMessage.text = "mpin_set".LocalizedString
        }else {
            lblMessage.text = "success_Register".LocalizedString
            
        }
       
        // Do any additional setup after loading the view.
    }
    

    @IBAction func actionbackToLogin(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated:true)
    }
    
    
    
   
}
