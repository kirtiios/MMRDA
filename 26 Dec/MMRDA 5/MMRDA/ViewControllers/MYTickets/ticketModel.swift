//
//  ticketModel.swift
//  MMRDA
//
//  Created by Kirti Chavda on 05/09/22.
//

import Foundation
struct myTicketList : Codable {
    let intMOTransactionID : Int?
    let strTicketRefrenceNo : String?
    let from_Station : String?
    let from_StationId : Int?
    let to_Station : String?
    let to_StationId : Int?
    let ticketQty : Int?
    let ticketCategoryID : Int?
    let ticketCategory : String?
    let busType : String?
    let totaL_FARE : Int?
    let total_Amount:Int?
    let transaction_Date : String?
    let transactionDate : String?
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
    let strPaymentPlatform : String?
    let strEmailID : String?
    let strMobileNo : String?
    let totalKM : Double?
    let strTransportMode : String?
    let strPTOName : String?
    let strPassengerType : String?
    let categoryWiseTransaction : String?
    let from_Abbreviation : String?
    let to_Abbreviation : String?
    let intTotalCount : Int?
    let convertedQR : String?
    let strColorCode : String?
    let strDMTicketRefrenceNo : String?
    let strTicketType : String?
    let intStatusID : Int?
    
    let strStatus : String?
    let strPaymentRefNo : String?
    let strPenaltyReason : String?
    let strErrorReason:String?
    
    enum CodingKeys: String, CodingKey {

        case intMOTransactionID = "intMOTransactionID"
        case strTicketRefrenceNo = "strTicketRefrenceNo"
        case from_Station = "from_Station"
        case from_StationId = "from_StationId"
        case to_Station = "to_Station"
        case to_StationId = "to_StationId"
        case ticketQty = "ticketQty"
        case ticketCategoryID = "ticketCategoryID"
        case ticketCategory = "ticketCategory"
        case busType = "busType"
        case totaL_FARE = "totaL_FARE"
        case total_Amount = "total_Amount"
        case transaction_Date = "transaction_Date"
        case transactionDate = "transactionDate"
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
        case strPaymentPlatform = "strPaymentPlatform"
        case strEmailID = "strEmailID"
        case strMobileNo = "strMobileNo"
        case totalKM = "totalKM"
        case strTransportMode = "strTransportMode"
        case strPTOName = "strPTOName"
        case strPassengerType = "strPassengerType"
        case categoryWiseTransaction = "categoryWiseTransaction"
        case from_Abbreviation = "from_Abbreviation"
        case to_Abbreviation = "to_Abbreviation"
        case intTotalCount = "intTotalCount"
        case convertedQR = "convertedQR"
        case strColorCode = "strColorCode"
        case strDMTicketRefrenceNo = "strDMTicketRefrenceNo"
        case strTicketType = "strTicketType"
        case intStatusID = "intStatusID"
        case strStatus = "strStatus"
        case strPaymentRefNo = "strPaymentRefNo"
        case strPenaltyReason = "strPenaltyReason"
        case strErrorReason = "strErrorReason"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        intMOTransactionID = try values.decodeIfPresent(Int.self, forKey: .intMOTransactionID)
        strTicketRefrenceNo = try values.decodeIfPresent(String.self, forKey: .strTicketRefrenceNo)
        from_Station = try values.decodeIfPresent(String.self, forKey: .from_Station)
        from_StationId = try values.decodeIfPresent(Int.self, forKey: .from_StationId)
        to_Station = try values.decodeIfPresent(String.self, forKey: .to_Station)
        to_StationId = try values.decodeIfPresent(Int.self, forKey: .to_StationId)
        ticketQty = try values.decodeIfPresent(Int.self, forKey: .ticketQty)
        ticketCategoryID = try values.decodeIfPresent(Int.self, forKey: .ticketCategoryID)
        ticketCategory = try values.decodeIfPresent(String.self, forKey: .ticketCategory)
        busType = try values.decodeIfPresent(String.self, forKey: .busType)
        totaL_FARE = try values.decodeIfPresent(Int.self, forKey: .totaL_FARE)
        total_Amount = try values.decodeIfPresent(Int.self, forKey: .total_Amount)
        transaction_Date = try values.decodeIfPresent(String.self, forKey: .transaction_Date)
        transactionDate = try values.decodeIfPresent(String.self, forKey: .transactionDate)
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
        strPaymentPlatform = try values.decodeIfPresent(String.self, forKey: .strPaymentPlatform)
        strEmailID = try values.decodeIfPresent(String.self, forKey: .strEmailID)
        strMobileNo = try values.decodeIfPresent(String.self, forKey: .strMobileNo)
        totalKM = try values.decodeIfPresent(Double.self, forKey: .totalKM)
        strTransportMode = try values.decodeIfPresent(String.self, forKey: .strTransportMode)
        strPTOName = try values.decodeIfPresent(String.self, forKey: .strPTOName)
        strPassengerType = try values.decodeIfPresent(String.self, forKey: .strPassengerType)
        categoryWiseTransaction = try values.decodeIfPresent(String.self, forKey: .categoryWiseTransaction)
        
