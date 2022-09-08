//
//  ApiRequest.swift
//  PanajiSmartParking
//
//  Created by Kirti Chavda on 21/06/22.
//

import Foundation
import SVProgressHUD
import Alamofire

class ApiRequest:NSObject {
    
    static let shared = ApiRequest()
    private override init() {
        
    }
    
    func refreshTokenData(completion: @escaping (_ sucess:Bool) -> Void){
        guard let url = URL(string: apiName.refreshToken)else {return}
        
        var param = [String:Any]()
        param["intUserMasterID"] = Helper.shared.objloginData?.intUserID
        param["strUserName"] = Helper.shared.objloginData?.strFullName
        param["strRefreshToken"] = Helper.shared.objloginData?.strRefreshToken
        param["strRefGUID"] = Helper.shared.objloginData?.strRefreshTokenGUID
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(Helper.shared.getAndsaveDeviceIDToKeychain(), forHTTPHeaderField: "strDeviceId")
        request.setValue("IOS", forHTTPHeaderField: "strPlatformType")
        //        if UserDefaults.standard.bool(forKey:userDefaultKey.isLoggedIn.rawValue) {
        //            request.setValue("Bearer " + (Helper.shared.objloginData?.strAccessToken ?? ""), forHTTPHeaderField: "Authorization")
        //        }
        guard let httpBody = try? JSONSerialization.data(withJSONObject: param, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                SVProgressHUD .dismiss()
            }
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let Objdata = json["data"] as? [String:Any] {
                            
                            Helper.shared.objloginData?.strRefreshTokenGUID = Objdata["strRefreshTokenGUID"] as? String
                            Helper.shared.objloginData?.strRefreshToken = Objdata["strRefreshToken"] as? String
                            Helper.shared.objloginData?.strAccessToken = Objdata["strAccessToken"] as? String
                            Helper.shared.objloginData?.dteAccessTokenExpirationTime = Objdata["dteAccessTokenExpirationTime"] as? String
                            
                            if let encoded = try? JSONEncoder().encode(Helper.shared.objloginData) {
                                UserDefaults.standard.set(encoded, forKey: userDefaultKey.logedUserData.rawValue)
                                UserDefaults.standard.synchronize()
                            }
                        }
                        print("refresh token:::",json)
                    }
                   
                } catch {
                    print(error)
                    DispatchQueue.main.async {
                        completion(false)
                       
                    }
                }
                DispatchQueue.main.async {
                    completion(true)
                }
            }else {
                if let error = error {
                    DispatchQueue.main.async {
                        completion(false)
                    }
                }
            }
        }.resume()
    }
    
    
    func requestPostMethodForMultipart(strurl:String,fileName:String,fileData:Data?,params:[String:Any],showProgress progres:Bool,completion: @escaping (_ sucess:Bool, _ data:[String:Any]?) -> Void) {
        let headersData : HTTPHeaders = [
            "content-type": "multipart/form-data",
            "Authorization": "Bearer " + (Helper.shared.objloginData?.strAccessToken ?? ""),
            "strPlatformType": "IOS",
            "strDeviceId": Helper.shared.getAndsaveDeviceIDToKeychain(),
        ]

        
        
    
        
//        request.setValue(Helper.shared.getAndsaveDeviceIDToKeychain(), forHTTPHeaderField: "strDeviceId")
//        request.setValue("IOS", forHTTPHeaderField: "strPlatformType")
//       // request.setValue("lan", forHTTPHeaderField: "strPlatformType")
//        if UserDefaults.standard.bool(forKey:userDefaultKey.isLoggedIn.rawValue) {
//            request.setValue("Bearer " + (Helper.shared.objloginData?.strAccessToken ?? ""), forHTTPHeaderField: "Authorization")
//        }
        if progres {
            SVProgressHUD .show()
        }

//        for data in (headersDataValues){
//            if let value  = data.value as? String {
//                let heaerData = HTTPHeader(name:data.key , value: value)
//                headersData.add(heaerData)
//            }else if let value  = data.value as? Int{
//                let heaerData = HTTPHeader(name:data.key , value: "\(value)")
//                headersData.add(heaerData)
//            }
//        }


        // CREATE AND SEND REQUEST ----------
        AF.upload(multipartFormData: { multipartFormData in
            // do{
            for (key, value) in (params){
                if value is String {
                    multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                } else if value is Int {
                    multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                }else if value is Float {
                    multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                }else if value is Double {
                    multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                }

            }
            if fileData != nil {
                multipartFormData.append(fileData!, withName:"strDocumentPath", fileName:fileName, mimeType: "image/jpeg")
            }

        }, to: strurl, method: .post,headers:headersData) .uploadProgress(queue:.global(), closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { response in
            
            print("response:",response)
            var responseData = [String:Any]()
            if let responseDatas = response.data {
                if let returnData = String(data:responseDatas, encoding: .utf8) {
                    if let data = returnData.data(using: .utf8) {
                        do {
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] {
                                responseData = json
                            }
                        } catch {
                            print("Something went wrong")
                        }
                    }
                }
                
            }
            if response.response?.statusCode == 200 {
                completion(true,responseData)
            }else {
                completion(false,responseData)
            }
        }).response { (response) in
            switch response.result {
            case .success(let resut):
                print("upload success result: \(String(describing: resut))")
            case .failure(let err):
                print("upload err: \(err)")
            }
            DispatchQueue.main.async {
                SVProgressHUD .dismiss()
            }
        }

    }
