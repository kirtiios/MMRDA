//
//  GetReturnJourneyPlanModel.swift
//  MMRDA
//
//  Created by meghana.trivedi on 14/06/23.
//

import Foundation
class ReturnJourneyPlannerModelView {
    
    var delegate:ViewcontrollerSendBackDelegate?
    var inputErrorMessage: Observable<String?> = Observable(nil)
    var bindDirectionDataData:(([String:Any]?)->Void)?
    
    func getReturnJourneyPlanner(param:[String:Any],completionHandler:@escaping ([ReturnJourneyPlannerApiModelData]?)->Void?) {
        ApiRequest.shared.requestPostMethod(strurl: apiName.GetReturnJourneyPlan, params: param, showProgress: true, completion: { suces, data, error in
            if var obj = try? JSONDecoder().decode(ReturnJourneyPlannerApiModel.self, from: data) {
                if obj.issuccess ?? false {
                    completionHandler(obj.data)
                }else {
                    if let message = obj.message {
                        self.inputErrorMessage.value = message
                    }
                }
            }
        })
    }
}
