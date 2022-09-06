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
    
    func getMyTicketList(param:[String:Any]){
       
        ApiRequest.shared.requestPostMethod(strurl: apiName.ticketList, params: param, showProgress: true, completion: { suces, data, error in
            do {
            var obj = try JSONDecoder().decode(AbstractResponseModel<myTicketList>.self, from: data)
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
}
