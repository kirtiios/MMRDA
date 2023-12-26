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
    func getPenaltyStatus(param:[String:Any],completion:@escaping ((Bool,NPentlydata?)->Void?)){
        
        ApiRequest.shared.requestPostMethod(strurl: apiName.getpenalityStatus, params: param, showProgress: true) { sucess, data, error in
          
                let response = try? JSONDecoder().decode(NPentlyNewData.self, from: data)
               let penaltyStatus = response
            print(response?.issuccess)
//            if sucess == true{
            if response?.issuccess == true{
                completion(true,penaltyStatus?.data?.nPentlydata)
            }else{
                print("error:\(error)")
                completion(false,nil)
            }
              
                   // Handle the error case here
               // return
              // }
//            if let url = Bundle.main.url(forResource: "jsonvalidator", withExtension: "txt") {
//                do {
//                    let data = try Data(contentsOf:url)
//                    let decoder = JSONDecoder()
//                    let jsonData = try decoder.decode(NPentlyNewData.self, from: data)
//                    completion(true,jsonData.nOuterdata?.nPentlydata)
//                } catch {
//                    print("error:\(error)")
//                }
//            }
//
//            do {
//                var obj = try JSONDecoder().decode(AbstractResponseModel<PenaltyData>.self, from: data)
//                if obj.issuccess ?? false {
//                    completion(true,obj.data)
//                }else {
//                    if let message = obj.message {
//                        self.inputErrorMessage.value = message
//                    }
//                }
//
//            }catch {
//                print(error)
//            }
            
        }
//        ApiRequest.shared.requestPostMethod(strurl: apiName.getpenalityStatus, params: param, showProgress: true, completion: { suces, data, error in
//            do {
//                var obj = try JSONDecoder().decode(AbstractResponseModel<[getpenalityStatus]>.self, from: data)
//                if obj.issuccess ?? false {
//                    completion()
//                }else {
//                    if let message = obj.message {
//                        self.inputErrorMessage.value = message
//                    }
//                }
//
//            }catch {
//                print(error)
//            }
//        })
    }
    
}
