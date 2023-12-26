//
//  FeedBackViewModel.swift
//  MMRDA
//
//  Created by Kirti Chavda on 05/09/22.
//

import Foundation
class FeedBackViewModel {
    var delegate:ViewcontrollerSendBackDelegate?
    var inputErrorMessage: Observable<String?> = Observable(nil)
    func sendValue<T>(_ handleData: inout T) {
        self.delegate?.getInformatioBack(&handleData)
    }
    func getFeeddBackCategory(){
        var param = [String:Any]()
        param["userId"] = Helper.shared.objloginData?.intUserID
        ApiRequest.shared.requestPostMethod(strurl: apiName.getFeedbackcategory, params: param, showProgress: true, completion: { suces, data, error in
            do {
            var obj = try JSONDecoder().decode(AbstractResponseModel<feedbackCategoryModel>.self, from: data)
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
    func getReviewList(mode:Int){
        
        var param = [String:Any]()
        param["intUserID"] = Helper.shared.objloginData?.intUserID
        param["intTransportMode"] = mode
        ApiRequest.shared.requestPostMethod(strurl: apiName.getFeedbackReview, params: param, showProgress: true, completion: { suces, data, error in
            do {
            var obj = try JSONDecoder().decode(AbstractResponseModel<reviewListModel>.self, from: data)
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
