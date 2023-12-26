//
//  NotificationViewModel.swift
//  MMRDA
//
//  Created by Kirti Chavda on 13/09/22.
//

import Foundation
class NotificationViewModel {
    
    var delegate:ViewcontrollerSendBackDelegate?
    var inputErrorMessage: Observable<String?> = Observable(nil)
    func sendValue<T>(_ handleData: inout T) {
        self.delegate?.getInformatioBack(&handleData)
    }
    
    func getNotificationList(param:[String:Any]){
       
        ApiRequest.shared.requestPostMethod(strurl: apiName.notifcaitonList, params: param, showProgress: true, completion: { suces, data, error in
            do {
            var obj = try JSONDecoder().decode(AbstractResponseModel<NotificationModel>.self, from: data)
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
    func updateNotificationList(){
       
        var param = [String:Any]()
        param ["UserID"] = Helper.shared.objloginData?.intUserID
        ApiRequest.shared.requestPostMethod(strurl: apiName.notifcaitonUpdate, params: param, showProgress: true, completion: { suces, data, error in
            do {
            var obj = try JSONDecoder().decode(AbstractResponseModel<NotificationModel>.self, from: data)
                if obj.issuccess ?? false {
                  //  self.sendValue(&obj.data)
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
    
    
}
