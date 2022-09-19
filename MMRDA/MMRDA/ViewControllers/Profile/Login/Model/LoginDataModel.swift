//
//  LoginDataModel.swift
//  MMRDA
//
//  Created by Kirti Chavda on 23/08/22.
//

import Foundation
import Foundation
struct LoginDataModel : Codable {
    var strProfileURL : String?
    let intUserID : Int?
    var strFullName : String?
    var strMobileNo : String?
    var strEmailID : String?
    let strRefID : String?
    let strMsg : String?
    var strAccessToken : String?
    var strRefreshToken : String?
    var strRefreshTokenGUID : String?
    var dteAccessTokenExpirationTime : String?

    enum CodingKeys: String, CodingKey {

        case strProfileURL = "strProfileURL"
        case intUserID = "intUserID"
        case strFullName = "strFullName"
        case strMobileNo = "strMobileNo"
        case strEmailID = "strEmailID"
        case strRefID = "strRefID"
        case strMsg = "strMsg"
        case strAccessToken = "strAccessToken"
        case strRefreshToken = "strRefreshToken"
        case strRefreshTokenGUID = "strRefreshTokenGUID"
        case dteAccessTokenExpirationTime = "dteAccessTokenExpirationTime"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        strProfileURL = try values.decodeIfPresent(String.self, forKey: .strProfileURL)
        intUserID = try values.decodeIfPresent(Int.self, forKey: .intUserID)
        strFullName = try values.decodeIfPresent(String.self, forKey: .strFullName)
        strMobileNo = try values.decodeIfPresent(String.self, forKey: .strMobileNo)
        strEmailID = try values.decodeIfPresent(String.self, forKey: .strEmailID)
        strRefID = try values.decodeIfPresent(String.self, forKey: .strRefID)
        strMsg = try values.decodeIfPresent(String.self, forKey: .strMsg)
        strAccessToken = try values.decodeIfPresent(String.self, forKey: .strAccessToken)
        strRefreshToken = try values.decodeIfPresent(String.self, forKey: .strRefreshToken)
        strRefreshTokenGUID = try values.decodeIfPresent(String.self, forKey: .strRefreshTokenGUID)
        dteAccessTokenExpirationTime = try values.decodeIfPresent(String.self, forKey: .dteAccessTokenExpirationTime)
    }

}
