//
//  RouterPlannerModel.swift
//  MMRDA
//
//  Created by Sandip Patel on 28/09/22.
//

import Foundation
struct JourneyPlannerModel : Codable {
    let journeyPlannerStationDetail : JourneyPlannerStationDetail?
    var transitPaths : [TransitPaths]?
    
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

//struct JourneyPlannerStationDetail : Codable {
//    let decFromStationLat : Double?
//    let decFromStationLong : Double?
//    let decFromMetroStationLat : Double?
//    let decFromMetroStationLong : Double?
//    let intFromStationID : Int?
//    let strFromStationName : String?
//    let decToStationLat : Double?
//    let decToStationLong : Double?
//    let decToMetroStationLat : Double?
//    let decToMetroStationLong : Double?
//    let intToStationID : Int?
//    let strToStationName : String?
//    let startingMYBYKPath : StartingMYBYKPath?
//    let isValidStartingMYBYK : Bool?
//    let endingMYBYKPath : EndingMYBYKPath?
//    let isValidEndingMYBYK : Bool?
//    let km : Double?
//    let fare : Double?
//    let stationArrival : String?
//    let isFavorite : Bool?
//    let fromStationWalkDistance : Double?
//    let toStationWalkDistance : Double?
//    let isValidStation : Bool?
//    let fromStationArrival : String?
//    let toStationDepature : String?
//    let modeOfFromStationTravel : String?
//    let modeOfToStationTravel : String?
//    let fareOfFromStationTravel : Int?
//    let fareOfToStationTravel : Int?
//
//    enum CodingKeys: String, CodingKey {
//
//        case decFromStationLat = "decFromStationLat"
//        case decFromStationLong = "decFromStationLong"
//        case decFromMetroStationLat = "decFromMetroStationLat"
//        case decFromMetroStationLong = "decFromMetroStationLong"
//        case intFromStationID = "intFromStationID"
//        case strFromStationName = "strFromStationName"
//        case decToStationLat = "decToStationLat"
//        case decToStationLong = "decToStationLong"
//        case decToMetroStationLat = "decToMetroStationLat"
//        case decToMetroStationLong = "decToMetroStationLong"
//        case intToStationID = "intToStationID"
//        case strToStationName = "strToStationName"
//        case startingMYBYKPath = "startingMYBYKPath"
//        case isValidStartingMYBYK = "isValidStartingMYBYK"
//        case endingMYBYKPath = "endingMYBYKPath"
//        case isValidEndingMYBYK = "isValidEndingMYBYK"
//        case km = "km"
//        case fare = "fare"
//        case stationArrival = "stationArrival"
//        case isFavorite = "isFavorite"
//        case fromStationWalkDistance = "fromStationWalkDistance"
//        case toStationWalkDistance = "toStationWalkDistance"
//        case isValidStation = "isValidStation"
//        case fromStationArrival = "fromStationArrival"
//        case toStationDepature = "toStationDepature"
//        case modeOfFromStationTravel = "modeOfFromStationTravel"
//        case modeOfToStationTravel = "modeOfToStationTravel"
//        case fareOfFromStationTravel = "fareOfFromStationTravel"
//        case fareOfToStationTravel = "fareOfToStationTravel"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        decFromStationLat = try values.decodeIfPresent(Double.self, forKey: .decFromStationLat)
//        decFromStationLong = try values.decodeIfPresent(Double.self, forKey: .decFromStationLong)
//        decFromMetroStationLat = try values.decodeIfPresent(Double.self, forKey: .decFromMetroStationLat)
//        decFromMetroStationLong = try values.decodeIfPresent(Double.self, forKey: .decFromMetroStationLong)
//        intFromStationID = try values.decodeIfPresent(Int.self, forKey: .intFromStationID)
//        strFromStationName = try values.decodeIfPresent(String.self, forKey: .strFromStationName)
//        decToStationLat = try values.decodeIfPresent(Double.self, forKey: .decToStationLat)
//        decToStationLong = try values.decodeIfPresent(Double.self, forKey: .decToStationLong)
//        decToMetroStationLat = try values.decodeIfPresent(Double.self, forKey: .decToMetroStationLat)
//        decToMetroStationLong = try values.decodeIfPresent(Double.self, forKey: .decToMetroStationLong)
//        intToStationID = try values.decodeIfPresent(Int.self, forKey: .intToStationID)
//        strToStationName = try values.decodeIfPresent(String.self, forKey: .strToStationName)
//        startingMYBYKPath = try values.decodeIfPresent(StartingMYBYKPath.self, forKey: .startingMYBYKPath)
//        isValidStartingMYBYK = try values.decodeIfPresent(Bool.self, forKey: .isValidStartingMYBYK)
//        endingMYBYKPath = try values.decodeIfPresent(EndingMYBYKPath.self, forKey: .endingMYBYKPath)
//        isValidEndingMYBYK = try values.decodeIfPresent(Bool.self, forKey: .isValidEndingMYBYK)
//        km = try values.decodeIfPresent(Double.self, forKey: .km)
//        fare = try values.decodeIfPresent(Double.self, forKey: .fare)
//        stationArrival = try values.decodeIfPresent(String.self, forKey: .stationArrival)
//        isFavorite = try values.decodeIfPresent(Bool.self, forKey: .isFavorite)
//        fromStationWalkDistance = try values.decodeIfPresent(Double.self, forKey: .fromStationWalkDistance)
//        toStationWalkDistance = try values.decodeIfPresent(Double.self, forKey: .toStationWalkDistance)
//        isValidStation = try values.decodeIfPresent(Bool.self, forKey: .isValidStation)
//        fromStationArrival = try values.decodeIfPresent(String.self, forKey: .fromStationArrival)
//        toStationDepature = try values.decodeIfPresent(String.self, forKey: .toStationDepature)
//        modeOfFromStationTravel = try values.decodeIfPresent(String.self, forKey: .modeOfFromStationTravel)
//        modeOfToStationTravel = try values.decodeIfPresent(String.self, forKey: .modeOfToStationTravel)
//        fareOfFromStationTravel = try values.decodeIfPresent(Int.self, forKey: .fareOfFromStationTravel)
//        fareOfToStationTravel = try values.decodeIfPresent(Int.self, forKey: .fareOfToStationTravel)
//    }
//
//}
struct JourneyPlannerStationDetail : Codable {
    let decFromStationLat : Double?
    let decFromStationLong : Double?
    let decFromMetroStationLat : Double?
    let decFromMetroStationLong : Double?
    let intFromStationID : Int?
    let strFromStationName : String?
    let decToStationLat : Double?
    let decToStationLong : Double?
    let decToMetroStationLat : Double?
    let decToMetroStationLong : Double?
    let intToStationID : Int?
    let strToStationName : String?
    let startingMYBYKPath : StartingMYBYKPath?
    let isValidStartingMYBYK : Bool?
    let endingMYBYKPath : EndingMYBYKPath?
    let isValidEndingMYBYK : Bool?
    let km : Double?
    let fare : Double?
    let stationArrival : String?
    let isFavorite : Bool?
    let fromStationWalkDistance : Double?
    let toStationWalkDistance : Double?
    let isValidStation : Bool?
    let fromStationArrival : String?
    let toStationDepature : String?
    let modeOfFromStationTravel : String?
    let modeOfToStationTravel : String?
    let strDuration : String?
    let strCurrentDate : String?
    let intPlatformChange : Int?
    let strFromTime : String?
    let strToTime : String?
    let fareOfFromStationTravel : Int?
    let fareOfToStationTravel : Int?

