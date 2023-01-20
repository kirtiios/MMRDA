//
//  GrivanceViewModel.swift
//  MMRDA
//
//  Created by Sandip Patel on 17/10/22.
//

import Foundation
import SVProgressHUD
class GrivanceViewModel {
    var delegate:ViewcontrollerSendBackDelegate?
    var inputErrorMessage: Observable<String?> = Observable(nil)
    func sendValue<T>(_ handleData: inout T) {
        self.delegate?.getInformatioBack(&handleData)
    }
    var objCategory:grivanceCategory?
    var objSubCategory:grivanceSubCategory?
    var objVechicle:grivanceVechicleList?
    var objRoute:grivanceRouteList?
    var strDescription:String?
    var strDate:String?
    var data:Data?
    func getGrivanceList(complationHandler:@escaping (([grivanceList]?)->Void?)){
        
        var param = [String:Any]()
        param["UserID"] = Helper.shared.objloginData?.intUserID
        
        ApiRequest.shared.requestPostMethod(strurl: apiName.grivanceList, params: param, showProgress: true, completion: { suces, data, error in
            do {
                let obj = try JSONDecoder().decode(AbstractResponseModel<grivanceList>.self, from: data)
                if obj.issuccess ?? false {
                    complationHandler(obj.data)
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
    func getCategoryList(complationHandler:@escaping (([grivanceCategory]?)->Void?)){
        
        ApiRequest.shared.requestPostMethod(strurl: apiName.grivanceCategoryList, params:[String:Any](), showProgress: true, completion: { suces, data, error in
            do {
                var obj = try JSONDecoder().decode(AbstractResponseModel<grivanceCategory>.self, from: data)
                if obj.issuccess ?? false {
                    complationHandler(obj.data)
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
    func getSubCategoryList(categoryid:Int,complationHandler:@escaping (([grivanceSubCategory]?)->Void?)){
        
        var param = [String:Any]()
        param["intCategoryID"] = categoryid
        ApiRequest.shared.requestPostMethod(strurl: apiName.grivanceSubCategoryList, params:param, showProgress: true, completion: { suces, data, error in
            do {
                let obj = try JSONDecoder().decode(AbstractResponseModel<grivanceSubCategory>.self, from: data)
                if obj.issuccess ?? false {
                    complationHandler(obj.data)
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
    func getRouteList(complationHandler:@escaping (([grivanceRouteList]?)->Void?)){
        
        ApiRequest.shared.requestPostMethod(strurl: apiName.grivanceRouteList, params:[String:Any](), showProgress: true, completion: { suces, data, error in
            do {
                let obj = try JSONDecoder().decode(AbstractResponseModel<(grivanceRouteList)>.self, from: data)
                if obj.issuccess ?? false {
                    complationHandler(obj.data)
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
    func getVechicleList(complationHandler:@escaping (([grivanceVechicleList]?)->Void?)){
        
        ApiRequest.shared.requestPostMethod(strurl: apiName.grivanceVechicleList, params:[String:Any](), showProgress: true, completion: { suces, data, error in
            do {
                let obj = try JSONDecoder().decode(AbstractResponseModel<(grivanceVechicleList)>.self, from: data)
                if obj.issuccess ?? false {
                    complationHandler(obj.data)
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
    func submitGrinacne(complationHandler:@escaping ((Bool)->Void?)){
        
        if self.objCategory == nil {
            self.inputErrorMessage.value = "val_complain_category".localized()
        }
        else if self.objSubCategory == nil {
            self.inputErrorMessage.value = "val_complain_sub_category".localized()
        }
        else if self.objRoute == nil {
            self.inputErrorMessage.value = "select_route".localized()
        }
        else if self.strDescription?.trim().isEmpty ?? false {
            self.inputErrorMessage.value = "enter_desc".localized()
        }
        else if self.strDescription?.isValidHtmlString() ?? false {
            self.inputErrorMessage.value = "enter_vali_desc".localized()
        }
        else {
           
           
            
            var param = [String:Any]()
            param["intItemID"] = objSubCategory?.intItemID
            param["strDescription"] = strDescription
            param["intCreatedBy"] = Helper.shared.objloginData?.intUserID
            param["intBusID"] = objVechicle?.intVehicleID
            param["intRouteID"] = objRoute?.intRouteID
            param["dteIncidentDate"] = strDate
            param["intCategoryID"] = objCategory?.intComplainCategoryID
            param["intPlatformID"] = 3
            
            SVProgressHUD.show()
            ApiRequest.shared.requestPostMethodForMultipart(strurl: apiName.grivanceSubmit, fileName: "\(Date().timeIntervalSince1970).jpg", fileParam: "strIDProof", fileData: data, params: param, showProgress: false) { suces, param in
                
                if suces ,let issuccess = param?["issuccess"] as? Bool,issuccess {
                    if  let array = param?["data"] as? [[String:Any]],array.count > 0 {
                        
                        var params = [String:Any]()
                        params["strName"] =  Helper.shared.objloginData?.strFullName
                        params["strPhoneNo"] = Helper.shared.objloginData?.strMobileNo
                        params["strEmailID"] = Helper.shared.objloginData?.strEmailID
                        params["bOTPPrefix"] = false
                        params["intOTPTypeSR"] = 1
                        params["strOTPPrefix"] = nil
                        params["strOTPNo"] = array.first?["strComplainCode"]
                        params["intOTPTypeIDSMS"] = 8
                        params["intOTPTypeIDEMAIL"] = 17
                        params["strFilePath"] = nil
                        params["bSendAsAttachment"] = false
                        
                        
                        ApiRequest.shared.requestPostMethod(strurl: apiName.SendOTP, params: params, showProgress: false, completion: { suces, data, error in
                            do {
                                let obj = try JSONDecoder().decode(AbstractResponseModel<myTicketList>.self, from: data)
                                if obj.issuccess ?? false {
                                    complationHandler(true)
                                }else {
                                    if let message = obj.message {
                                        self.inputErrorMessage.value = message
                                    }
                                }
                                DispatchQueue.main.async {
                                    SVProgressHUD.dismiss()
                                }
                                
                            }catch {
                                print(error)
                            }
                        })
                    }
                    
                }
                else if let message = param?["message"] as? String {
                  self.inputErrorMessage.value = message
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                    }
                }
            }
        }
        
    }
    
    
    
    
    
}
