//
//  RewardModelView.swift
//  MMRDA
//
//  Created by Kirti Chavda on 31/08/22.
//

import Foundation
class RewardModelView {
    var delegate:ViewcontrollerSendBackDelegate?
    var inputErrorMessage: Observable<String?> = Observable(nil)
    
    func sendValue<T>(_ handleData: inout T) {
        self.delegate?.getInformatioBack(&handleData)
    }
    
    func getrewardDetail(){
       
        var param = [String:Any]()
        param["intUserID"] = Helper.shared.objloginData?.intUserID
        ApiRequest.shared.requestPostMethod(strurl: apiName.rewardDetail, params: param, showProgress: true, completion: { suces, data, error in
            if var obj = try? JSONDecoder().decode(AbstractResponseModel<rewardDetailModel>.self, from: data) {
                if obj.issuccess ?? false {
                    self.sendValue(&obj.data)
                }else {
                    if let message = obj.message {
                        self.inputErrorMessage.value = message
                    }
                }
            }
        })
    }
    func getrewardTranasctionList(type:Int){
        var param = [String:Any]()
        param["intUserID"] = Helper.shared.objloginData?.intUserID
        param["intRewardTypeID"] = type
        
        ApiRequest.shared.requestPostMethod(strurl: apiName.rewardTranasctionList, params: param, showProgress: true, completion: { suces, data, error in
            if var obj = try? JSONDecoder().decode(AbstractResponseModel<rewardTransctionModel>.self, from: data) {
                if obj.issuccess ?? false {
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