    enum CodingKeys: String, CodingKey {

        case decFromStationLat = "decFromStationLat"
        case decFromStationLong = "decFromStationLong"
        case decFromMetroStationLat = "decFromMetroStationLat"
        case decFromMetroStationLong = "decFromMetroStationLong"
        case intFromStationID = "intFromStationID"
        case strFromStationName = "strFromStationName"
        case decToStationLat = "decToStationLat"
        case decToStationLong = "decToStationLong"
        case decToMetroStationLat = "decToMetroStationLat"
        case decToMetroStationLong = "decToMetroStationLong"
        case intToStationID = "intToStationID"
        case strToStationName = "strToStationName"
        case startingMYBYKPath = "startingMYBYKPath"
        case isValidStartingMYBYK = "isValidStartingMYBYK"
        case endingMYBYKPath = "endingMYBYKPath"
        case isValidEndingMYBYK = "isValidEndingMYBYK"
        case km = "km"
        case fare = "fare"
        case stationArrival = "stationArrival"
        case isFavorite = "isFavorite"
        case fromStationWalkDistance = "fromStationWalkDistance"
        case toStationWalkDistance = "toStationWalkDistance"
        case isValidStation = "isValidStation"
        case fromStationArrival = "fromStationArrival"
        case toStationDepature = "toStationDepature"
        case modeOfFromStationTravel = "modeOfFromStationTravel"
        case modeOfToStationTravel = "modeOfToStationTravel"
        case strDuration = "strDuration"
        case strCurrentDate = "strCurrentDate"
        case intPlatformChange = "intPlatformChange"
        case strFromTime = "strFromTime"
        case strToTime = "strToTime"
        case fareOfFromStationTravel = "fareOfFromStationTravel"
        case fareOfToStationTravel = "fareOfToStationTravel"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        decFromStationLat = try values.decodeIfPresent(Double.self, forKey: .decFromStationLat)
        decFromStationLong = try values.decodeIfPresent(Double.self, forKey: .decFromStationLong)
        decFromMetroStationLat = try values.decodeIfPresent(Double.self, forKey: .decFromMetroStationLat)
        decFromMetroStationLong = try values.decodeIfPresent(Double.self, forKey: .decFromMetroStationLong)
        intFromStationID = try values.decodeIfPresent(Int.self, forKey: .intFromStationID)
        strFromStationName = try values.decodeIfPresent(String.self, forKey: .strFromStationName)
        decToStationLat = try values.decodeIfPresent(Double.self, forKey: .decToStationLat)
        decToStationLong = try values.decodeIfPresent(Double.self, forKey: .decToStationLong)
        decToMetroStationLat = try values.decodeIfPresent(Double.self, forKey: .decToMetroStationLat)
        decToMetroStationLong = try values.decodeIfPresent(Double.self, forKey: .decToMetroStationLong)
        intToStationID = try values.decodeIfPresent(Int.self, forKey: .intToStationID)
        strToStationName = try values.decodeIfPresent(String.self, forKey: .strToStationName)
        startingMYBYKPath = try values.decodeIfPresent(StartingMYBYKPath.self, forKey: .startingMYBYKPath)
        isValidStartingMYBYK = try values.decodeIfPresent(Bool.self, forKey: .isValidStartingMYBYK)
        endingMYBYKPath = try values.decodeIfPresent(EndingMYBYKPath.self, forKey: .endingMYBYKPath)
        isValidEndingMYBYK = try values.decodeIfPresent(Bool.self, forKey: .isValidEndingMYBYK)
        km = try values.decodeIfPresent(Double.self, forKey: .km)
        fare = try values.decodeIfPresent(Double.self, forKey: .fare)
        stationArrival = try values.decodeIfPresent(String.self, forKey: .stationArrival)
        isFavorite = try values.decodeIfPresent(Bool.self, forKey: .isFavorite)
        fromStationWalkDistance = try values.decodeIfPresent(Double.self, forKey: .fromStationWalkDistance)
        toStationWalkDistance = try values.decodeIfPresent(Double.self, forKey: .toStationWalkDistance)
        isValidStation = try values.decodeIfPresent(Bool.self, forKey: .isValidStation)
        fromStationArrival = try values.decodeIfPresent(String.self, forKey: .fromStationArrival)
        toStationDepature = try values.decodeIfPresent(String.self, forKey: .toStationDepature)
        modeOfFromStationTravel = try values.decodeIfPresent(String.self, forKey: .modeOfFromStationTravel)
        modeOfToStationTravel = try values.decodeIfPresent(String.self, forKey: .modeOfToStationTravel)
        strDuration = try values.decodeIfPresent(String.self, forKey: .strDuration)
        strCurrentDate = try values.decodeIfPresent(String.self, forKey: .strCurrentDate)
        intPlatformChange = try values.decodeIfPresent(Int.self, forKey: .intPlatformChange)
        strFromTime = try values.decodeIfPresent(String.self, forKey: .strFromTime)
        strToTime = try values.decodeIfPresent(String.self, forKey: .strToTime)
        fareOfFromStationTravel = try values.decodeIfPresent(Int.self, forKey: .fareOfFromStationTravel)
        fareOfToStationTravel = try values.decodeIfPresent(Int.self, forKey: .fareOfToStationTravel)
    }

}

struct StartingMYBYKPath : Codable {
    let intFromMYBYKStationID : Int?
    let intToMYBYKStationID : Int?
    let strFromMYBYKStationName : String?
    let strToMYBYKStationName : String?
    let decFromMYBYKStationLat : Double?
    let decFromMYBYKStationLong : Double?
    let decToMYBYKStationLat : Double?
    let decToMYBYKStationLong : Double?
    let intFromMYBYKWorkingCycle : Int?
    let intFromMYBYKALLCycle : Int?
    let intToMYBYKWorkingCycle : Int?
    let intToMYBYKAllCycle : Int?
    let decFromMYBYKStationDistance : Double?
    let decToMYBYKStationDistance : Double?
    let decFrom_ToMYBYKStationDistance : Double?
    let duration : String?
    let strFromHubArrival : String?
    let strToHubArrival : String?

