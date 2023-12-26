//
//  AttractionViewModel.swift
//  MMRDA
//
//  Created by Kirti Chavda on 30/08/22.
//

import Foundation
class AttractionViewModel {
    var delegate:ViewcontrollerSendBackDelegate?
    var inputErrorMessage: Observable<String?> = Observable(nil)
    
    func sendValue<T>(_ handleData: inout T) {
        self.delegate?.getInformatioBack(&handleData)
    }
    
    func getAttractionList(param:[String:Any]){
       
        ApiRequest.shared.requestPostMethod(strurl: apiName.attractionList, params: param, showProgress: true, completion: { suces, data, error in
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]],json.count > 0 {
                    if json.first?["result"] as? Int == 100 {
                        self.inputErrorMessage.value = json.first?["message"] as? String
                        return
                    }
                    
                }
            }catch {
                
            }
            
            
            if var obj = try? JSONDecoder().decode([AttractionListModel].self, from: data) {
                if obj.count > 0 {
                    self.sendValue(&obj)
                }else {

                }
            }
        })
    }
    func getAttractionSearch(param:[String:Any]){
        
        ApiRequest.shared.requestPostMethod(strurl: apiName.attractionSearch, params: param, showProgress: true, completion: { suces, data, error in
            if var obj = try? JSONDecoder().decode(AttractionSearchModel.self, from: data) {
                
                    self.sendValue(&obj.predictions)

            }
        })
    }
    func getAttractionClickedData(param:[String:Any]){
        ApiRequest.shared.requestPostMethod(strurl: apiName.attaractionDetail, params: param, showProgress: true, completion: { suces, data, error in
            if var obj = try? JSONDecoder().decode(AbstractResponseModel<attractionSearchDisplay>.self, from: data) {
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
