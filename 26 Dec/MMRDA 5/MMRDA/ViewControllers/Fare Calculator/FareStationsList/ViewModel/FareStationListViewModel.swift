//
//  FareStationListViewModel.swift
//  MMRDA
//
//  Created by Kirti Chavda on 24/08/22.
//

import Foundation

class  FareStationListViewModel {
    
    
    var delegate:ViewcontrollerSendBackDelegate?
    var inputErrorMessage: Observable<String?> = Observable(nil)
    
    func sendValue<T>(_ handleData: inout T) {
        self.delegate?.getInformatioBack(&handleData)
    }
    
    func getStationList(param:[String:Any]){
       
        ApiRequest.shared.requestPostMethod(strurl: apiName.fareStationList, params: param, showProgress: true, completion: { suces, data, error in
            if var obj = try? JSONDecoder().decode(AbstractResponseModel<FareStationListModel>.self, from: data) {
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
    func getFareCalcualtet(param:[String:Any]){
       
        ApiRequest.shared.requestPostMethod(strurl: apiName.fareStationList, params: param, showProgress: true, completion: { suces, data, error in
            if var obj = try? JSONDecoder().decode(AbstractResponseModel<FareStationListModel>.self, from: data) {
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
