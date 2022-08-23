//
//  setPasswordViewModel.swift
//  MMRDA
//
//  Created by Kirti Chavda on 22/08/22.
//

import Foundation

class setPasswordViewModel {
    
    var strPassword = String()
    var strConfirm = String()
    var strOtpNumber = String()
    var dict = [String:Any]()
    
    var bindViewModelToController : ((_ sucess:Bool) -> ()) = { sucess in }
    
    var inputErrorMessage: Observable<String?> = Observable(nil)
    func submitSignUP(){
        
        
        if strPassword.trim().isValidPassword() == false {
            inputErrorMessage.value = "pls_enter_valid_pass".LocalizedString
        }
        else if strPassword != strConfirm {
            inputErrorMessage.value = "pass_confirm_pass".LocalizedString
        }
        else {
            
            
            dict["strPassword"] = Helper.shared.passwordEncryptedsha256(str:strPassword)
            dict["intUserID"] = 0
            ApiRequest.shared.requestPostMethod(strurl: apiName.signup, params: dict, showProgress: true) { sucess, data, error in
                
                
                if sucess {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                            
                            if let issuccess =  json["issuccess"] as? Bool ,issuccess {
                                self.bindViewModelToController(true)
                                
                            }else {
                                
                                self.inputErrorMessage.value = json["message"] as? String
                                
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
    
    func resendOTP(){
        
        
        
        ApiRequest.shared.requestPostMethod(strurl: apiName.reSendOTP, params: dict, showProgress: true) { sucess, data, error in
            
            
            if sucess {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        
                        self.inputErrorMessage.value = json["message"] as? String
                        
                        if let issuccess =  json["issuccess"] as? Bool ,issuccess {
                            self.bindViewModelToController(false)
                            self.inputErrorMessage.value = json["message"] as? String
                            
                        }else {
                            
                            
                            
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
    func verifyOTP(){
        
        dict["strOTPNo"] = strOtpNumber
        ApiRequest.shared.requestPostMethod(strurl: apiName.VerifyOTP, params: dict, showProgress: true) { sucess, data, error in
            
            if sucess {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        
                        self.inputErrorMessage.value = json["message"] as? String
                        
                        if let issuccess =  json["issuccess"] as? Bool ,issuccess {
                            
                            self.bindViewModelToController(true)
                           
                            
                        }else {
                            self.inputErrorMessage.value = json["message"] as? String
                            
                            
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
