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
    case MYTicket = 3
    case Mypass = 4
    case SmartCard = 5
}
