//
//  SosViewModel.swift
//  MMRDA
//
//  Created by Sandip Patel on 19/09/22.
//

import Foundation
class SosViewModel {
    var delegate:ViewcontrollerSendBackDelegate?
    var inputErrorMessage: Observable<String?> = Observable(nil)
    func sendValue<T>(_ handleData: inout T) {
        self.delegate?.getInformatioBack(&handleData)
    }
    
    func startSOS(param:[String:Any],completionHandler:@escaping(([String:Any]?)->Void?)){
       
        ApiRequest.shared.requestPostMethod(strurl: apiName.startSOS, params: param, showProgress: true, completion: { suces, data, error in
            do {
            var obj = try JSONDecoder().decode(AbstractResponseModel<myTicketList>.self, from: data)
                if obj.issuccess ?? false {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        print(json)
                        if let arr = json["data"] as? [[String:Any]] {
                            completionHandler(arr.first)
                        }
                    }
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
    func EdnSOS(param:[String:Any],completionHandler:@escaping(([String:Any]?)->Void?)){
       
        ApiRequest.shared.requestPostMethod(strurl: apiName.soptSOS, params: param, showProgress: true, completion: { suces, data, error in
            do {
            var obj = try JSONDecoder().decode(AbstractResponseModel<myTicketList>.self, from: data)
                if obj.issuccess ?? false {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        print(json)
                        if let arr = json["data"] as? [[String:Any]] {
                            completionHandler(arr.first)
                        }
                    }
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
    func startSOSSendSMS(param:[String:Any],completionHandler:@escaping((Bool)->Void?)){
       
        ApiRequest.shared.requestPostMethod(strurl: apiName.SendOTP, params: param, showProgress: true, completion: { suces, data, error in
            do {
            var obj = try JSONDecoder().decode(AbstractResponseModel<myTicketList>.self, from: data)
                if obj.issuccess ?? false {
                    completionHandler(true)
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
