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
    var isMpin = false
    
    var strMobilOReEmail = String()
    
    var bindViewModelToController : ((_ sucess:Bool) -> ()) = { sucess in }
    
    var bindViewModelToForgotController : ((_ param:[String:Any]) -> ()) = { param in }
    
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
            dict["strMobileNo"] = dict["strPhoneNo"]
            
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
                           
                        }
                    }
                    
                }
                
                
            }
         
        }
   
    }
    
    func resendOTP(){
        dict["intOTPTypeSR"] = 1
        
        ApiRequest.shared.requestPostMethod(strurl: apiName.SendOTP, params: dict, showProgress: true) { sucess, data, error in
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
    func verifyLoginChangeOTP(){
        
        var param = [String:Any]()
        param["strPhoneNo"] = dict["strPhoneNo"]
        param["strEmailID"] = dict["strEmailID"]
        param["intOTPTypeIDSMS"] = 20
        if dict["intOTPTypeIDSMS"] as? Int == 9 {
            param["intOTPTypeIDSMS"] = 9
        }
        
        
        param["strOTPNo"] = strOtpNumber
        ApiRequest.shared.requestPostMethod(strurl: apiName.VerifyOTP, params: param, showProgress: true) { sucess, data, error in
            
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
    func forgotSendOTP(){
        
        if strMobilOReEmail.isEmpty {
            self.inputErrorMessage.value = "pls_enter_email_id".LocalizedString
        }else if strMobilOReEmail.isEmpty == false  && strMobilOReEmail.isNumeric && strMobilOReEmail.mobileNumberValidation() == false {
            self.inputErrorMessage.value = "pls_enter_valid_mobile_number".LocalizedString
        }
        else if strMobilOReEmail.isEmpty == false  && strMobilOReEmail.isNumeric == false && strMobilOReEmail.isValidEmail() == false  {
            self.inputErrorMessage.value = "pls_enter_valid_email_id".LocalizedString
        }else {
            
            var param = [String:Any]()
            
            param["bOTPPrefix"] = false
            param["bSendAsAttachment"] = false
            param["intOTPTypeSR"] = 1
            param["strName"] = ""
            if strMobilOReEmail.isNumeric {
                param["intOTPTypeIDSMS"] = isMpin ? 2 : 3
                param["intOTPTypeIDEMAIL"] = 0
                param["strEmailID"] = nil
                param["strPhoneNo"] = strMobilOReEmail
               
                
            }else {
                param["intOTPTypeIDSMS"] = 0
                param["intOTPTypeIDEMAIL"] = isMpin ? 11 : 12
                param["strPhoneNo"] = nil
                param["strEmailID"] = strMobilOReEmail
            }
            ApiRequest.shared.requestPostMethod(strurl: apiName.SendOTP, params: param, showProgress: true) { sucess, data, error in
                if sucess {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                            
                          
                            
                            if let issuccess =  json["issuccess"] as? Bool ,issuccess {
                                
                                if param["intOTPTypeIDSMS"] as? Int == 0 {
                                    param["intOTPTypeIDSMS"] = param["intOTPTypeIDEMAIL"]
                                    param["intOTPTypeIDEMAIL"] = nil
                                }
                                
                                self.bindViewModelToForgotController(param)
                               
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
    func loginChangeSendOTP(){
        
    
        if strMobilOReEmail.isEmpty {
            self.inputErrorMessage.value = "pls_enter_email_id".LocalizedString
        }else if strMobilOReEmail.isEmpty == false  && strMobilOReEmail.isNumeric && strMobilOReEmail.mobileNumberValidation() == false {
            self.inputErrorMessage.value = "pls_enter_valid_mobile_number".LocalizedString
        }
        else if strMobilOReEmail.isEmpty == false  && strMobilOReEmail.isNumeric == false && strMobilOReEmail.isValidEmail() == false  {
            self.inputErrorMessage.value = "pls_enter_valid_email_id".LocalizedString
        }else {
            
            
            var param = [String:Any]()
            if  strMobilOReEmail.isNumeric {
                param["strPhoneNo"] = strMobilOReEmail
            }else {
                param["strEmailID"] = strMobilOReEmail
            }
            
            ApiRequest.shared.requestPostMethod(strurl: apiName.VerifyPhoneNO, params: param, showProgress: true) { sucess, data, error in
                
                if sucess {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                            
                            if let issuccess =  json["issuccess"] as? Bool ,issuccess {
                                self.inputErrorMessage.value = json["message"] as? String
                                
                            }else {
                                
                                
                                var param = [String:Any]()
                                
                                param["bOTPPrefix"] = false
                                param["bSendAsAttachment"] = false
                                param["intOTPTypeSR"] = 1
                                param["strName"] = ""
                                if self.strMobilOReEmail.isNumeric {
                                    param["intOTPTypeIDSMS"] = 9
                                    param["intOTPTypeIDEMAIL"] = 0
                                    param["strEmailID"] = nil
                                    param["strPhoneNo"] = self.strMobilOReEmail
                                    
                                    
                                }else {
                                    param["intOTPTypeIDSMS"] = 0
                                    param["intOTPTypeIDEMAIL"] = 20
                                    param["strPhoneNo"] = nil
                                    param["strEmailID"] = self.strMobilOReEmail
                                }
                                ApiRequest.shared.requestPostMethod(strurl: apiName.SendOTP, params: param, showProgress: true) { sucess, data, error in
                                    if sucess {
                                        do {
                                            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                                                
                                                if let issuccess =  json["issuccess"] as? Bool ,issuccess {
                                                    self.bindViewModelToForgotController(param)
                                                    
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
                    }
                    catch {
                        print(error)
                        
                    }
                }
            }
            
            
            
            
            
        }
        
        
    }
    
    func resetPassword(){
        
        if strPassword.trim().isValidPassword() == false {
            inputErrorMessage.value = "pls_enter_valid_pass".LocalizedString
        }
        if strConfirm.trim().isValidPassword() == false {
            inputErrorMessage.value = "plsenterconfirmpassword".LocalizedString
        }
        else if strPassword != strConfirm {
            inputErrorMessage.value = "pass_confirm_pass".LocalizedString
        }
        else {
            
            
            dict["strPassword"] = Helper.shared.passwordEncryptedsha256(str:strPassword)
            dict["strMobileNo"] = dict["strPhoneNo"] as? String
            
            if let phone = dict["strPhoneNo"] as? String ,phone.isEmpty {
                dict["strMobileNo"] = dict["strEmailID"] as? String
            }
         
            ApiRequest.shared.requestPostMethod(strurl: apiName.forgetPassword, params: dict, showProgress: true) { sucess, data, error in
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
                           
                        }
                    }
                    
                }
                
                
            }
         
        }
    }
    func resetMPIN(){
        
        if strPassword.trim().MpinValidation() == false {
            inputErrorMessage.value = "plsentermpin".LocalizedString
        }
        if strConfirm.trim().MpinValidation() == false {
            inputErrorMessage.value = "plsenterconfirmmpin".LocalizedString
        }
        else if strPassword != strConfirm {
            inputErrorMessage.value = "mpin_mismatch_msg".LocalizedString
        }
        else {
           
            var param = [String:Any]()
            param["strMPIN"] = Helper.shared.passwordEncryptedsha256(str:strPassword)
            param["strMobileNo"] = dict["strPhoneNo"] as? String
            if let phone = dict["strPhoneNo"] as? String ,phone.isEmpty {
                param["strMobileNo"] = dict["strEmailID"] as? String
            }
            ApiRequest.shared.requestPostMethod(strurl: apiName.forgetMpin, params: param, showProgress: true) { sucess, data, error in
                

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
                           
                        }
                    }
                    
                }
                
                
            }
         
        }
    }
   
    func setMPIN(){
        
        if strPassword.trim().MpinValidation() == false {
            inputErrorMessage.value = "plsentermpin".LocalizedString
        }
        if strConfirm.trim().MpinValidation() == false {
            inputErrorMessage.value = "plsenterconfirmmpin".LocalizedString
        }
        else if strPassword != strConfirm {
            inputErrorMessage.value = "mpin_mismatch_msg".LocalizedString
        }
        else {
           
            var param = [String:Any]()
            param["strMPIN"] = Helper.shared.passwordEncryptedsha256(str:strPassword)
            param["intUserID"] = Helper.shared.objloginData?.intUserID ?? 0
           
            ApiRequest.shared.requestPostMethod(strurl: apiName.setMpin, params: param, showProgress: true) { sucess, data, error in
                
                
                if sucess {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                            
                            if let issuccess =  json["issuccess"] as? Bool ,issuccess {
                                
                                UserDefaults.standard.set(true, forKey: userDefaultKey.isMpinEnable.rawValue)
                                UserDefaults.standard.set(self.strPassword, forKey: userDefaultKey.mpinData.rawValue)
                                UserDefaults.standard.synchronize()
                                
                                self.bindViewModelToController(true)
                                
                            }else {
                                self.inputErrorMessage.value = json["message"] as? String
                                
                            }
                        }
                        
                    } catch {
                        print(error)
                        DispatchQueue.main.async {
                           
                        }
                    }
                    
                }
                
                
            }
         
        }
    }
    

}
