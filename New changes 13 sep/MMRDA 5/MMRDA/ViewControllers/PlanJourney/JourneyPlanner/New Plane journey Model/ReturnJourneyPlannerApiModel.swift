//
//  ReturnJourneyPlannerApiModel.swift
//  MMRDA
//
//  Created by meghana.trivedi on 14/06/23.
//

import Foundation
struct ReturnJourneyPlannerApiModel : Codable {
    let data : [ReturnJourneyPlannerApiModelData]?
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
        data = try values.decodeIfPresent([ReturnJourneyPlannerApiModelData].self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        issuccess = try values.decodeIfPresent(Bool.self, forKey: .issuccess)
        exception = try values.decodeIfPresent(String.self, forKey: .exception)
        rowcount = try values.decodeIfPresent(Int.self, forKey: .rowcount)
    }

}
struct ReturnJourneyPlannerApiModelData : Codable {
    let upwardTrip : [[JourneyPlannerModel]]?
    let downwardTrip : [[JourneyPlannerModel]]?

    enum CodingKeys: String, CodingKey {

        case upwardTrip = "upwardTrip"
        case downwardTrip = "downwardTrip"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        upwardTrip = try values.decodeIfPresent([[JourneyPlannerModel]].self, forKey: .upwardTrip)
        downwardTrip = try values.decodeIfPresent([[JourneyPlannerModel]].self, forKey: .downwardTrip)
    }

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        upwardTrip = try values.decodeIfPresent([[JourneyPlannerModel]].self, forKey: .upwardTrip)
//        downwardTrip = try values.decodeIfPresent([[JourneyPlannerModel]].self, forKey: .downwardTrip)
//    }

}
//struct UpwardTripReturn : Codable {
//    let journeyPlannerStationDetail : JourneyPlannerStationDetail?
//    let transitPaths : [TransitPaths]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case journeyPlannerStationDetail = "journeyPlannerStationDetail"
//        case transitPaths = "transitPaths"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        journeyPlannerStationDetail = try values.decodeIfPresent(JourneyPlannerStationDetail.self, forKey: .journeyPlannerStationDetail)
//        transitPaths = try values.decodeIfPresent([TransitPaths].self, forKey: .transitPaths)
//    }
//
//}
//struct DownwardTripReturn : Codable {
//    let journeyPlannerStationDetail : JourneyPlannerStationDetail?
//    let transitPaths : [TransitPaths]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case journeyPlannerStationDetail = "journeyPlannerStationDetail"
//        case transitPaths = "transitPaths"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        journeyPlannerStationDetail = try values.decodeIfPresent(JourneyPlannerStationDetail.self, forKey: .journeyPlannerStationDetail)
//        transitPaths = try values.decodeIfPresent([TransitPaths].self, forKey: .transitPaths)
//    }
//
//}