        from_Abbreviation = try values.decodeIfPresent(String.self, forKey: .from_Abbreviation)
        to_Abbreviation = try values.decodeIfPresent(String.self, forKey: .to_Abbreviation)
        intTotalCount = try values.decodeIfPresent(Int.self, forKey: .intTotalCount)
        
        convertedQR = try values.decodeIfPresent(String.self, forKey: .convertedQR)
        strColorCode = try values.decodeIfPresent(String.self, forKey: .strColorCode)
        
        strDMTicketRefrenceNo = try values.decodeIfPresent(String.self, forKey: .strDMTicketRefrenceNo)
        strTicketType = try values.decodeIfPresent(String.self, forKey: .strTicketType)
        intStatusID = try values.decodeIfPresent(Int.self, forKey: .intStatusID)
        
        strStatus = try values.decodeIfPresent(String.self, forKey: .strStatus)
        strPaymentRefNo = try values.decodeIfPresent(String.self, forKey: .strPaymentRefNo)
        strPenaltyReason = try values.decodeIfPresent(String.self, forKey: .strPenaltyReason)
        strErrorReason = try values.decodeIfPresent(String.self, forKey: .strErrorReason)
        
    }

}
//struct PenaltyDetails : Codable {
////    let errorReasonCode : Int?
////    let errorStationCode : Int?
////    let destinationStationCode : Int?
////    let errorReasonDescription : String?
////    let penalty : Int?
////    let surcharge : Int?
////    let feesCode : Int?
////    let price : Int?
////    let intStationID : Int?
////    let strStationName : String?
////
////    enum CodingKeys: String, CodingKey {
////
////        case errorReasonCode = "ErrorReasonCode"
////        case errorStationCode = "ErrorStationCode"
////        case destinationStationCode = "DestinationStationCode"
////        case errorReasonDescription = "ErrorReasonDescription"
////        case penalty = "Penalty"
////        case surcharge = "Surcharge"
////        case feesCode = "FeesCode"
////        case price = "Price"
////        case intStationID = "intStationID"
////        case strStationName = "strStationName"
////    }
////
////    init(from decoder: Decoder) throws {
////        let values = try decoder.container(keyedBy: CodingKeys.self)
////        errorReasonCode = try values.decodeIfPresent(Int.self, forKey: .errorReasonCode)
////        errorStationCode = try values.decodeIfPresent(Int.self, forKey: .errorStationCode)
////        destinationStationCode = try values.decodeIfPresent(Int.self, forKey: .destinationStationCode)
////        errorReasonDescription = try values.decodeIfPresent(String.self, forKey: .errorReasonDescription)
////        penalty = try values.decodeIfPresent(Int.self, forKey: .penalty)
////        surcharge = try values.decodeIfPresent(Int.self, forKey: .surcharge)
////        feesCode = try values.decodeIfPresent(Int.self, forKey: .feesCode)
////        price = try values.decodeIfPresent(Int.self, forKey: .price)
////        intStationID = try values.decodeIfPresent(Int.self, forKey: .intStationID)
////        strStationName = try values.decodeIfPresent(String.self, forKey: .strStationName)
////    }
//
//    let ticketNumber : Int?
//    let errorReasonCode : Int?
//    let errorStationCode : Int?
//    let destinationStationCode : Int?
//    let errorReasonDescription : String?
//    let penalty : Int?
//    let surcharge : Int?
//    let feesCode : Int?
//    let price : Int?
//    let intStationID : Int?
//    let strStationName : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case ticketNumber = "ticketNumber"
//        case errorReasonCode = "errorReasonCode"
//        case errorStationCode = "errorStationCode"
//        case destinationStationCode = "destinationStationCode"
//        case errorReasonDescription = "errorReasonDescription"
//        case penalty = "penalty"
//        case surcharge = "surcharge"
//        case feesCode = "feesCode"
//        case price = "price"
//        case intStationID = "intStationID"
//        case strStationName = "strStationName"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        ticketNumber = try values.decodeIfPresent(Int.self, forKey: .ticketNumber)
//        errorReasonCode = try values.decodeIfPresent(Int.self, forKey: .errorReasonCode)
//        errorStationCode = try values.decodeIfPresent(Int.self, forKey: .errorStationCode)
//        destinationStationCode = try values.decodeIfPresent(Int.self, forKey: .destinationStationCode)
//        errorReasonDescription = try values.decodeIfPresent(String.self, forKey: .errorReasonDescription)
//        penalty = try values.decodeIfPresent(Int.self, forKey: .penalty)
//        surcharge = try values.decodeIfPresent(Int.self, forKey: .surcharge)
//        feesCode = try values.decodeIfPresent(Int.self, forKey: .feesCode)
//        price = try values.decodeIfPresent(Int.self, forKey: .price)
//        intStationID = try values.decodeIfPresent(Int.self, forKey: .intStationID)
//        strStationName = try values.decodeIfPresent(String.self, forKey: .strStationName)
//    }
//
//}
struct PenaltyModel : Codable {
//    let succeeded : Bool?
//    let data : [PenaltyData]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case succeeded = "Succeeded"
//        case data = "Data"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        succeeded = try values.decodeIfPresent(Bool.self, forKey: .succeeded)
//        data = try values.decodeIfPresent([PenaltyData].self, forKey: .data)
//    }
    let data : PenaltyData?
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
        data = try values.decodeIfPresent(PenaltyData.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        issuccess = try values.decodeIfPresent(Bool.self, forKey: .issuccess)
        exception = try values.decodeIfPresent(String.self, forKey: .exception)
        rowcount = try values.decodeIfPresent(Int.self, forKey: .rowcount)
    }
    
}
struct PenaltyData : Codable {
    let statusCode : Int?
    let data : PenaltyDetails?
    let succeeded : Bool?
    let description : String?

