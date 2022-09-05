//
//  TicketModelView.swift
//  MMRDA
//
//  Created by Kirti Chavda on 05/09/22.
//

import Foundation
class TicketModelView {
    
    var delegate:ViewcontrollerSendBackDelegate?
    var inputErrorMessage: Observable<String?> = Observable(nil)
    func sendValue<T>(_ handleData: inout T) {
        self.delegate?.getInformatioBack(&handleData)
    }
    
    func getMyTicketList(){
       
        var param = [String:Any]()
        param["intUserID"] = Helper.shared.objloginData?.intUserID
        ApiRequest.shared.requestPostMethod(strurl: apiName.favouriteList, params: param, showProgress: true, completion: { suces, data, error in
            do {
            if var obj = try? JSONDecoder().decode(AbstractResponseModel<favouriteList>.self, from: data) {
                if obj.issuccess ?? false {
                    self.sendValue(&obj.data)
                }else {
                    if let message = obj.message {
                        self.inputErrorMessage.value = message
                    }
                }
            }
            }catch {
                print(error)
            }
        })
    }
}
