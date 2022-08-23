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
    
    
//    func requestPostMethodForMultipart(strurl:String,fileName:String,fileData:Data,params:[String:Any],headers:[String:Any],showProgress progres:Bool,completion: @escaping (_ sucess:Bool, _ data:[String:Any]?) -> Void) {
//        var headersData : HTTPHeaders = [
//            "content-type": "multipart/form-data"]
//
//        let headersDataValues = ["Authorization": objUserLogin?.token ?? ""]
//        if progres {
//            HUD.show(.progress)
//        }
//
//        for data in (headersDataValues){
//            if let value  = data.value as? String {
//                let heaerData = HTTPHeader(name:data.key , value: value)
//                headersData.add(heaerData)
//            }else if let value  = data.value as? Int{
//                let heaerData = HTTPHeader(name:data.key , value: "\(value)")
//                headersData.add(heaerData)
//            }
//        }
//
//
//        // CREATE AND SEND REQUEST ----------
//        AF.upload(multipartFormData: { multipartFormData in
//            // do{
//            for (key, value) in (params){
//                if value is String {
//                    multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
//                } else if value is Int {
//                    multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
//                }else if value is Float {
//                    multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
//                }else if value is Double {
//                    multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
//                }
//
//            }
//            multipartFormData.append(fileData, withName:"file", fileName:fileName, mimeType: "image/jpeg")
//
//        }, to: strurl, method: .post,headers:headersData) .uploadProgress(queue:.global(), closure: { progress in
//            print("Upload Progress: \(progress.fractionCompleted)")
//        }).responseJSON(completionHandler: { response in
//            var responseData = [String:Any]()
//            if let responseDatas = response.data {
//                if let returnData = String(data:responseDatas, encoding: .utf8) {
//                    if let data = returnData.data(using: .utf8) {
//                        do {
//                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] {
//                                responseData = json
//                            }
//                        } catch {
//                            print("Something went wrong")
//                        }
//                    }
//                }
//
//            }
//            if response.response?.statusCode == 200 {
//                completion(true,responseData)
//            }else {
//                completion(false,responseData)
//            }
//        }).response { (response) in
//            switch response.result {
//            case .success(let resut):
//                print("upload success result: \(String(describing: resut))")
//            case .failure(let err):
//                print("upload err: \(err)")
//            }
//            DispatchQueue.main.async {
//                HUD.hide()
//            }
//        }
//
//    }
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
        request.setValue("343434343434", forHTTPHeaderField: "strDeviceId")
        request.setValue("Android", forHTTPHeaderField: "strPlatformType")
      //  request.setValue(objUserLogin?.token, forHTTPHeaderField: "Authorization")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
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
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                    DispatchQueue.main.async {
                        completion(false,Data(), error.localizedDescription)
                    }
                }
                DispatchQueue.main.async {
                    completion(true,data, nil)
                }
            }else {
                if let error = error {
                    DispatchQueue.main.async {
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
