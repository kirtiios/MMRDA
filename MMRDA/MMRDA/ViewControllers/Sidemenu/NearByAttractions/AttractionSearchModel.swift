//
//  AttractionSearchModel.swift
//  MMRDA
//
//  Created by Kirti Chavda on 30/08/22.
//

import Foundation
struct AttractionSearchModel : Codable {
    var predictions : [Predictions]?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case predictions = "predictions"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        predictions = try values.decodeIfPresent([Predictions].self, forKey: .predictions)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
struct Main_text_matched_substrings : Codable {
    let length : Int?
    let offset : Int?

    enum CodingKeys: String, CodingKey {

        case length = "length"
        case offset = "offset"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        length = try values.decodeIfPresent(Int.self, forKey: .length)
        offset = try values.decodeIfPresent(Int.self, forKey: .offset)
    }

}
struct Matched_substrings : Codable {
    let length : Int?
    let offset : Int?

    enum CodingKeys: String, CodingKey {

        case length = "length"
        case offset = "offset"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        length = try values.decodeIfPresent(Int.self, forKey: .length)
        offset = try values.decodeIfPresent(Int.self, forKey: .offset)
    }

}
struct Predictions : Codable {
    let description : String?
    let matched_substrings : [Matched_substrings]?
    let place_id : String?
    let reference : String?
    let structured_formatting : Structured_formatting?
    let terms : [Terms]?
    let types : [String]?

    enum CodingKeys: String, CodingKey {

        case description = "description"
        case matched_substrings = "matched_substrings"
        case place_id = "place_id"
        case reference = "reference"
        case structured_formatting = "structured_formatting"
        case terms = "terms"
        case types = "types"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        matched_substrings = try values.decodeIfPresent([Matched_substrings].self, forKey: .matched_substrings)
        place_id = try values.decodeIfPresent(String.self, forKey: .place_id)
        reference = try values.decodeIfPresent(String.self, forKey: .reference)
        structured_formatting = try values.decodeIfPresent(Structured_formatting.self, forKey: .structured_formatting)
        terms = try values.decodeIfPresent([Terms].self, forKey: .terms)
        types = try values.decodeIfPresent([String].self, forKey: .types)
    }

}
struct Structured_formatting : Codable {
    let main_text : String?
    let main_text_matched_substrings : [Main_text_matched_substrings]?
    let secondary_text : String?

    enum CodingKeys: String, CodingKey {

        case main_text = "main_text"
        case main_text_matched_substrings = "main_text_matched_substrings"
        case secondary_text = "secondary_text"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        main_text = try values.decodeIfPresent(String.self, forKey: .main_text)
        main_text_matched_substrings = try values.decodeIfPresent([Main_text_matched_substrings].self, forKey: .main_text_matched_substrings)
        secondary_text = try values.decodeIfPresent(String.self, forKey: .secondary_text)
    }

}
struct Terms : Codable {
    let offset : Int?
    let value : String?

    enum CodingKeys: String, CodingKey {

        case offset = "offset"
        case value = "value"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        offset = try values.decodeIfPresent(Int.self, forKey: .offset)
        value = try values.decodeIfPresent(String.self, forKey: .value)
    }

}
struct attractionSearchDisplay : Codable {
    let strPlaceName : String?
    let strAddressName : String?
    let strPlaceId : String?
    let placeTypeId : Int?
    let decPlaceLat : Double?
    let decPlaceLong : Double?
    let decCurrentLat : Double?
    let decCurrentLong : Double?
    let distance : Double?
    let rating : Double?

    enum CodingKeys: String, CodingKey {

        case strPlaceName = "strPlaceName"
        case strAddressName = "strAddressName"
        case strPlaceId = "strPlaceId"
        case placeTypeId = "placeTypeId"
        case decPlaceLat = "decPlaceLat"
        case decPlaceLong = "decPlaceLong"
        case decCurrentLat = "decCurrentLat"
        case decCurrentLong = "decCurrentLong"
        case distance = "distance"
        case rating = "rating"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        strPlaceName = try values.decodeIfPresent(String.self, forKey: .strPlaceName)
        strAddressName = try values.decodeIfPresent(String.self, forKey: .strAddressName)
        strPlaceId = try values.decodeIfPresent(String.self, forKey: .strPlaceId)
        placeTypeId = try values.decodeIfPresent(Int.self, forKey: .placeTypeId)
        decPlaceLat = try values.decodeIfPresent(Double.self, forKey: .decPlaceLat)
        decPlaceLong = try values.decodeIfPresent(Double.self, forKey: .decPlaceLong)
        decCurrentLat = try values.decodeIfPresent(Double.self, forKey: .decCurrentLat)
        decCurrentLong = try values.decodeIfPresent(Double.self, forKey: .decCurrentLong)
        distance = try values.decodeIfPresent(Double.self, forKey: .distance)
        rating = try values.decodeIfPresent(Double.self, forKey: .rating)
    }

}
