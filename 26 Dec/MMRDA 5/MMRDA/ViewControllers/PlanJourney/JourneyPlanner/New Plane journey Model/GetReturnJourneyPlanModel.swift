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
    
    
    func getReturnJourneyPlanner(param:[String:Any],successHandler: @escaping (ReturnJourneyPlannerApiModel) -> Void, errorHandler: @escaping (String) -> Void) {
        ApiRequest.shared.requestPostMethod(strurl:  apiName.GetReturnJourneyPlan, params: param, showProgress: true) { success, data, error in
            if success {
                let decoder = JSONDecoder()
                do {
                    let faqModel = try decoder.decode(ReturnJourneyPlannerApiModel.self, from: data)
                    successHandler(faqModel)
                } catch {
                    errorHandler(error.localizedDescription ?? "Failed to decode FAQ data.")
                }
            } else {
                errorHandler(error ?? "Failed to retrieve FAQ data.")
            }
        }
    }
//
//    func getReturnJourneyPlanner(param:[String:Any],completionHandler:@escaping ([ReturnJourneyPlannerApiModelData]?)->Void?) {
//        ApiRequest.shared.requestPostMethod(strurl: apiName.GetReturnJourneyPlan, params: param, showProgress: true, completion: { suces, data, error in
//            if var obj = try? JSONDecoder().decode(ReturnJourneyPlannerApiModel.self, from: data) {
//                if obj.issuccess ?? false {
//                    completionHandler(obj.data)
//                }else {
//                    if let message = obj.message {
//                        self.inputErrorMessage.value = message
//                    }
//                }
//            }
//        })
//    }
}
