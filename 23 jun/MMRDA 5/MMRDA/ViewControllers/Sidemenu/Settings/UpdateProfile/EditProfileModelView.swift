//
//  EditProfileModelView.swift
//  MMRDA
//
//  Created by Kirti Chavda on 13/09/22.
//

import Foundation
class EditProfileModelView {
    
    var delegate:ViewcontrollerSendBackDelegate?
    var inputErrorMessage: Observable<String?> = Observable(nil)
    
    func sendValue<T>(_ handleData: inout T) {
        self.delegate?.getInformatioBack(&handleData)
    }
    
    func getProfileDetail(){
       
        var param = [String:Any]()
        param["intUserID"] = Helper.shared.objloginData?.intUserID
        ApiRequest.shared.requestPostMethod(strurl: apiName.getProfileDetail, params: param, showProgress: true, completion: { suces, data, error in
            if var obj = try? JSONDecoder().decode(AbstractResponseModel<EditProfileModel>.self, from: data) {
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
//    func getrewardTranasctionList(type:Int){
//        var param = [String:Any]()
//        param["intUserID"] = Helper.shared.objloginData?.intUserID
//        param["intRewardTypeID"] = type
//
//        ApiRequest.shared.requestPostMethod(strurl: apiName.rewardTranasctionList, params: param, showProgress: true, completion: { suces, data, error in
//            if var obj = try? JSONDecoder().decode(AbstractResponseModel<rewardTransctionModel>.self, from: data) {
//                if obj.issuccess ?? false {
//                    self.sendValue(&obj.data)
//                }else {
//                    if let message = obj.message {
//                        self.inputErrorMessage.value = message
//                    }
//                }
//            }
//        })
//    }
    
}