    enum CodingKeys: String, CodingKey {

        case statusCode = "statusCode"
        case data = "data"
        case succeeded = "succeeded"
        case description = "description"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)
        data = try values.decodeIfPresent(PenaltyDetails.self, forKey: .data)
        succeeded = try values.decodeIfPresent(Bool.self, forKey: .succeeded)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }

}
//struct PenaltyData : Codable {
//    let ticketNumber : String?
//    let penaltyDetails : PenaltyDetails?
//
//    enum CodingKeys: String, CodingKey {
//
//        case ticketNumber = "TicketNumber"
//        case penaltyDetails = "PenaltyDetails"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        ticketNumber = try values.decodeIfPresent(String.self, forKey: .ticketNumber)
//        penaltyDetails = try values.decodeIfPresent(PenaltyDetails.self, forKey: .penaltyDetails)
//    }
//
//}
struct NPentlyNewData : Codable {
    let data : NOuterdata?
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
        data = try values.decodeIfPresent(NOuterdata.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        issuccess = try values.decodeIfPresent(Bool.self, forKey: .issuccess)
        exception = try values.decodeIfPresent(String.self, forKey: .exception)
        rowcount = try values.decodeIfPresent(Int.self, forKey: .rowcount)
    }

}
struct NOuterdata : Codable {
    let statusCode : Int?
    let nPentlydata : NPentlydata?
    let succeeded : Bool?
    let description : String?

    enum CodingKeys: String, CodingKey {

        case statusCode = "statusCode"
        case nPentlydata = "data"
        case succeeded = "succeeded"
        case description = "description"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)
        nPentlydata = try values.decodeIfPresent(NPentlydata.self, forKey: .nPentlydata)
        succeeded = try values.decodeIfPresent(Bool.self, forKey: .succeeded)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }

}
struct NPentlydata : Codable {
    let ticketNumber : Int?
    let penaltyDetails : PenaltyDetails?

    enum CodingKeys: String, CodingKey {

        case ticketNumber = "ticketNumber"
        case penaltyDetails = "penaltyDetails"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ticketNumber = try values.decodeIfPresent(Int.self, forKey: .ticketNumber)
        penaltyDetails = try values.decodeIfPresent(PenaltyDetails.self, forKey: .penaltyDetails)
    }

}
struct PenaltyDetails : Codable {
    let ticketNumber : Int?
    let errorReasonCode : Int?
    let errorStationCode : Int?
    let destinationStationCode : Int?
    let errorReasonDescription : String?
    let penalty : Int?
    let surcharge : Int?
    let feesCode : Int?
    let price : Int?
    let intStationID : Int?
    let strStationName : String?

    enum CodingKeys: String, CodingKey {

        case ticketNumber = "ticketNumber"
        case errorReasonCode = "errorReasonCode"
        case errorStationCode = "errorStationCode"
        case destinationStationCode = "destinationStationCode"
        case errorReasonDescription = "errorReasonDescription"
        case penalty = "penalty"
        case surcharge = "surcharge"
        case feesCode = "feesCode"
        case price = "price"
        case intStationID = "intStationID"
        case strStationName = "strStationName"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ticketNumber = try values.decodeIfPresent(Int.self, forKey: .ticketNumber)
        errorReasonCode = try values.decodeIfPresent(Int.self, forKey: .errorReasonCode)
        errorStationCode = try values.decodeIfPresent(Int.self, forKey: .errorStationCode)
        destinationStationCode = try values.decodeIfPresent(Int.self, forKey: .destinationStationCode)
        errorReasonDescription = try values.decodeIfPresent(String.self, forKey: .errorReasonDescription)
        penalty = try values.decodeIfPresent(Int.self, forKey: .penalty)
        surcharge = try values.decodeIfPresent(Int.self, forKey: .surcharge)
        feesCode = try values.decodeIfPresent(Int.self, forKey: .feesCode)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        intStationID = try values.decodeIfPresent(Int.self, forKey: .intStationID)
        strStationName = try values.decodeIfPresent(String.self, forKey: .strStationName)
    }

}
