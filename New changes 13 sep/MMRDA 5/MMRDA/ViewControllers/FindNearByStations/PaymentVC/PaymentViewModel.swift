//
//  PaymentViewModel.swift
//  MMRDA
//
//  Created by Sandip Patel on 20/09/22.
//

import Foundation
class PaymentViewModel {
    var delegate:ViewcontrollerSendBackDelegate?
    var inputErrorMessage: Observable<String?> = Observable(nil)
    func sendValue<T>(_ handleData: inout T) {
        self.delegate?.getInformatioBack(&handleData)
    }
    
    var bindSearchStationData:(([FareStationListModel]?)->Void)?
    var bindDirectionDataData:(([String:Any]?)->Void)?
    var favouriteUpdated: ((_ favid:String?) -> Void)?
    func getNearbyStation(param:[String:Any],completion:(@escaping([FareStationListModel]?)->Void?)){
        
        ApiRequest.shared.requestPostMethod(strurl: apiName.getToStationListinPaymentPage, params: param, showProgress: true, completion: { suces, data, error in
            do {
                let obj = try JSONDecoder().decode(AbstractResponseModel<FareStationListModel>.self, from: data)
                if obj.issuccess ?? false {
                    //self.sendValue(&obj.data)
                    completion(obj.data)
                }else {
                    if let message = obj.message {
                        self.inputErrorMessage.value = message
                    }
                }
                
            }catch {
                print(error)
            }
        })
    }
    
//    func saveNotifyAlarm(param:[String:Any]){
//     
//        
//        ApiRequest.shared.requestPostMethod(strurl: apiName.saveAlarm, params: param, showProgress: true, completion: { suces, data, error in
//            if let obj = try? JSONDecoder().decode(AbstractResponseModel<LocationResuleModel>.self, from: data) {
//                if obj.issuccess ?? false {
//                    if let message = obj.message {
//                        self.inputErrorMessage.value = message
//                    }
//                   // self.favouriteUpdated?(routeid)
//                    
//                }else {
//                    if let message = obj.message {
//                        self.inputErrorMessage.value = message
//                    }
//                }
//            }
//        })
//    }
    func getFareCalculator(fromStationID:String,toStationID:String,isPenality:Bool = false,intTicketCode:Int, completion:@escaping(FareCalResponseModel?)->Void?){
        
        var param = [String:Any]()
        param["intUserID"] = Helper.shared.objloginData?.intUserID
        param["deviceType"] = "IOS"
        param["intTicketCode"] = intTicketCode//118
        param["intQty"] = 1
        param["intSourceStationID"] =  fromStationID
        param["intDestinationStationID"] = toStationID
        if isPenality {
            param["isPenalty"] = true
        }
        
        ApiRequest.shared.requestPostMethod(strurl: apiName.fareCalculation, params: param, showProgress: true, completion: { suces, data, error in
            if var obj = try? JSONDecoder().decode(AbstractResponseModel<FareCalResponseModel>.self, from: data) {
                if obj.issuccess ?? false,obj.data?.count ?? 0 > 0 {
                   
                    completion(obj.data?.first)
                }else {
                    if let message = obj.message {
                        self.inputErrorMessage.value = message
                    }
                }
            }
        })
    }
    func insertTicketHistory(param:[String:Any],completion:@escaping(PaymentModel?)->Void?){
        
        ApiRequest.shared.requestPostMethod(strurl: apiName.ticketInsert, params: param, showProgress: true, completion: { suces, data, error in
            if var obj = try? JSONDecoder().decode(AbstractResponseModel<PaymentModel>.self, from: data) {
                if obj.issuccess ?? false,obj.data?.count ?? 0 > 0 {
                    completion(obj.data?.first)
                }else {
                    if let message = obj.message {
                        self.inputErrorMessage.value = message
                    }
                }
            }
        })
    }
    func getTicketHistory(param:[String:Any],completion:@escaping([myTicketList]?)->Void?){
        
        ApiRequest.shared.requestPostMethod(strurl: apiName.ticketList, params: param, showProgress: true, completion: { suces, data, error in
            if let obj = try? JSONDecoder().decode(AbstractResponseModel<myTicketList>.self, from: data) {
                if obj.issuccess ?? false,obj.data?.count ?? 0 > 0 {
                    completion(obj.data)
                }else {
                    if let message = obj.message {
                        self.inputErrorMessage.value = message
                    }
                }
            }
        })
    }
        
    
}
