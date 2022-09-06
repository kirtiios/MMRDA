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
    let intPlaceID : Int?
    let strStationName : String?
    let decStationLat : Double?
    let decStationLong : Double?
    let intRouteID : Int?
    let strRouteNo : String?
    let strRouteName : String?
    let strLocationName : String?
    let decLocationLat : Double?
    let decLocationLong : Double?
    let strSourceToDestinationLocation : String?
    let strLocationLatLong : String?

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
        case strSourceToDestinationLocation = "strSourceToDestinationLocation"
        case strLocationLatLong = "strLocationLatLong"
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
        intPlaceID = try values.decodeIfPresent(Int.self, forKey: .intPlaceID)
        strStationName = try values.decodeIfPresent(String.self, forKey: .strStationName)
        decStationLat = try values.decodeIfPresent(Double.self, forKey: .decStationLat)
        decStationLong = try values.decodeIfPresent(Double.self, forKey: .decStationLong)
        intRouteID = try values.decodeIfPresent(Int.self, forKey: .intRouteID)
        strRouteNo = try values.decodeIfPresent(String.self, forKey: .strRouteNo)
        strRouteName = try values.decodeIfPresent(String.self, forKey: .strRouteName)
        strLocationName = try values.decodeIfPresent(String.self, forKey: .strLocationName)
        decLocationLat = try values.decodeIfPresent(Double.self, forKey: .decLocationLat)
        decLocationLong = try values.decodeIfPresent(Double.self, forKey: .decLocationLong)
        strSourceToDestinationLocation = try values.decodeIfPresent(String.self, forKey: .strSourceToDestinationLocation)
        strLocationLatLong = try values.decodeIfPresent(String.self, forKey: .strLocationLatLong)
    }

}
struct favModel : Codable {
    var data : [favouriteList]?
    let message : String?
    let issuccess : Bool?
    let exception : String?
    let rowcount : Int?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case message = "message"
        case issuccess = "issuccess"
        case exception = "exception"
        case rowcount = "rowcount"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([favouriteList].self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        issuccess = try values.decodeIfPresent(Bool.self, forKey: .issuccess)
        exception = try values.decodeIfPresent(String.self, forKey: .exception)
        rowcount = try values.decodeIfPresent(Int.self, forKey: .rowcount)
    }

}

struct LocationResuleModel : Codable {
    let result : Int?

    enum CodingKeys: String, CodingKey {

        case result = "result"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Int.self, forKey: .result)
    }

}
