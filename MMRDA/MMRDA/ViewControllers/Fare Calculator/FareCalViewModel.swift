//
//  FareCalViewModel.swift
//  MMRDA
//
//  Created by Kirti Chavda on 24/08/22.
//

import Foundation
class FareCalViewModel {
    
    var delegate:ViewcontrollerSendBackDelegate?
    var inputErrorMessage: Observable<String?> = Observable(nil)
    var objFromFareStation:FareStationListModel?
    var objTOFareStation:FareStationListModel?
    
    func sendValue<T>(_ handleData: inout T) {
        self.delegate?.getInformatioBack(&handleData)
    }
    
    func getFareCalcualtet(){
        
        if objFromFareStation == nil {
            inputErrorMessage.value = "select_starting_point".LocalizedString
        }else if objTOFareStation == nil {
            inputErrorMessage.value = "select_ending_point".LocalizedString
        }else {
            
            
            var param = [String:Any]()
            param["intUserID"] = Helper.shared.objloginData?.intUserID
            param["deviceType"] = "IOS"
            param["intTicketCode"] = 118
            param["intQty"] = 1
            param["intSourceStationID"] =  objFromFareStation?.stationCode
            param["intDestinationStationID"] = objTOFareStation?.stationCode
            
            ApiRequest.shared.requestPostMethod(strurl: apiName.fareCalculation, params: param, showProgress: true, completion: { suces, data, error in
                if var obj = try? JSONDecoder().decode(AbstractResponseModel<FareCalResponseModel>.self, from: data) {
                    if obj.issuccess ?? false,obj.data?.count ?? 0 > 0 {
                        self.sendValue(&obj.data)
                    }else {
                        if let message = obj.message {
                            self.inputErrorMessage.value = message
                        }
                    }
                }
            })
        }
    }
    
}
