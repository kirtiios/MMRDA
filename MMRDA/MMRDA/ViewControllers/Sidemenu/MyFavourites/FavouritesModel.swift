//
//  FavouritesModel.swift
//  MMRDA
//
//  Created by Kirti Chavda on 31/08/22.
//

import Foundation
struct favouriteList : Codable {
    let intFavouriteID : Int?
    let intUserID : Int?
    let strAddress : String?
    let strlabel : String?
    let locationType : String?
    let intFavouriteTypeID : Int?
    let strFavouriteType : String?
    let intPlaceID : String?
    let strStationName : String?
    let decStationLat : String?
    let decStationLong : String?
    let intRouteID : String?
    let strRouteNo : String?
    let strRouteName : String?
    let strLocationName : String?
    let decLocationLat : Double?
    let decLocationLong : Double?

    enum CodingKeys: String, CodingKey {

        case intFavouriteID = "intFavouriteID"
        case intUserID = "intUserID"
        case strAddress = "strAddress"
        case strlabel = "strlabel"
        case locationType = "locationType"
        case intFavouriteTypeID = "intFavouriteTypeID"
        case strFavouriteType = "strFavouriteType"
        case intPlaceID = "intPlaceID"
        case strStationName = "strStationName"
        case decStationLat = "decStationLat"
        case decStationLong = "decStationLong"
        case intRouteID = "intRouteID"
        case strRouteNo = "strRouteNo"
        case strRouteName = "strRouteName"
        case strLocationName = "strLocationName"
        case decLocationLat = "decLocationLat"
        case decLocationLong = "decLocationLong"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        intFavouriteID = try values.decodeIfPresent(Int.self, forKey: .intFavouriteID)
        intUserID = try values.decodeIfPresent(Int.self, forKey: .intUserID)
        strAddress = try values.decodeIfPresent(String.self, forKey: .strAddress)
        strlabel = try values.decodeIfPresent(String.self, forKey: .strlabel)
        locationType = try values.decodeIfPresent(String.self, forKey: .locationType)
        intFavouriteTypeID = try values.decodeIfPresent(Int.self, forKey: .intFavouriteTypeID)
        strFavouriteType = try values.decodeIfPresent(String.self, forKey: .strFavouriteType)
        intPlaceID = try values.decodeIfPresent(String.self, forKey: .intPlaceID)
        strStationName = try values.decodeIfPresent(String.self, forKey: .strStationName)
        decStationLat = try values.decodeIfPresent(String.self, forKey: .decStationLat)
        decStationLong = try values.decodeIfPresent(String.self, forKey: .decStationLong)
        intRouteID = try values.decodeIfPresent(String.self, forKey: .intRouteID)
        strRouteNo = try values.decodeIfPresent(String.self, forKey: .strRouteNo)
        strRouteName = try values.decodeIfPresent(String.self, forKey: .strRouteName)
        strLocationName = try values.decodeIfPresent(String.self, forKey: .strLocationName)
        decLocationLat = try values.decodeIfPresent(Double.self, forKey: .decLocationLat)
        decLocationLong = try values.decodeIfPresent(Double.self, forKey: .decLocationLong)
    }

}
