//
//  ModelAcceptComplainStatus.swift
//  MMRDA
//
//  Created by meghana.trivedi on 29/03/23.
//

import Foundation
struct ModelAcceptComplainStatus : Codable {
    let result : Int?

    enum CodingKeys: String, CodingKey {

        case result = "result"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Int.self, forKey: .result)
    }

}
