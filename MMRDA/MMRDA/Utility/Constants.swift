//
//  Constants.swift
//  MMRDA
//
//  Created by Sandip Patel on 18/08/22.
//

import Foundation
import UIKit


let APPDELEGATE  = UIApplication.shared.delegate as! AppDelegate
let googleAPIKey = "AIzaSyB1TDL5K6Z8O5-8eIya1_gvfl8wrwyZP4M"

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
