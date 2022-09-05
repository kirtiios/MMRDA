//
//  Enum.swift
//  MMRDA
//
//  Created by Sandip Patel on 18/08/22.
//

import Foundation


enum LanguageCode: String
{
    case
    English = "en",
    Hindi = "hi",
    Marathi = "mr-IN"
}


enum OTPVerify:Int{
    case Register = 0
    case ForgotMPIN = 1
    case ForgotPassword = 2
}





enum DashboardMenus:Int {
    case FindNearBySyops = 0
    case Planyourjourney = 1
    case FareCalculator = 2
    case Mypass = 3
    case SmartCard = 4
    case MYTicket = 5

}
