//
//  RouterPlannerModel.swift
//  MMRDA
//
//  Created by Sandip Patel on 28/09/22.
//

import Foundation
struct JourneyPlannerModel : Codable {
    let journeyPlannerStationDetail : JourneyPlannerStationDetail?
    let transitPaths : [TransitPaths]?
    
    enum CodingKeys: String, CodingKey {
        
        case journeyPlannerStationDetail = "journeyPlannerStationDetail"
        case transitPaths = "transitPaths"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        journeyPlannerStationDetail = try values.decodeIfPresent(JourneyPlannerStationDetail.self, forKey: .journeyPlannerStationDetail)
        transitPaths = try values.decodeIfPresent([TransitPaths].self, forKey: .transitPaths)
    }
    
}
struct JourneyPlannerStationDetail : Codable {
    let decFromStationLat : Double?
    let decFromStationLong : Double?
    let intFromStationID : Int?
    let strFromStationName : String?
    let decToStationLat : Double?
    let decToStationLong : Double?
    let intToStationID : Int?
    let strToStationName : String?
    let km : Int?
    let fare : Int?
    let stationArrival : String?
    let isFavorite : Bool?
    
    let modeOfFromStationTravel : String?
    let modeOfToStationTravel : String?
    let fareOfFromStationTravel : Int?
    let fareOfToStationTravel : Int?
    let fromStationWalkDistance : Double?
    let toStationWalkDistance : Double?

    enum CodingKeys: String, CodingKey {

        case decFromStationLat = "decFromStationLat"
        case decFromStationLong = "decFromStationLong"
        case intFromStationID = "intFromStationID"
        case strFromStationName = "strFromStationName"
        case decToStationLat = "decToStationLat"
        case decToStationLong = "decToStationLong"
        case intToStationID = "intToStationID"
        case strToStationName = "strToStationName"
        case km = "km"
        case fare = "fare"
        case stationArrival = "stationArrival"
        case isFavorite = "isFavorite"
        case modeOfFromStationTravel = "modeOfFromStationTravel"
        case modeOfToStationTravel = "modeOfToStationTravel"
        case fareOfFromStationTravel = "fareOfFromStationTravel"
        case fareOfToStationTravel = "fareOfToStationTravel"
        case fromStationWalkDistance = "fromStationWalkDistance"
        case toStationWalkDistance = "toStationWalkDistance"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        decFromStationLat = try values.decodeIfPresent(Double.self, forKey: .decFromStationLat)
        decFromStationLong = try values.decodeIfPresent(Double.self, forKey: .decFromStationLong)
        intFromStationID = try values.decodeIfPresent(Int.self, forKey: .intFromStationID)
        strFromStationName = try values.decodeIfPresent(String.self, forKey: .strFromStationName)
        decToStationLat = try values.decodeIfPresent(Double.self, forKey: .decToStationLat)
        decToStationLong = try values.decodeIfPresent(Double.self, forKey: .decToStationLong)
        intToStationID = try values.decodeIfPresent(Int.self, forKey: .intToStationID)
        strToStationName = try values.decodeIfPresent(String.self, forKey: .strToStationName)
        km = try values.decodeIfPresent(Int.self, forKey: .km)
        fare = try values.decodeIfPresent(Int.self, forKey: .fare)
        stationArrival = try values.decodeIfPresent(String.self, forKey: .stationArrival)
        isFavorite = try values.decodeIfPresent(Bool.self, forKey: .isFavorite)
        modeOfFromStationTravel = try values.decodeIfPresent(String.self, forKey: .modeOfFromStationTravel)
        modeOfToStationTravel = try values.decodeIfPresent(String.self, forKey: .modeOfToStationTravel)
        fareOfFromStationTravel = try values.decodeIfPresent(Int.self, forKey: .fareOfFromStationTravel)
        fareOfToStationTravel = try values.decodeIfPresent(Int.self, forKey: .fareOfToStationTravel)
        fromStationWalkDistance = try values.decodeIfPresent(Double.self, forKey: .fromStationWalkDistance)
        toStationWalkDistance = try values.decodeIfPresent(Double.self, forKey: .toStationWalkDistance)
    }

}
struct TransitPaths : Codable {
    let pathSrNo : Int?
    let edgeSrNo : Int?
    let fromStationId : Int?
    let toStationId : Int?
    var fromStationName : String?
    let toStationName : String?
    let schNo : String?
    let distance : Int?
    var etaNode1 : String?
    let etaNode2 : String?
    let vehicleId : Int?
    let busno : String?
    let duration : String?
    let isTransfer : Bool?
    let tripId : Int?
    let routeid : Int?
    let routeno : String?
    let serviceTypeId : Int?
    var bCovered1 : String?
    let bCovered2 : String?
    var lat1 : String?
    var lat2 : String?
    var long1 : String?
    let long2 : String?

