//
//  GrivanceModel.swift
//  MMRDA
//
//  Created by Sandip Patel on 17/10/22.
//

import Foundation
struct grivanceCategory : Codable {
    let intComplainCategoryID : Int?
    let strComplainCategoryName : String?

    enum CodingKeys: String, CodingKey {

        case intComplainCategoryID = "intComplainCategoryID"
        case strComplainCategoryName = "strComplainCategoryName"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        intComplainCategoryID = try values.decodeIfPresent(Int.self, forKey: .intComplainCategoryID)
        strComplainCategoryName = try values.decodeIfPresent(String.self, forKey: .strComplainCategoryName)
    }

}

struct grivanceSubCategory : Codable {
    let intItemID : Int?
    let strItemName : String?

    enum CodingKeys: String, CodingKey {

        case intItemID = "intItemID"
        case strItemName = "strItemName"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        intItemID = try values.decodeIfPresent(Int.self, forKey: .intItemID)
        strItemName = try values.decodeIfPresent(String.self, forKey: .strItemName)
    }

}
struct grivanceRouteList: Codable {
    let intRouteID : Int?
    let strRouteName : String?

    enum CodingKeys: String, CodingKey {

        case intRouteID = "intRouteID"
        case strRouteName = "strRouteName"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        intRouteID = try values.decodeIfPresent(Int.self, forKey: .intRouteID)
        strRouteName = try values.decodeIfPresent(String.self, forKey: .strRouteName)
    }

}
struct grivanceVechicleList : Codable {
    let intVehicleID : Int?
    let strVehicleCode : String?

    enum CodingKeys: String, CodingKey {

        case intVehicleID = "intVehicleID"
        case strVehicleCode = "strVehicleCode"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        intVehicleID = try values.decodeIfPresent(Int.self, forKey: .intVehicleID)
        strVehicleCode = try values.decodeIfPresent(String.self, forKey: .strVehicleCode)
    }

}
struct grivanceList : Codable {
    let intComplainID : Int?
    let strComplainCode : String?
    let strModeName : String?
    let strItemName : String?
    let dteCreatedOn : String?
    let strComplainerName : String?
    let strComplainerMobileNo : String?
    let strDetails : String?
    let strDescription : String?
    let strComplainerEmailID : String?
    let dteIncidentDate : String?
    let intComplainStatusID : Int?
    let strComplainStatus : String?
    let strStatusColour : String?
    let dteComplainCloseDateTime : String?
    let dteComplainInProgressDateTime : String?
    let strFileName : String?
    let comments : [Comments]?
    let statusTrack : [StatusTrack]?

    enum CodingKeys: String, CodingKey {

        case intComplainID = "intComplainID"
        case strComplainCode = "strComplainCode"
        case strModeName = "strModeName"
        case strItemName = "strItemName"
        case dteCreatedOn = "dteCreatedOn"
        case strComplainerName = "strComplainerName"
        case strComplainerMobileNo = "strComplainerMobileNo"
        case strDetails = "strDetails"
        case strDescription = "strDescription"
        case strComplainerEmailID = "strComplainerEmailID"
        case dteIncidentDate = "dteIncidentDate"
        case intComplainStatusID = "intComplainStatusID"
        case strComplainStatus = "strComplainStatus"
        case strStatusColour = "strStatusColour"
        case dteComplainCloseDateTime = "dteComplainCloseDateTime"
        case dteComplainInProgressDateTime = "dteComplainInProgressDateTime"
        case strFileName = "strFileName"
        case comments = "comments"
        case statusTrack = "statusTrack"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        intComplainID = try values.decodeIfPresent(Int.self, forKey: .intComplainID)
        strComplainCode = try values.decodeIfPresent(String.self, forKey: .strComplainCode)
        strModeName = try values.decodeIfPresent(String.self, forKey: .strModeName)
        strItemName = try values.decodeIfPresent(String.self, forKey: .strItemName)
        dteCreatedOn = try values.decodeIfPresent(String.self, forKey: .dteCreatedOn)
        strComplainerName = try values.decodeIfPresent(String.self, forKey: .strComplainerName)
        strComplainerMobileNo = try values.decodeIfPresent(String.self, forKey: .strComplainerMobileNo)
        strDetails = try values.decodeIfPresent(String.self, forKey: .strDetails)
        strDescription = try values.decodeIfPresent(String.self, forKey: .strDescription)
        strComplainerEmailID = try values.decodeIfPresent(String.self, forKey: .strComplainerEmailID)
        dteIncidentDate = try values.decodeIfPresent(String.self, forKey: .dteIncidentDate)
        intComplainStatusID = try values.decodeIfPresent(Int.self, forKey: .intComplainStatusID)
        strComplainStatus = try values.decodeIfPresent(String.self, forKey: .strComplainStatus)
        strStatusColour = try values.decodeIfPresent(String.self, forKey: .strStatusColour)
        dteComplainCloseDateTime = try values.decodeIfPresent(String.self, forKey: .dteComplainCloseDateTime)
        dteComplainInProgressDateTime = try values.decodeIfPresent(String.self, forKey: .dteComplainInProgressDateTime)
        strFileName = try values.decodeIfPresent(String.self, forKey: .strFileName)
        comments = try values.decodeIfPresent([Comments].self, forKey: .comments)
        statusTrack = try values.decodeIfPresent([StatusTrack].self, forKey: .statusTrack)
    }

}
struct Comments : Codable {
    let strRemarks : String?
    let strUserName : String?
    let strProfileUrl : String?
    let dteCommentCreatedOn : String?

    enum CodingKeys: String, CodingKey {

        case strRemarks = "strRemarks"
        case strUserName = "strUserName"
        case strProfileUrl = "strProfileUrl"
        case dteCommentCreatedOn = "dteCommentCreatedOn"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        strRemarks = try values.decodeIfPresent(String.self, forKey: .strRemarks)
        strUserName = try values.decodeIfPresent(String.self, forKey: .strUserName)
        strProfileUrl = try values.decodeIfPresent(String.self, forKey: .strProfileUrl)
        dteCommentCreatedOn = try values.decodeIfPresent(String.self, forKey: .dteCommentCreatedOn)
    }

}
struct StatusTrack : Codable {
    let strStatusName : String?
    let strStatusColour : String?
    let dteStatusCreatedOn : String?

    enum CodingKeys: String, CodingKey {

        case strStatusName = "strStatusName"
        case strStatusColour = "strStatusColour"
        case dteStatusCreatedOn = "dteStatusCreatedOn"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        strStatusName = try values.decodeIfPresent(String.self, forKey: .strStatusName)
        strStatusColour = try values.decodeIfPresent(String.self, forKey: .strStatusColour)
        dteStatusCreatedOn = try values.decodeIfPresent(String.self, forKey: .dteStatusCreatedOn)
    }

}
