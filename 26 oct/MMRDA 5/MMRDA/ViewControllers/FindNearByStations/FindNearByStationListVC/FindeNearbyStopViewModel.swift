//
//  FindeNearbyStopViewModel.swift
//  MMRDA
//
//  Created by Kirti Chavda on 07/09/22.
//

import Foundation
class FindeNearbyStopViewModel {
    
    var delegate:ViewcontrollerSendBackDelegate?
    var inputErrorMessage: Observable<String?> = Observable(nil)
    func sendValue<T>(_ handleData: inout T) {
        self.delegate?.getInformatioBack(&handleData)
    }
    
    var bindSearchStationData:(([FareStationListModel]?)->Void)?
    var bindDirectionDataData:(([String:Any]?)->Void)?
    
    func getfindNearByStop(param:[String:Any]){
       
        ApiRequest.shared.requestPostMethod(strurl: apiName.getNearbyStationStop, params: param, showProgress: false, completion: { suces, data, error in
            do {
            var obj = try JSONDecoder().decode(AbstractResponseModel<FareStationListModel>.self, from: data)
                if obj.issuccess ?? false {
                    self.sendValue(&obj.data)
                }else {
                    if let message = obj.message {
                      //  self.inputErrorMessage.value = message
                    }
                }
            
            }catch {
                print(error)
            }
        })
    }
    func getNearbyStationSearch(param:[String:Any]){
        
        ApiRequest.shared.requestPostMethod(strurl: apiName.getNearbyStationSearch, params: param, showProgress: true, completion: { suces, data, error in
            do {
            let obj = try JSONDecoder().decode(AbstractResponseModel<FareStationListModel>.self, from: data)
                if obj.issuccess ?? false {
                    self.bindSearchStationData?(obj.data)
                   // self.sendValue(&obj.data)
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
    // nearby
    func getDirectionStation(param:[String:Any]){
        
        ApiRequest.shared.requestPostMethod(strurl: apiName.getStationDirection, params: param, showProgress: true, completion: { suces, data, error in
            do {
                if suces {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                    self.bindDirectionDataData?(json)
                }
            }catch {
                print(error)
            }
        })
    }
}
