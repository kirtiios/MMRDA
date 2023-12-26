//
//  FeedbackModel.swift
//  MMRDA
//
//  Created by Kirti Chavda on 06/09/22.
//

import Foundation
struct reviewListModel : Codable {
    let intFeedbackID : Int?
    let intUserID : Int?
    let intFeedbackCategoryID : Int?
    let strDescription : String?
    let strRating : String?
    let dteFeedback : String?
    let strLine : String?
    let intResponseBy : Int?
    let dteResponseOn : String?
    let strResponse : String?
    let strDocumentName : String?
    let strDocumentPath : String?
    let strFullName : String?
    let intTransportModeID : Int?
    let strProfileURL : String?
    let strProfileBase64 : String?

    enum CodingKeys: String, CodingKey {

        case intFeedbackID = "intFeedbackID"
        case intUserID = "intUserID"
        case intFeedbackCategoryID = "intFeedbackCategoryID"
        case strDescription = "strDescription"
        case strRating = "strRating"
        case dteFeedback = "dteFeedback"
        case strLine = "strLine"
        case intResponseBy = "intResponseBy"
        case dteResponseOn = "dteResponseOn"
        case strResponse = "strResponse"
        case strDocumentName = "strDocumentName"
        case strDocumentPath = "strDocumentPath"
        case strFullName = "strFullName"
        case intTransportModeID = "intTransportModeID"
        case strProfileURL = "strProfileURL"
        case strProfileBase64 = "strProfileBase64"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        intFeedbackID = try values.decodeIfPresent(Int.self, forKey: .intFeedbackID)
        intUserID = try values.decodeIfPresent(Int.self, forKey: .intUserID)
        intFeedbackCategoryID = try values.decodeIfPresent(Int.self, forKey: .intFeedbackCategoryID)
        strDescription = try values.decodeIfPresent(String.self, forKey: .strDescription)
        strRating = try values.decodeIfPresent(String.self, forKey: .strRating)
        dteFeedback = try values.decodeIfPresent(String.self, forKey: .dteFeedback)
        strLine = try values.decodeIfPresent(String.self, forKey: .strLine)
        intResponseBy = try values.decodeIfPresent(Int.self, forKey: .intResponseBy)
        dteResponseOn = try values.decodeIfPresent(String.self, forKey: .dteResponseOn)
        strResponse = try values.decodeIfPresent(String.self, forKey: .strResponse)
        strDocumentName = try values.decodeIfPresent(String.self, forKey: .strDocumentName)
        strDocumentPath = try values.decodeIfPresent(String.self, forKey: .strDocumentPath)
        strFullName = try values.decodeIfPresent(String.self, forKey: .strFullName)
        intTransportModeID = try values.decodeIfPresent(Int.self, forKey: .intTransportModeID)
        strProfileURL = try values.decodeIfPresent(String.self, forKey: .strProfileURL)
        strProfileBase64 = try values.decodeIfPresent(String.self, forKey: .strProfileBase64)
    }

}
struct feedbackCategoryModel : Codable {
    let intFeedbackCategoryID : Int?
    let strFeedbackCategory : String?

    enum CodingKeys: String, CodingKey {

        case intFeedbackCategoryID = "intFeedbackCategoryID"
        case strFeedbackCategory = "strFeedbackCategory"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        intFeedbackCategoryID = try values.decodeIfPresent(Int.self, forKey: .intFeedbackCategoryID)
        strFeedbackCategory = try values.decodeIfPresent(String.self, forKey: .strFeedbackCategory)
    }

}
