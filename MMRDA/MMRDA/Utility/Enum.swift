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
    Kannada = "kn"
}


enum OTPVerify:Int{
    case Register = 0
    case ForgotMPIN = 1
    case ForgotPassword = 2
}