    enum CodingKeys: String, CodingKey {

        case pathSrNo = "pathSrNo"
        case edgeSrNo = "edgeSrNo"
        case fromStationId = "fromStationId"
        case toStationId = "toStationId"
        case fromStationName = "fromStationName"
        case toStationName = "toStationName"
        case schNo = "schNo"
        case distance = "distance"
        case etaNode1 = "etaNode1"
        case etaNode2 = "etaNode2"
        case vehicleId = "vehicleId"
        case busno = "busno"
        case duration = "duration"
        case isTransfer = "isTransfer"
        case tripId = "tripId"
        case routeid = "routeid"
        case routeno = "routeno"
        case serviceTypeId = "serviceTypeId"
        case bCovered1 = "bCovered1"
        case bCovered2 = "bCovered2"
        case lat1 = "lat1"
        case lat2 = "lat2"
        case long1 = "long1"
        case long2 = "long2"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pathSrNo = try values.decodeIfPresent(Int.self, forKey: .pathSrNo)
        edgeSrNo = try values.decodeIfPresent(Int.self, forKey: .edgeSrNo)
        fromStationId = try values.decodeIfPresent(Int.self, forKey: .fromStationId)
        toStationId = try values.decodeIfPresent(Int.self, forKey: .toStationId)
        fromStationName = try values.decodeIfPresent(String.self, forKey: .fromStationName)
        toStationName = try values.decodeIfPresent(String.self, forKey: .toStationName)
        schNo = try values.decodeIfPresent(String.self, forKey: .schNo)
        distance = try values.decodeIfPresent(Int.self, forKey: .distance)
        etaNode1 = try values.decodeIfPresent(String.self, forKey: .etaNode1)
        etaNode2 = try values.decodeIfPresent(String.self, forKey: .etaNode2)
        vehicleId = try values.decodeIfPresent(Int.self, forKey: .vehicleId)
        busno = try values.decodeIfPresent(String.self, forKey: .busno)
        duration = try values.decodeIfPresent(String.self, forKey: .duration)
        isTransfer = try values.decodeIfPresent(Bool.self, forKey: .isTransfer)
        tripId = try values.decodeIfPresent(Int.self, forKey: .tripId)
        routeid = try values.decodeIfPresent(Int.self, forKey: .routeid)
        routeno = try values.decodeIfPresent(String.self, forKey: .routeno)
        serviceTypeId = try values.decodeIfPresent(Int.self, forKey: .serviceTypeId)
        bCovered1 = try values.decodeIfPresent(String.self, forKey: .bCovered1)
        bCovered2 = try values.decodeIfPresent(String.self, forKey: .bCovered2)
        lat1 = try values.decodeIfPresent(String.self, forKey: .lat1)
        lat2 = try values.decodeIfPresent(String.self, forKey: .lat2)
        long1 = try values.decodeIfPresent(String.self, forKey: .long1)
        long2 = try values.decodeIfPresent(String.self, forKey: .long2)
    }

}
