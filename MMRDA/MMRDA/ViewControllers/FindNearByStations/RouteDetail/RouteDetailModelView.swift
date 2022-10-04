//
//  RouteDetailModelView.swift
//  MMRDA
//
//  Created by Kirti Chavda on 12/09/22.
//

import Foundation
class RouteDetailModelView {
    
    var delegate:ViewcontrollerSendBackDelegate?
    var inputErrorMessage: Observable<String?> = Observable(nil)
    func sendValue<T>(_ handleData: inout T) {
        self.delegate?.getInformatioBack(&handleData)
    }
    
    var bindSearchStationData:(([FareStationListModel]?)->Void)?
    var bindDirectionDataData:(([String:Any]?)->Void)?
    var favouriteUpdated: ((_ favid:String?) -> Void)?
    func getfindNearByStation(param:[String:Any]){
       
        ApiRequest.shared.requestPostMethod(strurl: apiName.getNearbyStationSchedule, params: param, showProgress: true, completion: { suces, data, error in
            do {
            var obj = try JSONDecoder().decode(AbstractResponseModel<StationListModel>.self, from: data)
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
    func getRefreshStation(intTripID:String){
        var param =  [String:Any]()
        param["intUserID"] = Helper.shared.objloginData?.intUserID
        param["intTripID"] =  intTripID
        ApiRequest.shared.requestPostMethod(strurl: apiName.getNearbyStationRefresh, params: param, showProgress: true, completion: { suces, data, error in
            do {
            var obj = try JSONDecoder().decode(AbstractResponseModel<StationListModel>.self, from: data)
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
    
    func saveFavouriteStation(routeid:String,completionHandler:@escaping((Bool)->Void?)){
        var param =  [String:Any]()
        param["intUserID"] = Helper.shared.objloginData?.intUserID
        param["intFavouriteTypeID"] = typeOfFav.Route.rawValue
        param["intRouteID"] =  routeid
       
    
        ApiRequest.shared.requestPostMethod(strurl: apiName.insertFavourite, params: param, showProgress: true, completion: { suces, data, error in
            if let obj = try? JSONDecoder().decode(AbstractResponseModel<LocationResuleModel>.self, from: data) {
                
                if let message = obj.message {
                    self.inputErrorMessage.value = message
                }
                if obj.issuccess ?? false {
                    completionHandler(true)
                }
            }
        })
    }
    func deleteFavourite(routeid:String,completionHandler:@escaping((Bool)->Void?)){
        var param = [String:Any]()
        param["intUserID"] = Helper.shared.objloginData?.intUserID
        param["intRouteID"] = routeid
        param["intFavouriteTypeID"] = typeOfFav.Route.rawValue
        
        
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
    
}
