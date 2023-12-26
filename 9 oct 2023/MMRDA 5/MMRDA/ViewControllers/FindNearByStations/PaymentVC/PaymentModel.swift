//
//  PaymentModel.swift
//  MMRDA
//
//  Created by Sandip Patel on 21/09/22.
//

import Foundation
struct PaymentModel : Codable {
    let intMOTransactionID : Int?
    let from_Station : String?
    let from_StationId : Int?
    let to_Station : String?
    let to_StationId : Int?
    let ticketQty : Int?
    let strTicketRefrenceNo : String?
    let ticketCategoryID : Int?
    let ticketCategory : String?
    let busType : String?
    let totaL_FARE : Int?
    let transaction_Date : String?
    let dtExpiryDate : String?
    let transaction_Date24 : String?
    let dtExpiryDate24 : String?
    let isExpired : Int?
    let bUsed : Bool?
    let strPaymentStatus : String?
    let strTransactionCode : String?
    let message : String?
    let errorCode : Int?
    let serviceTypeId : Int?
    let routeNo : String?
    let routeName : String?
    let strPassConfigID : String?
    let strPrefixTransactionType : String?
    let strRFU : String?
    let ticketQR : String?
    let strSURL : String?
    let strFURL : String?
    let strPaymentURL : String?
    let categoryWiseTransaction : String?

    enum CodingKeys: String, CodingKey {

        case intMOTransactionID = "intMOTransactionID"
        case from_Station = "from_Station"
        case from_StationId = "from_StationId"
        case to_Station = "to_Station"
        case to_StationId = "to_StationId"
        case ticketQty = "ticketQty"
        case strTicketRefrenceNo = "strTicketRefrenceNo"
        case ticketCategoryID = "ticketCategoryID"
        case ticketCategory = "ticketCategory"
        case busType = "busType"
        case totaL_FARE = "totaL_FARE"
        case transaction_Date = "transaction_Date"
        case dtExpiryDate = "dtExpiryDate"
        case transaction_Date24 = "transaction_Date24"
        case dtExpiryDate24 = "dtExpiryDate24"
        case isExpired = "isExpired"
        case bUsed = "bUsed"
        case strPaymentStatus = "strPaymentStatus"
        case strTransactionCode = "strTransactionCode"
        case message = "message"
        case errorCode = "errorCode"
        case serviceTypeId = "serviceTypeId"
        case routeNo = "routeNo"
        case routeName = "routeName"
        case strPassConfigID = "strPassConfigID"
        case strPrefixTransactionType = "strPrefixTransactionType"
        case strRFU = "strRFU"
        case ticketQR = "ticketQR"
        case strSURL = "strSURL"
        case strFURL = "strFURL"
        case strPaymentURL = "strPaymentURL"
        case categoryWiseTransaction = "categoryWiseTransaction"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        intMOTransactionID = try values.decodeIfPresent(Int.self, forKey: .intMOTransactionID)
        from_Station = try values.decodeIfPresent(String.self, forKey: .from_Station)
        from_StationId = try values.decodeIfPresent(Int.self, forKey: .from_StationId)
        to_Station = try values.decodeIfPresent(String.self, forKey: .to_Station)
        to_StationId = try values.decodeIfPresent(Int.self, forKey: .to_StationId)
        ticketQty = try values.decodeIfPresent(Int.self, forKey: .ticketQty)
        strTicketRefrenceNo = try values.decodeIfPresent(String.self, forKey: .strTicketRefrenceNo)
        ticketCategoryID = try values.decodeIfPresent(Int.self, forKey: .ticketCategoryID)
        ticketCategory = try values.decodeIfPresent(String.self, forKey: .ticketCategory)
        busType = try values.decodeIfPresent(String.self, forKey: .busType)
        totaL_FARE = try values.decodeIfPresent(Int.self, forKey: .totaL_FARE)
        transaction_Date = try values.decodeIfPresent(String.self, forKey: .transaction_Date)
        dtExpiryDate = try values.decodeIfPresent(String.self, forKey: .dtExpiryDate)
        transaction_Date24 = try values.decodeIfPresent(String.self, forKey: .transaction_Date24)
        dtExpiryDate24 = try values.decodeIfPresent(String.self, forKey: .dtExpiryDate24)
        isExpired = try values.decodeIfPresent(Int.self, forKey: .isExpired)
        bUsed = try values.decodeIfPresent(Bool.self, forKey: .bUsed)
        strPaymentStatus = try values.decodeIfPresent(String.self, forKey: .strPaymentStatus)
        strTransactionCode = try values.decodeIfPresent(String.self, forKey: .strTransactionCode)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        serviceTypeId = try values.decodeIfPresent(Int.self, forKey: .serviceTypeId)
        routeNo = try values.decodeIfPresent(String.self, forKey: .routeNo)
        routeName = try values.decodeIfPresent(String.self, forKey: .routeName)
        strPassConfigID = try values.decodeIfPresent(String.self, forKey: .strPassConfigID)
        strPrefixTransactionType = try values.decodeIfPresent(String.self, forKey: .strPrefixTransactionType)
        strRFU = try values.decodeIfPresent(String.self, forKey: .strRFU)
        ticketQR = try values.decodeIfPresent(String.self, forKey: .ticketQR)
        strSURL = try values.decodeIfPresent(String.self, forKey: .strSURL)
        strFURL = try values.decodeIfPresent(String.self, forKey: .strFURL)
        strPaymentURL = try values.decodeIfPresent(String.self, forKey: .strPaymentURL)
        categoryWiseTransaction = try values.decodeIfPresent(String.self, forKey: .categoryWiseTransaction)
    }

}
