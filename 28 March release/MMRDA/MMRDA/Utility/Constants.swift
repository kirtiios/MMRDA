//
//  Constants.swift
//  MMRDA
//
//  Created by Sandip Patel on 18/08/22.
//

import Foundation
import UIKit
import Localize_Swift

let APPDELEGATE  = UIApplication.shared.delegate as! AppDelegate
let googleAPIKey = "AIzaSyBA3E9KWKlB59tfxE_8Qcdh-nwdPv161CQ"

var languageCode = UserDefaults.standard.string(forKey:"SelectedLangCode") ?? LanguageCode.English.rawValue {
    didSet {
        UserDefaults.standard.set(languageCode, forKey: "SelectedLangCode")
        Localize.setCurrentLanguage(languageCode)
        
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
    
    static let UpdateLoginDetail = Environment.DOMAIN_URL + "User/UpdateLoginDetails"
    
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
    
    
    static let ticketList = Environment.DOMAIN_URL + "Ticket/GetPurchaseHistory"
    
    static let startSOS = Environment.DOMAIN_URL + "SOS/InsertMobileSOSData"
    static let soptSOS = Environment.DOMAIN_URL + "SOS/StopMobileSOS"

    
    static let refreshToken = Environment.DOMAIN_URL + "Auth/VerifyRefreshTokenDetail"
    
    static let getFeedbackReview = Environment.DOMAIN_URL + "Feedback/GetFeedback"
    static let getFeedbackcategory = Environment.DOMAIN_URL + "Feedback/GetFeedbackCategory"
    static let insertFeedback = Environment.DOMAIN_URL + "Feedback/InsertFeedback"
    
    static let getNearbyStationStop = Environment.DOMAIN_URL + "Masters/GetStationListWithDistance"
    static let getNearbyStationSearch = Environment.DOMAIN_URL + "Masters/GetStationList"
    static let getNearbyStationSchedule = Environment.DOMAIN_URL + "NearByStation/GetNearByStationSchedule"
    static let getNearbyStationRefresh = Environment.DOMAIN_URL + "NearByStation/GetNearByStationScheduleRefreshDetail"
    
    static let notifcaitonList = Environment.DOMAIN_URL + "Notification/GetNotification"
    static let notifcaitonUpdate = Environment.DOMAIN_URL + "Notification/UpdateNotification"
    
   
    
    
    static let getStationDirection = Environment.DOMAIN_URL + "Masters/DirectionAPI"
    
    static let getNotifyeList = Environment.DOMAIN_URL + "Common/GetNotifyDuration"
    static let saveAlarm = Environment.DOMAIN_URL + "Common/InsertNotifyDetails"
    
    
    static let getProfileDetail = Environment.DOMAIN_URL + "User/GetUserDetails"
    static let updateProfile = Environment.DOMAIN_URL + "User/UpdateUserDetails"
    static let getToStationListinPaymentPage = Environment.DOMAIN_URL + "NearByStation/GetToStationList"
    
    static let GetTimeSlotListFilter = Environment.DOMAIN_URL + "NearByStation/GetTimeSlotListFilter"
    
    static let ticketInsert = Environment.DOMAIN_URL + "Ticket/InsertTicketTransactions"
   // static let ticketHistory = Environment.DOMAIN_URL + "Ticket/GetPurchaseHistory"
    
   
    static let journeyPlannerList = Environment.DOMAIN_URL + "JourneyPlanner/GetJourneyPlan"
    
    static let grivanceList = Environment.DOMAIN_URL + "Grievance/GetGrievance"
    static let grivanceCategoryList = Environment.DOMAIN_URL + "Grievance/GetCategory"
    static let grivanceSubCategoryList = Environment.DOMAIN_URL + "Grievance/GetSubCategory"
    static let grivanceRouteList  = Environment.DOMAIN_URL + "Grievance/GetRoutelist"
    static let grivanceVechicleList = Environment.DOMAIN_URL + "Grievance/GetVehiclelist"
    static let grivanceSubmit = Environment.DOMAIN_URL + "Grievance/InsertComplainRequest"
    static let ChangePassword = Environment.DOMAIN_URL + "User/ChangePassword"
    static let getpenalityStatus = Environment.DOMAIN_URL + "Common/GetTicketPenaltyStatus"
    static let CheckSavedNotify = Environment.DOMAIN_URL + "Common/CheckSavedNotify"
    static let RemoveNotify = Environment.DOMAIN_URL + "Common/RemoveNotify"
    static let LogOut = Environment.DOMAIN_URL + "Auth/UpdateLoginHistory"
    
    static let GetMetroTripDirection = Environment.DOMAIN_URL + "Common/GetMetroTripDirection"


    
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
    static let updateEmergencyContactNumber = Notification.Name("updateEmergencyContactNumberNotification")
    
    static let sidemenuUpdated = Notification.Name("sidemenuUpdated")
    static let FeedbackUpdated = Notification.Name("FeedbackUpdated")
    static let GrivanceUpdated = Notification.Name("GrivanceUpdated")
    
    
}
