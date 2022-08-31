//
//  FavouriteModelView.swift
//  MMRDA
//
//  Created by Kirti Chavda on 31/08/22.
//

import Foundation
class FavouriteModelView {
    
    var delegate:ViewcontrollerSendBackDelegate?
    var inputErrorMessage: Observable<String?> = Observable(nil)
    
    func sendValue<T>(_ handleData: inout T) {
        self.delegate?.getInformatioBack(&handleData)
    }
    var favouriteDeleted: ((_ favid:Int?) -> Void)?
    func getFavouriteList(){
       
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
                print(error.localizedDescription)
            }
        })
    }
    func deleteFavourite(favid:Int){
        var param = [String:Any]()
        param["intUserID"] = Helper.shared.objloginData?.intUserID
        param["intFavouriteID"] = favid
        
        ApiRequest.shared.requestPostMethod(strurl: apiName.deleteFavourite, params: param, showProgress: true, completion: { suces, data, error in
            if var obj = try? JSONDecoder().decode(AbstractResponseModel<rewardTransctionModel>.self, from: data) {
                if obj.issuccess ?? false {
                    self.favouriteDeleted?(favid)
                }else {
                    if let message = obj.message {
                        self.inputErrorMessage.value = message
                    }
                }
            }
        })
    }
    func insertFavourite(param:[String:Any]){
    
        ApiRequest.shared.requestPostMethod(strurl: apiName.deleteFavourite, params: param, showProgress: true, completion: { suces, data, error in
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
