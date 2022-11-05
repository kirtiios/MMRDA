//
//  StationListModel.swift
//  MMRDA
//
//  Created by Kirti Chavda on 12/09/22.
//

import Foundation
struct StationListModel : Codable {
    let intTripID : Int?
    let strTripName : String?
    let intSourceID : Int?
    let strSourceName : String?
    let strDepartureTime : String?
    var intDestinationID : Int?
    var strDestinationName : String?
    let strArrivalTime : String?
    let decTotalDistance : Double?
    let intTotalTimeInMinutes : Int?
    let intTripStatus : Int?
    let strMetroLineNo : String?
    let strMetroNo : String?
    let refreshedAt : String?
    let strServiceType : String?
    var arrRouteData : [ArrRouteData]?
    let dteLastUpdatedAt : String?
    enum CodingKeys: String, CodingKey {

        case intTripID = "intTripID"
        case strTripName = "strTripName"
        case intSourceID = "intSourceID"
        case strSourceName = "strSourceName"
        case strDepartureTime = "strDepartureTime"
        case intDestinationID = "intDestinationID"
        case strDestinationName = "strDestinationName"
        case strArrivalTime = "strArrivalTime"
        case decTotalDistance = "decTotalDistance"
        case intTotalTimeInMinutes = "intTotalTimeInMinutes"
        case intTripStatus = "intTripStatus"
        case strMetroLineNo = "strMetroLineNo"
        case strMetroNo = "strMetroNo"
        case refreshedAt = "refreshedAt"
        case strServiceType = "strServiceType"
        case arrRouteData = "arrRouteData"
        case dteLastUpdatedAt = "dteLastUpdatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        intTripID = try values.decodeIfPresent(Int.self, forKey: .intTripID)
        strTripName = try values.decodeIfPresent(String.self, forKey: .strTripName)
        intSourceID = try values.decodeIfPresent(Int.self, forKey: .intSourceID)
        strSourceName = try values.decodeIfPresent(String.self, forKey: .strSourceName)
        strDepartureTime = try values.decodeIfPresent(String.self, forKey: .strDepartureTime)
        intDestinationID = try values.decodeIfPresent(Int.self, forKey: .intDestinationID)
        strDestinationName = try values.decodeIfPresent(String.self, forKey: .strDestinationName)
        strArrivalTime = try values.decodeIfPresent(String.self, forKey: .strArrivalTime)
        decTotalDistance = try values.decodeIfPresent(Double.self, forKey: .decTotalDistance)
        intTotalTimeInMinutes = try values.decodeIfPresent(Int.self, forKey: .intTotalTimeInMinutes)
        intTripStatus = try values.decodeIfPresent(Int.self, forKey: .intTripStatus)
        strMetroLineNo = try values.decodeIfPresent(String.self, forKey: .strMetroLineNo)
        strMetroNo = try values.decodeIfPresent(String.self, forKey: .strMetroNo)
        refreshedAt = try values.decodeIfPresent(String.self, forKey: .refreshedAt)
        strServiceType = try values.decodeIfPresent(String.self, forKey: .strServiceType)
        arrRouteData = try values.decodeIfPresent([ArrRouteData].self, forKey: .arrRouteData)
        dteLastUpdatedAt = try values.decodeIfPresent(String.self, forKey: .dteLastUpdatedAt)
    }

}
struct ArrStationData : Codable {
    let intStationID : Int?
    let strStationName : String?
    let strETA : String?
    let strETD : String?
    let isHalt : Int?
    let intTimeInMin : Int?
    let decStationLat : Double?
    let decStationLong : Double?
    var bNotify : Bool?
    let bCovered : Int?
    let bStatus : Int?
    let strStationCode : String?

    enum CodingKeys: String, CodingKey {

