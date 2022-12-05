//
//  StationListingViewModel.swift
//  MMRDA
//
//  Created by Kirti Chavda on 12/09/22.
//

import Foundation
class StationListingViewModel {
    
    var delegate:ViewcontrollerSendBackDelegate?
    var inputErrorMessage: Observable<String?> = Observable(nil)
    func sendValue<T>(_ handleData: inout T) {
        self.delegate?.getInformatioBack(&handleData)
    }
    
    var bindSearchStationData:(([FareStationListModel]?)->Void)?
    var bindDirectionDataData:(([String:Any]?)->Void)?
    
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
    
    func saveFavouriteStation(stationid:String){
        var param =  [String:Any]()
        param["intUserID"] = Helper.shared.objloginData?.intUserID
        param["intFavouriteTypeID"] = typeOfFav.Station.rawValue
        param["intPlaceID"] =  stationid
        param["intTransportID"] =  1
       
    
        ApiRequest.shared.requestPostMethod(strurl: apiName.insertFavourite, params: param, showProgress: true, completion: { suces, data, error in
            if var obj = try? JSONDecoder().decode(AbstractResponseModel<LocationResuleModel>.self, from: data) {
                if obj.issuccess ?? false {
                    
                    if let message = obj.message {
                        self.inputErrorMessage.value = message
                    }
                    
                }else {
                    if let message = obj.message {
                        self.inputErrorMessage.value = message
                    }
                }
            }
        })
    }
    
    
}
    