    enum CodingKeys: String, CodingKey {

        case intFromMYBYKStationID = "intFromMYBYKStationID"
        case intToMYBYKStationID = "intToMYBYKStationID"
        case strFromMYBYKStationName = "strFromMYBYKStationName"
        case strToMYBYKStationName = "strToMYBYKStationName"
        case decFromMYBYKStationLat = "decFromMYBYKStationLat"
        case decFromMYBYKStationLong = "decFromMYBYKStationLong"
        case decToMYBYKStationLat = "decToMYBYKStationLat"
        case decToMYBYKStationLong = "decToMYBYKStationLong"
        case intFromMYBYKWorkingCycle = "intFromMYBYKWorkingCycle"
        case intFromMYBYKALLCycle = "intFromMYBYKALLCycle"
        case intToMYBYKWorkingCycle = "intToMYBYKWorkingCycle"
        case intToMYBYKAllCycle = "intToMYBYKAllCycle"
        case decFromMYBYKStationDistance = "decFromMYBYKStationDistance"
        case decToMYBYKStationDistance = "decToMYBYKStationDistance"
        case decFrom_ToMYBYKStationDistance = "decFrom_ToMYBYKStationDistance"
        case duration = "duration"
        case strFromHubArrival = "strFromHubArrival"
        case strToHubArrival = "strToHubArrival"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        intFromMYBYKStationID = try values.decodeIfPresent(Int.self, forKey: .intFromMYBYKStationID)
        intToMYBYKStationID = try values.decodeIfPresent(Int.self, forKey: .intToMYBYKStationID)
        strFromMYBYKStationName = try values.decodeIfPresent(String.self, forKey: .strFromMYBYKStationName)
        strToMYBYKStationName = try values.decodeIfPresent(String.self, forKey: .strToMYBYKStationName)
        decFromMYBYKStationLat = try values.decodeIfPresent(Double.self, forKey: .decFromMYBYKStationLat)
        decFromMYBYKStationLong = try values.decodeIfPresent(Double.self, forKey: .decFromMYBYKStationLong)
        decToMYBYKStationLat = try values.decodeIfPresent(Double.self, forKey: .decToMYBYKStationLat)
        decToMYBYKStationLong = try values.decodeIfPresent(Double.self, forKey: .decToMYBYKStationLong)
        intFromMYBYKWorkingCycle = try values.decodeIfPresent(Int.self, forKey: .intFromMYBYKWorkingCycle)
        intFromMYBYKALLCycle = try values.decodeIfPresent(Int.self, forKey: .intFromMYBYKALLCycle)
        intToMYBYKWorkingCycle = try values.decodeIfPresent(Int.self, forKey: .intToMYBYKWorkingCycle)
        intToMYBYKAllCycle = try values.decodeIfPresent(Int.self, forKey: .intToMYBYKAllCycle)
        decFromMYBYKStationDistance = try values.decodeIfPresent(Double.self, forKey: .decFromMYBYKStationDistance)
        decToMYBYKStationDistance = try values.decodeIfPresent(Double.self, forKey: .decToMYBYKStationDistance)
        decFrom_ToMYBYKStationDistance = try values.decodeIfPresent(Double.self, forKey: .decFrom_ToMYBYKStationDistance)
        duration = try values.decodeIfPresent(String.self, forKey: .duration)
        strFromHubArrival = try values.decodeIfPresent(String.self, forKey: .strFromHubArrival)
        strToHubArrival = try values.decodeIfPresent(String.self, forKey: .strToHubArrival)
    }

}

struct EndingMYBYKPath : Codable {
    let intFromMYBYKStationID : Int?
    let intToMYBYKStationID : Int?
    let strFromMYBYKStationName : String?
    let strToMYBYKStationName : String?
    let decFromMYBYKStationLat : Double?
    let decFromMYBYKStationLong : Double?
    let decToMYBYKStationLat : Double?
    let decToMYBYKStationLong : Double?
    let intFromMYBYKWorkingCycle : Int?
    let intFromMYBYKALLCycle : Int?
    let intToMYBYKWorkingCycle : Int?
    let intToMYBYKAllCycle : Int?
    let decFromMYBYKStationDistance : Double?
    let decToMYBYKStationDistance : Double?
    let decFrom_ToMYBYKStationDistance : Double?
    let duration : String?
    let strFromHubArrival : String?
    let strToHubArrival : String?