//    func downloadData(url:URL,completion: @escaping (_ sucess:Bool, _ path: String,_ isAlreadyExist:Bool) -> Void) {
//        var downloadPath:String = ""
//        HUD.show(.progress)
//        FileDownloader.loadFileAsync(url: url) { (path, error, isDownload) in
//            DispatchQueue.main.async{
//                HUD.hide()
//                if isDownload == true {
//                    completion(false,path ?? "",true)
//                }else{
//                    //                    downloadPath = downloadPath
//                    completion(true,downloadPath,false)
//                }
//
//            }
//        }
//    }
    
    //    self requ
    func requestPostMethod(strurl:String,params:[String:Any],showProgress progres:Bool,completion: @escaping (_ sucess:Bool, _ data: Data,_ error:String?) -> Void) {
        
        guard let url = URL(string: strurl)else {return}
        
        print("url",url,params)
        if progres {
            SVProgressHUD .show()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(Helper.shared.getAndsaveDeviceIDToKeychain(), forHTTPHeaderField: "strDeviceId")
        request.setValue(Helper.shared.getLanguageCodeforApi(), forHTTPHeaderField: "lan")
        request.setValue("IOS", forHTTPHeaderField: "strPlatformType")
        if UserDefaults.standard.bool(forKey:userDefaultKey.isLoggedIn.rawValue) {
            request.setValue("Bearer " + (Helper.shared.objloginData?.strAccessToken ?? ""), forHTTPHeaderField: "Authorization")
        }
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        print("header:",request.headers)
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            
            if let resp = response as? HTTPURLResponse ,resp.statusCode == 401 {
                
                self .refreshTokenData { sucess in
                    if sucess {
                        print("status sucess")
                        self.requestPostMethod(strurl: strurl, params: params, showProgress: progres) { sucess, data, error in
                            completion(sucess,data, error)
                        }
                    }
                }
                return
            }
            DispatchQueue.main.async {
                SVProgressHUD .dismiss()
                if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                            print(json)
                            if let arr = json["data"] as? [[String:Any]] , arr.first?["result"] as? Int ==  9 {
                                if let msg = json["message"] as? String {
                                    APPDELEGATE.topViewController?.showAlertViewWithMessageAndActionHandler("", message: msg, actionHandler: {
                                        UserDefaults.standard.set(false, forKey: userDefaultKey.isLoggedIn.rawValue)
                                        UserDefaults.standard.synchronize()
                                        APPDELEGATE.setupViewController()
                                    })
                                    completion(false,Data(), nil)
                                }
                            }
                        }
                        
                    } catch {
                        print(error)
                        completion(false,Data(), error.localizedDescription)
                        
                    }
                  
                        completion(true,data, nil)
                    
                }else {
                    if let error = error {
                        completion(false,Data(),error.localizedDescription)
                        
                    }
                }
            }
            
        }.resume()
        
    }
    
//    func requestGetMethod(strurl:String,params:[String:String],showProgress progres:Bool,completion: @escaping (_ sucess:Bool, _ data: Data) -> Void) {
//
//        guard let url = URL(string: strurl)else {return}
//
//
//        if progres {
//            HUD.show(.progress)
//        }
//
//        guard  let urlComp = NSURLComponents(string:strurl)else {return}
//
//        var items = [URLQueryItem]()
//        for (key,value) in params {
//            items.append(URLQueryItem(name: key, value: value))
//        }
//        items = items.filter{!$0.name.isEmpty}
//
//        if !items.isEmpty {
//            urlComp.queryItems = items
//        }
//
//        var request = URLRequest(url: urlComp.url!)
//        request.httpMethod = "GET"
//        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue(objUserLogin?.token, forHTTPHeaderField: "Authorization")
//        print("url:::",request.url?.absoluteString)
//        let session = URLSession.shared
//        session.dataTask(with: request) { (data, response, error) in
//
//            DispatchQueue.main.async {
//                HUD.hide()
//            }
//            if let data = data {
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: [])
//                    print(json)
//                } catch {
//                    print(error)
//                }
//                DispatchQueue.main.async {
//                    completion(true,data)
//                }
//            }else {
//                if (error != nil) {
//                    DispatchQueue.main.async {
//                        completion(false,Data())
//                    }
//                }
//            }
//        }.resume()
//
//    }
}
