//
//  AttractionListModel.swift
//  MMRDA
//
//  Created by Kirti Chavda on 30/08/22.
//

import Foundation
struct AttractionListModel : Codable {
    let latitude : Double?
    let longitude : Double?
    let address : String?
    let place_ID : String?
    let placeName : String?
    let opening_status : Bool?
    let photo_Refrence : String?
    let photo_Html_Attributions : String?
    let place_Type : String?
    let current_Latitude : Double?
    let current_Longitude : Double?
    let place_Rating : Double?
    let placeTypeID : Int?
    let distance : Double?

    enum CodingKeys: String, CodingKey {

        case latitude = "Latitude"
        case longitude = "Longitude"
        case address = "Address"
        case place_ID = "Place_ID"
        case placeName = "PlaceName"
        case opening_status = "Opening_status"
        case photo_Refrence = "Photo_Refrence"
        case photo_Html_Attributions = "Photo_Html_Attributions"
        case place_Type = "Place_Type"
        case current_Latitude = "Current_Latitude"
        case current_Longitude = "Current_Longitude"
        case place_Rating = "Place_Rating"
        case placeTypeID = "PlaceTypeID"
        case distance = "Distance"
        
      
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        place_ID = try values.decodeIfPresent(String.self, forKey: .place_ID)
        placeName = try values.decodeIfPresent(String.self, forKey: .placeName)
        opening_status = try values.decodeIfPresent(Bool.self, forKey: .opening_status)
        photo_Refrence = try values.decodeIfPresent(String.self, forKey: .photo_Refrence)
        photo_Html_Attributions = try values.decodeIfPresent(String.self, forKey: .photo_Html_Attributions)
        place_Type = try values.decodeIfPresent(String.self, forKey: .place_Type)
        current_Latitude = try values.decodeIfPresent(Double.self, forKey: .current_Latitude)
        current_Longitude = try values.decodeIfPresent(Double.self, forKey: .current_Longitude)
        place_Rating = try values.decodeIfPresent(Double.self, forKey: .place_Rating)
        placeTypeID = try values.decodeIfPresent(Int.self, forKey: .placeTypeID)
        distance = try values.decodeIfPresent(Double.self, forKey: .distance)
    }

}
