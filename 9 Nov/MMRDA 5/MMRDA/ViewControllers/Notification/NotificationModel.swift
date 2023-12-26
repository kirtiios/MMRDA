//
//  NotificationModel.swift
//  MMRDA
//
//  Created by Kirti Chavda on 13/09/22.
//

import Foundation

struct NotificationModel : Codable {
    let intNotificationID : Int?
    let intUserID : Int?
    let intNotificationTypeID : Int?
    let strNotification : String?
    let bViewed : Bool?
    let dteInsertOn : String?
    let intInsertedBy : String?
    let strStatusMessage : String?
    let date : String?
    let time : String?

    enum CodingKeys: String, CodingKey {

        case intNotificationID = "intNotificationID"
        case intUserID = "intUserID"
        case intNotificationTypeID = "intNotificationTypeID"
        case strNotification = "strNotification"
        case bViewed = "bViewed"
        case dteInsertOn = "dteInsertOn"
        case intInsertedBy = "intInsertedBy"
        case strStatusMessage = "strStatusMessage"
        case date = "date"
        case time = "time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        intNotificationID = try values.decodeIfPresent(Int.self, forKey: .intNotificationID)
        intUserID = try values.decodeIfPresent(Int.self, forKey: .intUserID)
        intNotificationTypeID = try values.decodeIfPresent(Int.self, forKey: .intNotificationTypeID)
        strNotification = try values.decodeIfPresent(String.self, forKey: .strNotification)
        bViewed = try values.decodeIfPresent(Bool.self, forKey: .bViewed)
        dteInsertOn = try values.decodeIfPresent(String.self, forKey: .dteInsertOn)
        intInsertedBy = try values.decodeIfPresent(String.self, forKey: .intInsertedBy)
        strStatusMessage = try values.decodeIfPresent(String.self, forKey: .strStatusMessage)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        time = try values.decodeIfPresent(String.self, forKey: .time)
    }

}



