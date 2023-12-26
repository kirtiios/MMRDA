//
//  rewardTransctionModel.swift
//  MMRDA
//
//  Created by Kirti Chavda on 31/08/22.
//

import Foundation
struct rewardTransctionModel : Codable {
    let strTransportMode : String?
    let intTransactionTypeID : Int?
    let intRewardPoint : Int?
    let intRewardAmount : Int?
    let dteTransactionOn : String?
    let strRewardType : String?
    let intRewardTypeID : Int?
    let strTransactionRefNo : String?

    enum CodingKeys: String, CodingKey {

        case strTransportMode = "strTransportMode"
        case intTransactionTypeID = "intTransactionTypeID"
        case intRewardPoint = "intRewardPoint"
        case intRewardAmount = "intRewardAmount"
        case dteTransactionOn = "dteTransactionOn"
        case strRewardType = "strRewardType"
        case intRewardTypeID = "intRewardTypeID"
        case strTransactionRefNo = "strTransactionRefNo"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        strTransportMode = try values.decodeIfPresent(String.self, forKey: .strTransportMode)
        intTransactionTypeID = try values.decodeIfPresent(Int.self, forKey: .intTransactionTypeID)
        intRewardPoint = try values.decodeIfPresent(Int.self, forKey: .intRewardPoint)
        intRewardAmount = try values.decodeIfPresent(Int.self, forKey: .intRewardAmount)
        dteTransactionOn = try values.decodeIfPresent(String.self, forKey: .dteTransactionOn)
        strRewardType = try values.decodeIfPresent(String.self, forKey: .strRewardType)
        intRewardTypeID = try values.decodeIfPresent(Int.self, forKey: .intRewardTypeID)
        strTransactionRefNo = try values.decodeIfPresent(String.self, forKey: .strTransactionRefNo)
    }

}
struct rewardDetailModel : Codable {
    let intAvailableRewardPoint : Int?
    let intRewardRs : Int?
    let intUserID : Int?

    enum CodingKeys: String, CodingKey {

        case intAvailableRewardPoint = "intAvailableRewardPoint"
        case intRewardRs = "intRewardRs"
        case intUserID = "intUserID"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        intAvailableRewardPoint = try values.decodeIfPresent(Int.self, forKey: .intAvailableRewardPoint)
        intRewardRs = try values.decodeIfPresent(Int.self, forKey: .intRewardRs)
        intUserID = try values.decodeIfPresent(Int.self, forKey: .intUserID)
    }

}