        case intStationID = "intStationID"
        case strStationName = "strStationName"
        case strETA = "strETA"
        case strETD = "strETD"
        case isHalt = "isHalt"
        case intTimeInMin = "intTimeInMin"
        case decStationLat = "decStationLat"
        case decStationLong = "decStationLong"
        case bNotify = "bNotify"
        case bCovered = "bCovered"
        case bStatus = "bStatus"
        case strStationCode = "strStationCode"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        intStationID = try values.decodeIfPresent(Int.self, forKey: .intStationID)
        strStationName = try values.decodeIfPresent(String.self, forKey: .strStationName)
        strETA = try values.decodeIfPresent(String.self, forKey: .strETA)
        strETD = try values.decodeIfPresent(String.self, forKey: .strETD)
        isHalt = try values.decodeIfPresent(Int.self, forKey: .isHalt)
        intTimeInMin = try values.decodeIfPresent(Int.self, forKey: .intTimeInMin)
        decStationLat = try values.decodeIfPresent(Double.self, forKey: .decStationLat)
        decStationLong = try values.decodeIfPresent(Double.self, forKey: .decStationLong)
        bNotify = try values.decodeIfPresent(Bool.self, forKey: .bNotify)
        bCovered = try values.decodeIfPresent(Int.self, forKey: .bCovered)
        bStatus = try values.decodeIfPresent(Int.self, forKey: .bStatus)
        strStationCode = try values.decodeIfPresent(String.self, forKey: .strStationCode)
    }

}
struct ArrRouteData : Codable {
    let intRouteID : Int?
    let strRouteName : String?
    let strKM : String?
    let intMetroID : Int?
    let strMetroLineNo : String?
    let strMetroNo : String?
    let intSourceID : Int?
    let strSourceName : String?
    let decSourceLat : Double?
    let decSourceLong : Double?
    var intDestinationID : Int?
    let strDestinationName : String?
    let decDestinationLat : Double?
    let decDestinationLong : Double?
    let isFavorite : Bool?
    var arrStationData : [ArrStationData]?

    enum CodingKeys: String, CodingKey {

        case intRouteID = "intRouteID"
        case strRouteName = "strRouteName"
        case strKM = "strKM"
        case intMetroID = "intMetroID"
        case strMetroLineNo = "strMetroLineNo"
        case strMetroNo = "strMetroNo"
        case intSourceID = "intSourceID"
        case strSourceName = "strSourceName"
        case decSourceLat = "decSourceLat"
        case decSourceLong = "decSourceLong"
        case intDestinationID = "intDestinationID"
        case strDestinationName = "strDestinationName"
        case decDestinationLat = "decDestinationLat"
        case decDestinationLong = "decDestinationLong"
        case isFavorite = "isFavorite"
        case arrStationData = "arrStationData"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        intRouteID = try values.decodeIfPresent(Int.self, forKey: .intRouteID)
        strRouteName = try values.decodeIfPresent(String.self, forKey: .strRouteName)
        strKM = try values.decodeIfPresent(String.self, forKey: .strKM)
        intMetroID = try values.decodeIfPresent(Int.self, forKey: .intMetroID)
        strMetroLineNo = try values.decodeIfPresent(String.self, forKey: .strMetroLineNo)
        strMetroNo = try values.decodeIfPresent(String.self, forKey: .strMetroNo)
        intSourceID = try values.decodeIfPresent(Int.self, forKey: .intSourceID)
        strSourceName = try values.decodeIfPresent(String.self, forKey: .strSourceName)
        decSourceLat = try values.decodeIfPresent(Double.self, forKey: .decSourceLat)
        decSourceLong = try values.decodeIfPresent(Double.self, forKey: .decSourceLong)
        intDestinationID = try values.decodeIfPresent(Int.self, forKey: .intDestinationID)
        strDestinationName = try values.decodeIfPresent(String.self, forKey: .strDestinationName)
        decDestinationLat = try values.decodeIfPresent(Double.self, forKey: .decDestinationLat)
        decDestinationLong = try values.decodeIfPresent(Double.self, forKey: .decDestinationLong)
        isFavorite = try values.decodeIfPresent(Bool.self, forKey: .isFavorite)
        arrStationData = try values.decodeIfPresent([ArrStationData].self, forKey: .arrStationData)
    }

}
struct filterTimeModelList : Codable {
    let value : Int?
    let viewValue : String?

    enum CodingKeys: String, CodingKey {

        case value = "value"
        case viewValue = "viewValue"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        value = try values.decodeIfPresent(Int.self, forKey: .value)
        viewValue = try values.decodeIfPresent(String.self, forKey: .viewValue)
    }

}
