//
//  FareStationListModel.swift
//  MMRDA
//
//  Created by Kirti Chavda on 24/08/22.
//

import Foundation

struct FareStationListModel : Codable {
    let stationid : Int?
    let stationCode : Int?
    let sationname : String?
    let displaystationname : String?
    let lattitude : Double?
    let longitude : Double?
    let transportType : Int?
    let distance : Double?
    let km : Double?
    enum CodingKeys: String, CodingKey {

        case stationid = "stationid"
        case stationCode = "stationCode"
        case sationname = "sationname"
        case lattitude = "lattitude"
        case longitude = "longitude"
        case transportType = "transportType"
        case distance = "distance"
        case displaystationname = "displaysationname"
        case km = "km"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        stationid = try values.decodeIfPresent(Int.self, forKey: .stationid)
        stationCode = try values.decodeIfPresent(Int.self, forKey: .stationCode)
        sationname = try values.decodeIfPresent(String.self, forKey: .sationname)
        lattitude = try values.decodeIfPresent(Double.self, forKey: .lattitude)
        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
        transportType = try values.decodeIfPresent(Int.self, forKey: .transportType)
        distance = try values.decodeIfPresent(Double.self, forKey: .distance)
        km = try values.decodeIfPresent(Double.self, forKey: .km)
      //  displaystationname = try values.decodeIfPresent(String.self, forKey: .displaystationname)
        displaystationname = try values.decodeIfPresent(String.self, forKey: .sationname)
    }

}
