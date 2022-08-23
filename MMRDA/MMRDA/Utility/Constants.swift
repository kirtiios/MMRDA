//
//  Constants.swift
//  MMRDA
//
//  Created by Sandip Patel on 18/08/22.
//

import Foundation
import UIKit


let APPDELEGATE  = UIApplication.shared.delegate as! AppDelegate


var languageCode = UserDefaults.standard.value(forKey:"SelectedLangCode") ?? LanguageCode.English.rawValue
{
    didSet {
        DispatchQueue.main.async {
                UserDefaults.standard.set(languageCode, forKey: "SelectedLangCode")
            }
    }
}


let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height



enum apiName {
    static let login = Environment.DOMAIN_URL + "User/Login"
    static let VerifyPhoneNO = Environment.DOMAIN_URL + "User/VerifyPhoneNo"
    static let SendOTP = Environment.DOMAIN_URL + "User/SendOTP"
    static let VerifyOTP = Environment.DOMAIN_URL + "User/VerifyOTP"
    static let signup = Environment.DOMAIN_URL + "User/InsertUserDetails"
    static let reSendOTP = Environment.DOMAIN_URL + "User/ResentOTP"
    
  
    
//    static let signup = Environment.DOMAIN_URL + "RegisterUser"
//    static let opt_request_forgotpassword = Environment.DOMAIN_URL + "UserForgotPassword"
//    static let otp_verify = Environment.DOMAIN_URL + "VerifyOTP"
//    static let GetAllLotInformation = Environment.DOMAIN_URL + "GetAllLotInformation"
//    static let ChangePassword = Environment.DOMAIN_URL + "ChangePassword"
//    static let updateProfile = Environment.DOMAIN_URL + "UserUpdateProfile"
   
    
}
