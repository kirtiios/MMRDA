//
//  LoginViewModel.swift
//  MMRDA
//
//  Created by Kirti Chavda on 22/08/22.
//

import Foundation
protocol ViewcontrollerPassDataDelegate {
    // pass data form view controoler to Viewmodel
    func sendValue<T>(_ handleData: inout T)
}

protocol ViewcontrollerSendBackDelegate {
    // pass data from View modle to view controller
    func getInformatioBack<T>(_ handleData: inout T)
}
class LoginViewModel {
    
    
    var strEmailMobile = String()
    var strPassword = String()
    var strMobilePIN = String()
    var isloginViaMPIN = Bool()
    var isRememberMe = Bool()
    var inputErrorMessage: Observable<String?> = Observable(nil)
    func submitLogin(){
        
        var param = [String:Any]()
        param["strMobileNo"] = isloginViaMPIN ? nil : strEmailMobile
        param["strMPIN"] = isloginViaMPIN ? strMobilePIN : nil
        param["strPassword"] = strPassword
        param["strFCMToken"] = "5432534"
        
        ApiRequest.shared.requestPostMethod(strurl: apiName.login, params: param, showProgress: true) { sucess, data, error in
            

            if let obj = try? JSONDecoder().decode(AbstractResponseModel<LoginDataModel>.self, from: data) {
                if obj.issuccess ?? false,obj.data?.count ?? 0 > 0 {
                    Helper.shared.objloginData = obj.data?.first
                    
                    if let encoded = try? JSONEncoder().encode(obj.data?.first) {
                        UserDefaults.standard.set(encoded, forKey: userDefaultKey.logedUserData.rawValue)
                        UserDefaults.standard.set(true, forKey: userDefaultKey.isLoggedIn.rawValue)
                        UserDefaults.standard.set(self.isRememberMe, forKey: userDefaultKey.logedRememberMe.rawValue)
                        UserDefaults.standard.synchronize()
                        
                        APPDELEGATE.isFromLogin = true
                        APPDELEGATE.setupViewController()
                    }
                    
//                    self.arrHowToreach = obj.data ?? [LoginDataModel]()
//                    self.tableview.reloadData()

                }else {
                    if let message = obj.message {
                        self.inputErrorMessage.value = message
                    }
                }

            }
            
        }
        

        
    }
    
    
}
