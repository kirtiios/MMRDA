//
//  Constants.swift
//  MMRDA
//
//  Created by Sandip Patel on 18/08/22.
//

import Foundation
import UIKit


let APPDELEGATE  = UIApplication.shared.delegate as! AppDelegate
let googleAPIKey = "AIzaSyBA3E9KWKlB59tfxE_8Qcdh-nwdPv161CQ"

var languageCode = UserDefaults.standard.value(forKey:"SelectedLangCode") ?? LanguageCode.English.rawValue
{
    didSet {
        DispatchQueue.main.async {
                UserDefaults.standard.set(languageCode, forKey: "SelectedLangCode")
            }
    }
}



// ====================================================================== //
// This is for Screen Resolution
// ====================================================================== //
let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad
let IS_IPHONE = UIDevice.current.userInterfaceIdiom == .phone
let IS_RETINA = UIScreen.main.scale >= 2.0




let IS_IPAD_9 = (IS_IPAD && SCREEN_MAX_LENGTH == 1024.0)
let IS_IPHONE_4_OR_LESS = (IS_IPHONE && SCREEN_MAX_LENGTH <= 568.0)
let IS_IPHONE_5 = (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
let IS_IPHONE_6 = (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
let IS_IPHONE_6_OR_LESS = (IS_IPHONE && SCREEN_MAX_LENGTH <= 667.0)
let IS_IPHONE_6P = (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
let IS_IPHONE_6P_OR_LESS = (IS_IPHONE && SCREEN_MAX_LENGTH <= 736.0)
let IS_IPHONE_8 = (IS_IPHONE && SCREEN_MAX_LENGTH == 750.0)
let IS_IPHONE_8_OR_LESS = (IS_IPHONE && SCREEN_MAX_LENGTH <= 750.0)



let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let SCREEN_MAX_LENGTH = max(SCREEN_WIDTH, SCREEN_HEIGHT)
let SCREEN_MIN_LENGTH = min(SCREEN_WIDTH, SCREEN_HEIGHT)



enum apiName {
    static let login = Environment.DOMAIN_URL + "User/Login"
    static let VerifyPhoneNO = Environment.DOMAIN_URL + "User/VerifyPhoneNo"
    static let SendOTP = Environment.DOMAIN_URL + "User/SendOTP"
    static let VerifyOTP = Environment.DOMAIN_URL + "User/VerifyOTP"
    static let signup = Environment.DOMAIN_URL + "User/InsertUserDetails"
    static let reSendOTP = Environment.DOMAIN_URL + "User/ResentOTP"
    static let forgetPassword = Environment.DOMAIN_URL + "User/ForgetPassword"
    static let forgetMpin = Environment.DOMAIN_URL + "User/ForgetUserMPin"
    static let setMpin = Environment.DOMAIN_URL + "User/InsertMPIN"
    
    
    static let fareStationList = Environment.DOMAIN_URL + "Masters/GetStationList"
    static let fareCalculation = Environment.DOMAIN_URL + "Common/GetFare"
    
    static let attractionSearch = Environment.DOMAIN_URL + "Masters/GooglePLaceApiDataWithSearch"
    static let attractionList = Environment.DOMAIN_URL + "Masters/GooglePLaceApiData"
    static let attaractionDetail = Environment.DOMAIN_URL + "Masters/GetGooglePlaceDetails"
    
    static let rewardDetail = Environment.DOMAIN_URL + "Reward/GetRewardPoint"
    static let rewardTranasctionList = Environment.DOMAIN_URL + "Reward/spGetRewardTransaction"
    
    static let favouriteList = Environment.DOMAIN_URL + "Favourite/GetFavouriteList"
    static let deleteFavourite = Environment.DOMAIN_URL + "Favourite/DeleteFavorite"
    static let insertFavourite = Environment.DOMAIN_URL + "Favourite/InsertFavoriteDetails"
    
    
    static let refreshToken = Environment.DOMAIN_URL + "Auth/VerifyRefreshTokenDetail"
    
  
    
//    static let signup = Environment.DOMAIN_URL + "RegisterUser"
//    static let opt_request_forgotpassword = Environment.DOMAIN_URL + "UserForgotPassword"
//    static let otp_verify = Environment.DOMAIN_URL + "VerifyOTP"
//    static let GetAllLotInformation = Environment.DOMAIN_URL + "GetAllLotInformation"
//    static let ChangePassword = Environment.DOMAIN_URL + "ChangePassword"
//    static let updateProfile = Environment.DOMAIN_URL + "UserUpdateProfile"
   
    
}
extension Notification {
    
    static let sideMenuDidSelectNotificationCenter = Notification.Name("sideMenuDidSelectNotification")
    static let languageChanged   = Notification.Name("languageChanged")
    static let notificationClicked   = Notification.Name("notificationClicked")
    static let myrewardsClicked   = Notification.Name("MyrewardsClicked")
    
}
