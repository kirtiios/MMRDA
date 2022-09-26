//
//  ReminderModelView.swift
//  MMRDA
//
//  Created by Kirti Chavda on 12/09/22.
//

import Foundation

class ReminderModelView {
    var delegate:ViewcontrollerSendBackDelegate?
    var inputErrorMessage: Observable<String?> = Observable(nil)
    func sendValue<T>(_ handleData: inout T) {
        self.delegate?.getInformatioBack(&handleData)
    }
    
    var bindSearchStationData:(([FareStationListModel]?)->Void)?
    var bindDirectionDataData:(([String:Any]?)->Void)?
    var favouriteUpdated: ((_ favid:String?) -> Void)?
    func getNearByNotification(param:[String:Any]){
        
        ApiRequest.shared.requestPostMethod(strurl: apiName.getNotifyeList, params: param, showProgress: true, completion: { suces, data, error in
            do {
                var obj = try JSONDecoder().decode(AbstractResponseModel<alarmNotifyList>.self, from: data)
                if obj.issuccess ?? false {
                    self.sendValue(&obj.data)
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
    
    func saveNotifyAlarm(param:[String:Any]){
     
        
        ApiRequest.shared.requestPostMethod(strurl: apiName.saveAlarm, params: param, showProgress: true, completion: { suces, data, error in
            if let obj = try? JSONDecoder().decode(AbstractResponseModel<LocationResuleModel>.self, from: data) {
                if obj.issuccess ?? false {
                    if let message = obj.message {
                        self.inputErrorMessage.value = message
                    }
                   // self.favouriteUpdated?(routeid)
                    
                }else {
                    if let message = obj.message {
                        self.inputErrorMessage.value = message
                    }
                }
            }
        })
    }
    
    
}
