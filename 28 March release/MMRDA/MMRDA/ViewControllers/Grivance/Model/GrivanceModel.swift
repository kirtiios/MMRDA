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
    let dteComplainCloseDateTime : String?
    let dteComplainInProgressDateTime : String?
    let strFileName : String?

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
        case dteComplainCloseDateTime = "dteComplainCloseDateTime"
        case dteComplainInProgressDateTime = "dteComplainInProgressDateTime"
        case strFileName = "strFileName"
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
        dteComplainCloseDateTime = try values.decodeIfPresent(String.self, forKey: .dteComplainCloseDateTime)
        dteComplainInProgressDateTime = try values.decodeIfPresent(String.self, forKey: .dteComplainInProgressDateTime)
        strFileName = try values.decodeIfPresent(String.self, forKey: .strFileName)
    }

}
