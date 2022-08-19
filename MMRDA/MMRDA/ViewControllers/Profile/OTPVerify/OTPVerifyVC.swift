//
//  OTPVerify.swift
//  MMRDA
//
//  Created by Sandip Patel on 17/08/22.
//

import Foundation

//
//  LoginVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 17/08/22.
//

import UIKit

class OTPVerifyVC: UIViewController, OTPViewDelegate {
    
    var isVerifyOTPFor:OTPVerify?
    
    
    
    @IBAction func actionVerifyOTp(_ sender: Any) {
        if isVerifyOTPFor?.rawValue == OTPVerify.ForgotMPIN.rawValue {
            let vc = UIStoryboard.ResetMPINVC()
            self.navigationController?.pushViewController(vc!, animated:true)
        }else if isVerifyOTPFor?.rawValue == OTPVerify.ForgotPassword.rawValue {
            let vc = UIStoryboard.ResetPasswordVC()
            self.navigationController?.pushViewController(vc!, animated:true)
        }else{
            
        }
        
    }
    
    func shouldBecomeFirstResponderForOTP(otpFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otpString: String) {
        
    }
    
    func hasEnteredAllOTP(hasEntered: Bool) -> Bool {
        return true
    }
    
    
    
    @IBOutlet weak var txtOTPView: OTPView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtOTPView.initializeOTPUI()
    }
    
}
