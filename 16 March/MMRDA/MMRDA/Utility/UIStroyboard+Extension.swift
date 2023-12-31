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
    
    class func FindNearByStationsStoryBoard() -> UIStoryboard {
        return UIStoryboard(name: "FindNearByStations", bundle: nil)
    }
    class func PlanJourneyStoryBoard() -> UIStoryboard {
        return UIStoryboard(name: "PlanJourney", bundle: nil)
    }
    class func FareCalculatorStoryBoard() -> UIStoryboard {
        return UIStoryboard(name: "FareCalculator", bundle: nil)
    }
    
    //Profile  StroryBoard
    class func SignUpVC() -> SignupVC? {
        return ProfileStoryBoard().instantiateViewController(withIdentifier: "SignUpVC") as? SignupVC
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
    
    class func EditProfileVC() -> EditProfileVC? {
        return ProfileStoryBoard().instantiateViewController(withIdentifier: "EditProfileVC") as? EditProfileVC
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
    
    class func ChnagePasswordVC() -> ChnagePasswordVC? {
        return ProfileStoryBoard().instantiateViewController(withIdentifier: "ChnagePasswordVC") as? ChnagePasswordVC
    }
    class func EditPersonalDetailsVC() -> EditPersonalDetails? {
        return ProfileStoryBoard().instantiateViewController(withIdentifier: "EditPersonalDetails") as? EditPersonalDetails
    }
    
    class func EditLoginDetailsVC() -> EditLoginDetailsVC? {
        return ProfileStoryBoard().instantiateViewController(withIdentifier: "EditLoginDetailsVC") as? EditLoginDetailsVC
    }
    class func ChnagepasswordVerifyOtpVC() -> ChnagepasswordVerifyOtpVC? {
        return ProfileStoryBoard().instantiateViewController(withIdentifier: "ChnagepasswordVerifyOtpVC") as? ChnagepasswordVerifyOtpVC
    }
    
    class func FindNearByStopsVC() -> FindNearByStopsVC? {
        return FindNearByStationsStoryBoard().instantiateViewController(withIdentifier: "FindNearByStopsVC") as? FindNearByStopsVC
    }
    
    class func StationListingVC() -> StationListingVC? {
        return FindNearByStationsStoryBoard().instantiateViewController(withIdentifier: "StationListingVC") as? StationListingVC
    }
    class func RoueDetailVC() -> RoueDetailVC? {
        return FindNearByStationsStoryBoard().instantiateViewController(withIdentifier: "RoueDetailVC") as? RoueDetailVC
    }
    class func FilterVC() -> FilterVC? {
        return FindNearByStationsStoryBoard().instantiateViewController(withIdentifier: "FilterVC") as? FilterVC
    }
    class func ReminderVC() -> ReminderVC? {
        return FindNearByStationsStoryBoard().instantiateViewController(withIdentifier: "ReminderVC") as? ReminderVC
    }
    class func PaymentVC() -> PaymentVC? {
        return FindNearByStationsStoryBoard().instantiateViewController(withIdentifier: "PaymentVC") as? PaymentVC
    }
    class func ConfirmPaymentVC() -> ConfirmPaymentVC? {
        return FindNearByStationsStoryBoard().instantiateViewController(withIdentifier: "ConfirmPaymentVC") as? ConfirmPaymentVC
    }
    
    class func PaymentFailedVC() -> PaymentFailedVC? {
        return FindNearByStationsStoryBoard().instantiateViewController(withIdentifier: "PaymentFailedVC") as? PaymentFailedVC
    }
    
    class func ViewTicketVC() -> ViewTicketVC {
        return FindNearByStationsStoryBoard().instantiateViewController(withIdentifier: "ViewTicketVC") as! ViewTicketVC
    }
    // Journey Planner
    
    class func JourneySearchVC() -> JourneySearchVC {
        return PlanJourneyStoryBoard().instantiateViewController(withIdentifier: "JourneySearchVC") as! JourneySearchVC
    }
    class func JourneyPlannerStationListingVC() -> JourneyPlannerStationListing {
        return PlanJourneyStoryBoard().instantiateViewController(withIdentifier: "JourneyPlannerStationListing") as! JourneyPlannerStationListing
    }
    
    class func PlanjourneyRouetDetailsVC() -> PlanjourneyRouetDetailsVC {
        return PlanJourneyStoryBoard().instantiateViewController(withIdentifier: "PlanjourneyRouetDetailsVC") as! PlanjourneyRouetDetailsVC
    }
    
    class func AlertaltivesVC() -> AlertaltivesVC? {
        return PlanJourneyStoryBoard().instantiateViewController(withIdentifier: "AlertaltivesVC") as? AlertaltivesVC
    }
    
    

    class func ChooseOrginVC() -> ChooseOrginVC {
        return PlanJourneyStoryBoard().instantiateViewController(withIdentifier: "ChooseOrginVC") as! ChooseOrginVC
    }
    class func InformationVC() -> InformationVC?{
        return PlanJourneyStoryBoard().instantiateViewController(withIdentifier: "InformationVC") as? InformationVC
    }
    
    // Main
    
    class func DashboardVC() -> DashboardVC? {
        return MainStoryBoard().instantiateViewController(withIdentifier: "DashboardVC") as? DashboardVC
    }
    class func SidemenuVC() -> SidemenuVC? {
        return MainStoryBoard().instantiateViewController(withIdentifier: "SidemenuVC") as? SidemenuVC
    }
    
    class func MyRewardsVC() -> MyRewardsVC? {
        return MainStoryBoard().instantiateViewController(withIdentifier: "MyRewardsVC") as? MyRewardsVC
    }
    
    class func CityGuideVC() -> CityGuideVC? {
        return MainStoryBoard().instantiateViewController(withIdentifier: "CityGuideVC") as? CityGuideVC
    }
    
    class func RewardsLinkVC() -> RewardsLinkVC? {
        return MainStoryBoard().instantiateViewController(withIdentifier: "RewardsLinkVC") as? RewardsLinkVC
    }
    class func MyFavouritesVC() -> MyFavouritesVC? {
        return MainStoryBoard().instantiateViewController(withIdentifier: "MyFavouritesVC") as? MyFavouritesVC
    }
    class func SelectFromMapVc() -> SelectFromMapVc? {
        return MainStoryBoard().instantiateViewController(withIdentifier: "SelectFromMapVc") as? SelectFromMapVc
    }
    class func SaveLocationVC() -> SaveLocationVC? {
        return MainStoryBoard().instantiateViewController(withIdentifier: "SaveLocationVC") as? SaveLocationVC
    }
    
    class func FeedBackDashBoardVC() -> FeedBackDashBoardVC? {
        return MainStoryBoard().instantiateViewController(withIdentifier: "FeedBackDashBoardVC") as? FeedBackDashBoardVC
    }
    
    class func ConatctUSVC() -> ContactUSVC? {
        return MainStoryBoard().instantiateViewController(withIdentifier: "ConatctUSVC") as? ContactUSVC
    }
    

    class func GrivanceDetailsListingVC() -> GrivanceDetailsListingVC?{
        return MainStoryBoard().instantiateViewController(withIdentifier: "GrivanceDetailsListingVC") as? GrivanceDetailsListingVC
    }
    
    
    class func GrivanceDashBoardVC() -> GrivanceDashBoardVC? {
        return MainStoryBoard().instantiateViewController(withIdentifier: "GrivanceDashBoardVC") as? GrivanceDashBoardVC
    }
    
    class func GrivanceListingVC() -> GrivanceListingVC? {
        return MainStoryBoard().instantiateViewController(withIdentifier: "GrivanceListingVC") as? GrivanceListingVC
    }
    
    class func GrivinaceSubmitVC() -> GrivinaceSubmitVC? {
        return MainStoryBoard().instantiateViewController(withIdentifier: "GrivinaceSubmitVC") as? GrivinaceSubmitVC
    }
    
    class func SettingsVC() -> SettingsVC? {
        return MainStoryBoard().instantiateViewController(withIdentifier: "SettingsVC") as? SettingsVC
    }
    
    class func TrustedContactVC() -> TrustedContactVC? {
        return MainStoryBoard().instantiateViewController(withIdentifier: "TrustedContactVC") as? TrustedContactVC
    }
    
    class func AboutDeveloperVC() -> AboutDeveloperVC? {
        return MainStoryBoard().instantiateViewController(withIdentifier: "AboutDeveloperVC") as? AboutDeveloperVC
    }
    
    class func ShareLocationVC() -> ShareLocationVC? {
        return MainStoryBoard().instantiateViewController(withIdentifier: "ShareLocationVC") as? ShareLocationVC
    }
    
    class func SOSVC() -> SOSVC? {
        return MainStoryBoard().instantiateViewController(withIdentifier: "SOSVC") as? SOSVC
    }
    // Fare Calculartor
    
    class func FareCalVC() -> FareCalVC {
        return FareCalculatorStoryBoard().instantiateViewController(withIdentifier: "FareCalVC") as! FareCalVC
    }
    class func FareStationsListVC() -> FareStationsListVC {
        return FareCalculatorStoryBoard().instantiateViewController(withIdentifier: "FareStationsListVC") as! FareStationsListVC
    }
    class func GenerateQRcodeVC() -> GenerateQRcodeVC {
        return FareCalculatorStoryBoard().instantiateViewController(withIdentifier: "GenerateQRcodeVC") as! GenerateQRcodeVC
    }
    
    
    
    
    
    class func MyticketsVC() -> MyticketsVC {
        return FareCalculatorStoryBoard().instantiateViewController(withIdentifier: "MyticketsVC") as! MyticketsVC
    }
    
    class func FilterTransportTypeVC() -> FilterTransportTypeViewController {
        return FareCalculatorStoryBoard().instantiateViewController(withIdentifier: "FilterTransportTypeViewController") as! FilterTransportTypeViewController
    }
    
    class func FeedBackReviewVC() -> FeedBackReviewVC {
        return FareCalculatorStoryBoard().instantiateViewController(withIdentifier: "FeedBackReviewVC") as! FeedBackReviewVC
    }
    
    
    
    
    
}


