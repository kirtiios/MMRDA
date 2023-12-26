//
//  ReminderModel.swift
//  MMRDA
//
//  Created by Sandip Patel on 20/09/22.
//

import Foundation

struct alarmNotifyList : Codable {
    let intNotifyDurationID : Int?
    let intNotifyDuration : Int?
    let bActive : Bool?
    let dteInsertOn : String?
    
    enum CodingKeys: String, CodingKey {
        
        case intNotifyDurationID = "intNotifyDurationID"
        case intNotifyDuration = "intNotifyDuration"
        case bActive = "bActive"
        case dteInsertOn = "dteInsertOn"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        intNotifyDurationID = try values.decodeIfPresent(Int.self, forKey: .intNotifyDurationID)
        intNotifyDuration = try values.decodeIfPresent(Int.self, forKey: .intNotifyDuration)
        bActive = try values.decodeIfPresent(Bool.self, forKey: .bActive)
        dteInsertOn = try values.decodeIfPresent(String.self, forKey: .dteInsertOn)
    }
    
}


