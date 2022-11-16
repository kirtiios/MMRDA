//
//  SignupViewModel.swift
//  MMRDA
//
//  Created by Kirti Chavda on 22/08/22.
//

import Foundation
class SignupViewModel {
    
    
    var strEmail = String()
    var strMobile = String()
    var strFullName = String()
    var isAcceptCondition = Bool()
    var inputErrorMessage: Observable<String?> = Observable(nil)
   
    var bindViewModelToController : ((_ dict:[String:Any],_ message:String) -> ()) = { dict,message in }
    
    func submitSignUP(){
        
        
        if strFullName.trim().isEmpty || strFullName.isNumeric {
            inputErrorMessage.value = "pls_enter_name".LocalizedString
        }
        else if strMobile.trim().count < 1  {
            inputErrorMessage.value = "pls_enter_mobileno".LocalizedString
        }
        else if  strMobile.trim().mobileNumberValidation() == false {
            inputErrorMessage.value = "pls_enter_valid_mobile_number".LocalizedString
        }
        else if strEmail.isValidEmail() == false {
            inputErrorMessage.value =  "pls_enter_emailid".LocalizedString
        }
        else if isAcceptCondition == false {
            inputErrorMessage.value =  "accept_terms_condition".LocalizedString
        }
        
        else {
            
            var param = [String:Any]()
            param["strEmailID"] = strEmail
            param["strPhoneNo"] = strMobile
            
            
            ApiRequest.shared.requestPostMethod(strurl: apiName.VerifyPhoneNO, params: param, showProgress: true) { sucess, data, error in
                
                
                if sucess {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                            
                            if let issuccess =  json["issuccess"] as? Bool ,issuccess {
                                self.inputErrorMessage.value = json["message"] as? String
                                
                            }else {
                                
                                var param = [String:Any]()
                                param["strEmailID"] = self.strEmail
                                param["strPhoneNo"] = self.strMobile
                                param["strFullName"] = self.strFullName
                                param["bOTPPrefix"] = false
                                param["bSendAsAttachment"] = false
                                param["intOTPTypeSR"] = 1
                                param["intOTPTypeIDEMAIL"] = 10
                                param["intOTPTypeIDSMS"] = 1
                                ApiRequest.shared.requestPostMethod(strurl: apiName.SendOTP, params: param, showProgress: true) { sucess, data, error in
                                    
                                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                                        
                                        if let issuccess =  json["issuccess"] as? Bool ,issuccess {
                                            self.bindViewModelToController(param, json["message"] as? String ?? "")
                                        }else {
                                            self.inputErrorMessage.value = json["message"] as? String
                                        }
                                    }
                                    
                                }
                                
                            }
                        }
                        
                    } catch {
                        print(error)
                        DispatchQueue.main.async {
                            //completion(false,Data(), error.localizedDescription)
                        }
                    }
                    
                }
                
                
            }
            
            
            
            
        }
        
        
        
    }
    
    
}


