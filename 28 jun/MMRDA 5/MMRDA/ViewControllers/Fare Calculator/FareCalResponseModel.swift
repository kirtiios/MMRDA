//
//  FareCalResponseModel.swift
//  MMRDA
//
//  Created by Kirti Chavda on 29/08/22.
//

import Foundation
struct FareCalResponseModel : Codable {
    let ticketCode : Int?
    let fromStationID : Int?
    let toStationID : Int?
    let baseFare : Int?
    let discountedFare : Int?

    enum CodingKeys: String, CodingKey {

        case ticketCode = "ticketCode"
        case fromStationID = "fromStationID"
        case toStationID = "toStationID"
        case baseFare = "baseFare"
        case discountedFare = "discountedFare"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ticketCode = try values.decodeIfPresent(Int.self, forKey: .ticketCode)
        fromStationID = try values.decodeIfPresent(Int.self, forKey: .fromStationID)
        toStationID = try values.decodeIfPresent(Int.self, forKey: .toStationID)
        baseFare = try values.decodeIfPresent(Int.self, forKey: .baseFare)
        discountedFare = try values.decodeIfPresent(Int.self, forKey: .discountedFare)
    }

}
