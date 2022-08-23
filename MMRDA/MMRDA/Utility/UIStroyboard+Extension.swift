//
//  UiStroyboard+Extension.swift
//  MMRDA
//
//  Created by Sandip Patel on 17/08/22.
//

import Foundation
import UIKit


extension UIStoryboard {
    
    class func ProfileStoryBoard() -> UIStoryboard {
        return UIStoryboard(name: "Profile", bundle: nil)
    }
    class func MainStoryBoard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    //MAIN StroryBoard
    class func SignUpVC() -> SingupVC? {
        return ProfileStoryBoard().instantiateViewController(withIdentifier: "SignUpVC") as? SingupVC
    }
    class func OTPVerifyVC() -> OTPVerifyVC? {
        return ProfileStoryBoard().instantiateViewController(withIdentifier: "OTPVerifyVC") as? OTPVerifyVC
    }
    class func LoginVC() -> LoginVC? {
        return ProfileStoryBoard().instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
    }
    class func ForgotMobilePINVC() -> ForgotMobilePINVC? {
        return ProfileStoryBoard().instantiateViewController(withIdentifier: "ForgotMobilePINVC") as? ForgotMobilePINVC
    }
    class func ForgotPasswordVC() -> ForgotPasswordVC? {
        return ProfileStoryBoard().instantiateViewController(withIdentifier: "ForgotPasswordVC") as? ForgotPasswordVC
    }
    class func PasswordInstructionVC() -> PasswordInstructionVC? {
        return ProfileStoryBoard().instantiateViewController(withIdentifier: "PasswordInstructionVC") as? PasswordInstructionVC
    }
    class func SuccessRegisterVC() -> SuccessRegisterVC? {
        return ProfileStoryBoard().instantiateViewController(withIdentifier: "SuccessRegisterVC") as? SuccessRegisterVC
    }
    
    class func SetupMPINVC() -> SetupMPINVC? {
        return ProfileStoryBoard().instantiateViewController(withIdentifier: "SetupMPINVC") as? SetupMPINVC
    }
    
    
    class func ResetMPINVC() -> ResetMPINVC? {
        return ProfileStoryBoard().instantiateViewController(withIdentifier: "ResetMPINVC") as? ResetMPINVC
    }
    
    class func ResetPasswordVC() -> ResetPasswordVC? {
        return ProfileStoryBoard().instantiateViewController(withIdentifier: "ResetPasswordVC") as? ResetPasswordVC
    }
    class func setPasswordVC() -> SetPasswordVC? {
        return ProfileStoryBoard().instantiateViewController(withIdentifier: "SetPasswordVC") as? SetPasswordVC
    }
    class func DashboardVC() -> DashboardVC? {
        return MainStoryBoard().instantiateViewController(withIdentifier: "DashboardVC") as? DashboardVC
    }
    class func SidemenuVC() -> SidemenuVC? {
        return MainStoryBoard().instantiateViewController(withIdentifier: "SidemenuVC") as? SidemenuVC
    }
    
    
    
}

