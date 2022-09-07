//
//  Color.swift
//  MMRDA
//
//  Created by Sandip Patel on 17/08/22.
//

import Foundation
import UIKit


enum Colors {
    case navigationBarBackgroundColor
    case navigationTintCololr
    case APP_Theme_color
    case lighGrayColor
    case blackColor
    case GreenColor
}


extension Colors {
    var value: UIColor {
        get {
            switch self {
            case .navigationBarBackgroundColor:
                return UIColor(red: 235/255, green: 239/255, blue: 240/255, alpha: 1.0)
            case .navigationTintCololr:
                return UIColor.white
            case .APP_Theme_color :
                return UIColor(red: 0/255, green: 49/255, blue: 113/255, alpha: 1.0)
            case .lighGrayColor :
                return UIColor.lightGray
            case  .blackColor:
                return UIColor(hexString: "333333")
            case .GreenColor :
                return UIColor(hexString: "339A4E")
            }
        }
    }
}