    enum CodingKeys: String, CodingKey {

        case intFromMYBYKStationID = "intFromMYBYKStationID"
        case intToMYBYKStationID = "intToMYBYKStationID"
        case strFromMYBYKStationName = "strFromMYBYKStationName"
        case strToMYBYKStationName = "strToMYBYKStationName"
        case decFromMYBYKStationLat = "decFromMYBYKStationLat"
        case decFromMYBYKStationLong = "decFromMYBYKStationLong"
        case decToMYBYKStationLat = "decToMYBYKStationLat"
        case decToMYBYKStationLong = "decToMYBYKStationLong"
        case intFromMYBYKWorkingCycle = "intFromMYBYKWorkingCycle"
        case intFromMYBYKALLCycle = "intFromMYBYKALLCycle"
        case intToMYBYKWorkingCycle = "intToMYBYKWorkingCycle"
        case intToMYBYKAllCycle = "intToMYBYKAllCycle"
        case decFromMYBYKStationDistance = "decFromMYBYKStationDistance"
        case decToMYBYKStationDistance = "decToMYBYKStationDistance"
        case decFrom_ToMYBYKStationDistance = "decFrom_ToMYBYKStationDistance"
        case duration = "duration"
        case strFromHubArrival = "strFromHubArrival"
        case strToHubArrival = "strToHubArrival"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        intFromMYBYKStationID = try values.decodeIfPresent(Int.self, forKey: .intFromMYBYKStationID)
        intToMYBYKStationID = try values.decodeIfPresent(Int.self, forKey: .intToMYBYKStationID)
        strFromMYBYKStationName = try values.decodeIfPresent(String.self, forKey: .strFromMYBYKStationName)
        strToMYBYKStationName = try values.decodeIfPresent(String.self, forKey: .strToMYBYKStationName)
        decFromMYBYKStationLat = try values.decodeIfPresent(Double.self, forKey: .decFromMYBYKStationLat)
        decFromMYBYKStationLong = try values.decodeIfPresent(Double.self, forKey: .decFromMYBYKStationLong)
        decToMYBYKStationLat = try values.decodeIfPresent(Double.self, forKey: .decToMYBYKStationLat)
        decToMYBYKStationLong = try values.decodeIfPresent(Double.self, forKey: .decToMYBYKStationLong)
        intFromMYBYKWorkingCycle = try values.decodeIfPresent(Int.self, forKey: .intFromMYBYKWorkingCycle)
        intFromMYBYKALLCycle = try values.decodeIfPresent(Int.self, forKey: .intFromMYBYKALLCycle)
        intToMYBYKWorkingCycle = try values.decodeIfPresent(Int.self, forKey: .intToMYBYKWorkingCycle)
        intToMYBYKAllCycle = try values.decodeIfPresent(Int.self, forKey: .intToMYBYKAllCycle)
        decFromMYBYKStationDistance = try values.decodeIfPresent(Double.self, forKey: .decFromMYBYKStationDistance)
        decToMYBYKStationDistance = try values.decodeIfPresent(Double.self, forKey: .decToMYBYKStationDistance)
        decFrom_ToMYBYKStationDistance = try values.decodeIfPresent(Double.self, forKey: .decFrom_ToMYBYKStationDistance)
        duration = try values.decodeIfPresent(String.self, forKey: .duration)
        strFromHubArrival = try values.decodeIfPresent(String.self, forKey: .strFromHubArrival)
        strToHubArrival = try values.decodeIfPresent(String.self, forKey: .strToHubArrival)
    }

}
//struct JourneyPlannerStationDetail : Codable {
//    let decFromStationLat : Double?
//    let decFromStationLong : Double?
//    let intFromStationID : Int?
//    let strFromStationName : String?
//    let decToStationLat : Double?
//    let decToStationLong : Double?
//    let intToStationID : Int?
//    let strToStationName : String?
//    let km : Int?
//    let fare : Int?
//    let stationArrival : String?
//    let isFavorite : Bool?
//
//    let modeOfFromStationTravel : String?
//    let modeOfToStationTravel : String?
//    let fareOfFromStationTravel : Int?
//    let fareOfToStationTravel : Int?
//    let fromStationWalkDistance : Double?
//    let toStationWalkDistance : Double?
//
//    enum CodingKeys: String, CodingKey {
//
//        case decFromStationLat = "decFromStationLat"
//        case decFromStationLong = "decFromStationLong"
//        case intFromStationID = "intFromStationID"
//        case strFromStationName = "strFromStationName"
//        case decToStationLat = "decToStationLat"
//        case decToStationLong = "decToStationLong"
//        case intToStationID = "intToStationID"
//        case strToStationName = "strToStationName"
//        case km = "km"
//        case fare = "fare"
//        case stationArrival = "stationArrival"
//        case isFavorite = "isFavorite"
//        case modeOfFromStationTravel = "modeOfFromStationTravel"
//        case modeOfToStationTravel = "modeOfToStationTravel"
//        case fareOfFromStationTravel = "fareOfFromStationTravel"
//        case fareOfToStationTravel = "fareOfToStationTravel"
//        case fromStationWalkDistance = "fromStationWalkDistance"
//        case toStationWalkDistance = "toStationWalkDistance"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        decFromStationLat = try values.decodeIfPresent(Double.self, forKey: .decFromStationLat)
//        decFromStationLong = try values.decodeIfPresent(Double.self, forKey: .decFromStationLong)
//        intFromStationID = try values.decodeIfPresent(Int.self, forKey: .intFromStationID)
//        strFromStationName = try values.decodeIfPresent(String.self, forKey: .strFromStationName)
//        decToStationLat = try values.decodeIfPresent(Double.self, forKey: .decToStationLat)
//        decToStationLong = try values.decodeIfPresent(Double.self, forKey: .decToStationLong)
//        intToStationID = try values.decodeIfPresent(Int.self, forKey: .intToStationID)
//        strToStationName = try values.decodeIfPresent(String.self, forKey: .strToStationName)
//        km = try values.decodeIfPresent(Int.self, forKey: .km)
//        fare = try values.decodeIfPresent(Int.self, forKey: .fare)
//        stationArrival = try values.decodeIfPresent(String.self, forKey: .stationArrival)
//        isFavorite = try values.decodeIfPresent(Bool.self, forKey: .isFavorite)
//        modeOfFromStationTravel = try values.decodeIfPresent(String.self, forKey: .modeOfFromStationTravel)
//        modeOfToStationTravel = try values.decodeIfPresent(String.self, forKey: .modeOfToStationTravel)
//        fareOfFromStationTravel = try values.decodeIfPresent(Int.self, forKey: .fareOfFromStationTravel)
//        fareOfToStationTravel = try values.decodeIfPresent(Int.self, forKey: .fareOfToStationTravel)
//        fromStationWalkDistance = try values.decodeIfPresent(Double.self, forKey: .fromStationWalkDistance)
//        toStationWalkDistance = try values.decodeIfPresent(Double.self, forKey: .toStationWalkDistance)
//    }
//
//}
//struct TransitPaths : Codable {
//    let pathSrNo : Int?
//    let edgeSrNo : Int?
//    let fromStationId : Int?
//    let toStationId : Int?
//    var fromStationName : String?
//    let toStationName : String?
//    let schNo : String?
//    let distance : Int?
//    var etaNode1 : String?
//    let etaNode2 : String?
//    let vehicleId : Int?
//    let busno : String?
//    let duration : String?
//    let isTransfer : Bool?
//    let tripId : Int?
//    let routeid : Int?
//    let routeno : String?
//    let serviceTypeId : Int?
//    var bCovered1 : String?
//    let bCovered2 : String?
//    var lat1 : String?
//    var lat2 : String?
//    var long1 : String?
//    let long2 : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case pathSrNo = "pathSrNo"
//        case edgeSrNo = "edgeSrNo"
//        case fromStationId = "fromStationId"
//        case toStationId = "toStationId"
//        case fromStationName = "fromStationName"
//        case toStationName = "toStationName"
//        case schNo = "schNo"
//        case distance = "distance"
//        case etaNode1 = "etaNode1"
//        case etaNode2 = "etaNode2"
//        case vehicleId = "vehicleId"
//        case busno = "busno"
//        case duration = "duration"
//        case isTransfer = "isTransfer"
//        case tripId = "tripId"
//        case routeid = "routeid"
//        case routeno = "routeno"
//        case serviceTypeId = "serviceTypeId"
//        case bCovered1 = "bCovered1"
//        case bCovered2 = "bCovered2"
//        case lat1 = "lat1"
//        case lat2 = "lat2"
//        case long1 = "long1"
//        case long2 = "long2"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        pathSrNo = try values.decodeIfPresent(Int.self, forKey: .pathSrNo)
//        edgeSrNo = try values.decodeIfPresent(Int.self, forKey: .edgeSrNo)
//        fromStationId = try values.decodeIfPresent(Int.self, forKey: .fromStationId)
//        toStationId = try values.decodeIfPresent(Int.self, forKey: .toStationId)
//        fromStationName = try values.decodeIfPresent(String.self, forKey: .fromStationName)
//        toStationName = try values.decodeIfPresent(String.self, forKey: .toStationName)
//        schNo = try values.decodeIfPresent(String.self, forKey: .schNo)
//        distance = try values.decodeIfPresent(Int.self, forKey: .distance)
//        etaNode1 = try values.decodeIfPresent(String.self, forKey: .etaNode1)
//        etaNode2 = try values.decodeIfPresent(String.self, forKey: .etaNode2)
//        vehicleId = try values.decodeIfPresent(Int.self, forKey: .vehicleId)
//        busno = try values.decodeIfPresent(String.self, forKey: .busno)
//        duration = try values.decodeIfPresent(String.self, forKey: .duration)
//        isTransfer = try values.decodeIfPresent(Bool.self, forKey: .isTransfer)
//        tripId = try values.decodeIfPresent(Int.self, forKey: .tripId)
//        routeid = try values.decodeIfPresent(Int.self, forKey: .routeid)
//        routeno = try values.decodeIfPresent(String.self, forKey: .routeno)
//        serviceTypeId = try values.decodeIfPresent(Int.self, forKey: .serviceTypeId)
//        bCovered1 = try values.decodeIfPresent(String.self, forKey: .bCovered1)
//        bCovered2 = try values.decodeIfPresent(String.self, forKey: .bCovered2)
//        lat1 = try values.decodeIfPresent(String.self, forKey: .lat1)
//        lat2 = try values.decodeIfPresent(String.self, forKey: .lat2)
//        long1 = try values.decodeIfPresent(String.self, forKey: .long1)
//        long2 = try values.decodeIfPresent(String.self, forKey: .long2)
//    }
//
//}
struct TransitPaths : Codable {
    let pathSrNo : Int?
    let edgeSrNo : Int?
    var fromStationId : Int?
    let toStationId : Int?
    var fromStationName : String?
    let toStationName : String?
    let schNo : String?
    let distance : Double?
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
    let lat2 : String?
    var long1 : String?
    let long2 : String?
    var bNotify1 : Bool?
    var bNotify2 : Bool?
    let strMetroLineNo : String?

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
        case bNotify1 = "bNotify1"
        case bNotify2 = "bNotify2"
        case strMetroLineNo = "strMetroLineNo"
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
        distance = try values.decodeIfPresent(Double.self, forKey: .distance)
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
        bNotify1 = try values.decodeIfPresent(Bool.self, forKey: .bNotify1)
        bNotify2 = try values.decodeIfPresent(Bool.self, forKey: .bNotify2)
        strMetroLineNo = try values.decodeIfPresent(String.self, forKey: .strMetroLineNo)
    }

}
