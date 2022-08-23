//
//  File.swift
//  Salem Smart City
//
//  Created by Kirti Chavda on 05/07/22.
//

import Foundation

struct AbstractResponseModel<Element: Decodable>: Decodable {
    let data : [Element]?
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
        data = try values.decodeIfPresent([Element].self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        issuccess = try values.decodeIfPresent(Bool.self, forKey: .issuccess)
        exception = try values.decodeIfPresent(String.self, forKey: .exception)
        rowcount = try values.decodeIfPresent(Int.self, forKey: .rowcount)
    }

}
