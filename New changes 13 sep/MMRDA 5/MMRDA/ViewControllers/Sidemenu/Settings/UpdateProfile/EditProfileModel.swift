//
//  EditProfileModel.swift
//  MMRDA
//
//  Created by Kirti Chavda on 13/09/22.
//

import Foundation
struct EditProfileModel : Codable {
    let result : Int?
    let intUserID : Int?
    let strProfileURL : String?
    let strFullName : String?
    let strDisplayName : String?
    let strGender : String?
    let strEmailID : String?
    let strMobileNo : String?
    let strProfileBase64 : String?
    let strProfilePath : String?
    let strMobileURL : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case intUserID = "intUserID"
        case strProfileURL = "strProfileURL"
        case strFullName = "strFullName"
        case strDisplayName = "strDisplayName"
        case strGender = "strGender"
        case strEmailID = "strEmailID"
        case strMobileNo = "strMobileNo"
        case strProfileBase64 = "strProfileBase64"
        case strProfilePath = "strProfilePath"
        case strMobileURL = "strMobileURL"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Int.self, forKey: .result)
        intUserID = try values.decodeIfPresent(Int.self, forKey: .intUserID)
        strProfileURL = try values.decodeIfPresent(String.self, forKey: .strProfileURL)
        strFullName = try values.decodeIfPresent(String.self, forKey: .strFullName)
        strDisplayName = try values.decodeIfPresent(String.self, forKey: .strDisplayName)
        strGender = try values.decodeIfPresent(String.self, forKey: .strGender)
        strEmailID = try values.decodeIfPresent(String.self, forKey: .strEmailID)
        strMobileNo = try values.decodeIfPresent(String.self, forKey: .strMobileNo)
        strProfileBase64 = try values.decodeIfPresent(String.self, forKey: .strProfileBase64)
        strProfilePath = try values.decodeIfPresent(String.self, forKey: .strProfilePath)
        strMobileURL = try values.decodeIfPresent(String.self, forKey: .strMobileURL)
    }

}
