//
//  JourneyPlannerModelView.swift
//  MMRDA
//
//  Created by Sandip Patel on 27/09/22.
//

import Foundation
class JourneyPlannerModelView {
    var delegate:ViewcontrollerSendBackDelegate?
    var inputErrorMessage: Observable<String?> = Observable(nil)
    
    func sendValue<T>(_ handleData: inout T) {
        self.delegate?.getInformatioBack(&handleData)
    }
    
    func getAttractionList(param:[String:Any]){
       
        ApiRequest.shared.requestPostMethod(strurl: apiName.attractionList, params: param, showProgress: true, completion: { suces, data, error in
            if var obj = try? JSONDecoder().decode([AttractionListModel].self, from: data) {
                if obj.count > 0 {
                    self.sendValue(&obj)
                }else {

                }
            }
        })
    }
    func getFavouriteList(){
       
        var param = [String:Any]()
        param["intUserID"] = Helper.shared.objloginData?.intUserID
        ApiRequest.shared.requestPostMethod(strurl: apiName.favouriteList, params: param, showProgress: true, completion: { suces, data, error in
            if var obj = try? JSONDecoder().decode(AbstractResponseModel<favouriteList>.self, from: data) {
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
    func deleteFavourite(strLocationLatLong:String,completionHandler:@escaping((Bool)->Void?)){
        var param = [String:Any]()
        param["intUserID"] = Helper.shared.objloginData?.intUserID
        param["strLocationLatLong"] = strLocationLatLong
        
        
        ApiRequest.shared.requestPostMethod(strurl: apiName.deleteFavourite, params: param, showProgress: true, completion: { suces, data, error in
            if let obj = try? JSONDecoder().decode(AbstractResponseModel<rewardTransctionModel>.self, from: data) {
                
                if let message = obj.message {
                    self.inputErrorMessage.value = message
                }
                if obj.issuccess ?? false {
                    completionHandler(true)
                }
            }
        })
    }
    func saveFavouriteStation(strLocationLatLong:String,strLocation:String,completionHandler:@escaping((Bool)->Void?)){
        var param =  [String:Any]()
        param["intUserID"] = Helper.shared.objloginData?.intUserID
        param["intFavouriteTypeID"] = typeOfFav.JourneyPlanner.rawValue
        param["strLocationLatLong"] =  strLocationLatLong
        param["strSourceToDestinationLocation"] =  strLocation
       
    
        ApiRequest.shared.requestPostMethod(strurl: apiName.insertFavourite, params: param, showProgress: true, completion: { suces, data, error in
            if let obj = try? JSONDecoder().decode(AbstractResponseModel<LocationResuleModel>.self, from: data) {
                
                if let message = obj.message {
                    self.inputErrorMessage.value = message
                }
                if obj.issuccess ?? false {
                    
                    if obj.data?.first?.result ==  12 ||  obj.data?.first?.result ==  13  {
                        completionHandler(true)
                    }
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
    func getJourneyPlanner(param:[String:Any],completionHandler:@escaping ([JourneyPlannerModel]?)->Void?) {
        ApiRequest.shared.requestPostMethod(strurl: apiName.journeyPlannerList, params: param, showProgress: true, completion: { suces, data, error in
            if var obj = try? JSONDecoder().decode(AbstractResponseModel<JourneyPlannerModel>.self, from: data) {
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
