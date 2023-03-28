//
//  Helper.swift
//  MMRDA
//
//  Created by Kirti Chavda on 22/08/22.
//

import UIKit
import CommonCrypto
import AVFoundation
import LocalAuthentication
import QRCode


class Helper: NSObject {
    
    static let shared = Helper()
    var objloginData:LoginDataModel?
    
    func passwordEncryptedsha256(str: String) -> String {
     
        if let strData = str.data(using: String.Encoding.utf8) {
            /// #define CC_SHA256_DIGEST_LENGTH     32
            /// Creates an array of unsigned 8 bit integers that contains 32 zeros
            var digest = [UInt8](repeating: 0, count:Int(CC_SHA256_DIGEST_LENGTH))
     
            /// CC_SHA256 performs digest calculation and places the result in the caller-supplied buffer for digest (md)
            /// Takes the strData referenced value (const unsigned char *d) and hashes it into a reference to the digest parameter.
            strData.withUnsafeBytes {
                // CommonCrypto
                // extern unsigned char *CC_SHA256(const void *data, CC_LONG len, unsigned char *md)  -|
                // OpenSSL                                                                             |
                // unsigned char *SHA256(const unsigned char *d, size_t n, unsigned char *md)        <-|
                CC_SHA256($0.baseAddress, UInt32(strData.count), &digest)
            }
     
            var sha256String = ""
            /// Unpack each byte in the digest array and add them to the sha256String
            for byte in digest {
                sha256String += String(format:"%02x", UInt8(byte))
            }
     
            return sha256String
        }
        return ""
    }
    
    @discardableResult static func copyItemat(source:String,destination:String) -> Bool {
         do {
             let url = URL(fileURLWithPath:source)
             let pdfData = try? Data.init(contentsOf: url)
             let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
             let pdfNameFromUrl = url.lastPathComponent
             let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
             do {
                 try pdfData?.write(to:URL(fileURLWithPath:actualPath.path),options:.atomic)
                     print("pdf successfully saved!")
                 return true
             } catch {
                     print("Pdf could not be saved")
                 return false
                 }
             }
         }
     
    
    
    func getAndsaveDeviceIDToKeychain()->String {
        // Check if we need to update an existing item or create a new one.
        do {
            
            if let usernameData = KeyChain.load(key: keyChainConstant.udid) {
                return String(decoding: usernameData, as: UTF8.self)
                
            }else {
                if  let data = UUID().uuidString.data(using: .utf8) {
                    let status = KeyChain.save(key: keyChainConstant.udid, data:data)
                    
                    print(status)
                }
                
                return  UUID().uuidString
            }
        }
    }

    static func getCurrentViewController() -> UIViewController?
    {
        if let arrVC = UIWindow.key?.rootViewController as? UINavigationController
        {
            if let parentVC = arrVC.viewControllers.last
            {
                return parentVC
            }
        }
        
        return nil
    }
    
    
    //MARK: SAVE/GET IMAGE TO DOCUMENT DIR
    static func saveImageToDocumentDir(image: UIImage, name: String? = nil) -> String? {
        guard let data = image.jpegData(compressionQuality: 0.4) ?? image.pngData()
            else {
                return nil
        }
        
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return nil
        }
        
        print(directory)
        
        let guid = (name ?? "Demo" + ".jpeg")
        do {
            try data.write(to: directory.appendingPathComponent(guid)!)
            //            let tempFolderPath = NSTemporaryDirectory()
            //            try data.write(to: URL(fileURLWithPath: tempFolderPath.appending(guid)))
            return guid
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func saveVideoToDocumentDir(data: Data,name:String) -> String? {
        
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return nil
        }
        
        let guid = name + ".mp4"
        
        do {
            try data.write(to: directory.appendingPathComponent(guid)!)
            
            return guid
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func thumbnailForVideoAtURL(url: URL) -> UIImage? {
        
        let asset = AVAsset(url: url)
        let assetImageGenerator = AVAssetImageGenerator(asset: asset)
        
        var time = asset.duration
        time.value = min(time.value, 2)
        
        do {
            let imageRef = try assetImageGenerator.copyCGImage(at: time, actualTime: nil)
            return UIImage(cgImage: imageRef)
        } catch {
            print("error")
            return nil
        }
    }
    
    
    static func getImageFromDocumentDir(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
    
    func getLanguageCodeforApi()->String {
        
//        public static final String ENGLISH = "en";
//        public static final String HINDI = "hi";
//        public static final String PUNJABI = "pa";
//        public static final String MARATHI = "mr";
//        public static final String KANNAD = "kn";
        
        if  languageCode == LanguageCode.English.rawValue {
            return "en"
        }
        else if  languageCode == LanguageCode.Hindi.rawValue {
            return "hn" // return "hi"
        }
        else if  languageCode == LanguageCode.Marathi.rawValue {
            return "mr"
        }else {
            return "en"
        }
      
    }
    func generateQRCode(from string: String) -> UIImage? {
    
        let qrCodeB = QRCode(string:string)
        return  try? qrCodeB?.image()

        
//        if let qrCodeData = EFQRCode.generateGIF(
//            using: generator, withWatermarkGIF: data
//        ) {
//            print("Create QRCode image success.")
//        } else {
//            print("Create QRCode image failed!")
//        }
//
//        let data = string.data(using: String.Encoding.utf8)
//
//        if let filter = CIFilter(name: "CIQRCodeGenerator") {
//            filter.setValue(data, forKey: "inputMessage")
//            let transform = CGAffineTransform(scaleX: 8, y: 8)
//
//            if let output = filter.outputImage?.transformed(by: transform) {
//                return UIImage(ciImage: output)
//            }
//        }
//
//        return nil
    }

//    func getFavResultMessage(typeid:Int)->String {
//        if typeid == 1 {
//            return "strInsertLocationFav".LocalizedString
//        }
//        else  if typeid == 2 {
//            return "strInsertStationFav".LocalizedString
//        }
//        else if typeid == 3 {
//            return "strInsertRouteFav".LocalizedString
//        }
//        else if typeid == 4 {
//            return "strAlreadyStationFav".LocalizedString
//          
//        }
//        else if typeid == 5 {
//            return "strAlreadyLocationFav".LocalizedString
//        }
//        else if typeid == 6 {
//            return "strAlreadyRouteFav".LocalizedString
//        }else if typeid == 9 {
//            return "strUserLogout".LocalizedString
//        }
//        return "Something wrong"
//    
//        
//    }
    func evaluatePolicyFailErrorMessageForLA(errorCode: Int) -> String {
        var message = ""
        if #available(iOS 11.0, macOS 10.13, *) {
            switch errorCode {
            case LAError.biometryNotAvailable.rawValue:
                message = "Authentication could not start because the device does not support biometric authentication."
                
            case LAError.biometryLockout.rawValue:
                message = "Authentication could not continue because the user has been locked out of biometric authentication, due to failing authentication too many times."
                
            case LAError.biometryNotEnrolled.rawValue:
                message = "Authentication could not start because the user has not enrolled in biometric authentication."
                
            default:
                message = "Did not find error code on LAError object"
            }
        } else {
            switch errorCode {
            case LAError.touchIDLockout.rawValue:
                message = "Too many failed attempts."
                
            case LAError.touchIDNotAvailable.rawValue:
                message = "TouchID is not available on the device"
                
            case LAError.touchIDNotEnrolled.rawValue:
                message = "TouchID is not enrolled on the device"
                
            default:
                message = "Did not find error code on LAError object"
            }
        }
        
        return message;
    }
    
    func evaluateAuthenticationPolicyMessageForLA(errorCode: Int) -> String? {
        
        var message:String?
        
        switch errorCode {
            
        case LAError.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials"
            
        case LAError.appCancel.rawValue:
            message = "Authentication was cancelled by application"
            
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.notInteractive.rawValue:
            message = "Not interactive"
            
        case LAError.passcodeNotSet.rawValue:
            message = "FaceID/Passcode is not set on the device \n Please add from Setting app ->Face ID & Passcode"
            
//            APPDELEGATE.topViewController?.showAlertViewWithMessageAndActionHandler("Add FaceID/Passcode", message:message ?? "", actionHandler: {
//                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
//                    return
//                }
//
//               UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
//
//            })
//            message = nil
            
            
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
            
        case LAError.userCancel.rawValue:
            message = "The user did cancel"
            
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"
            
        default:
            message = evaluatePolicyFailErrorMessageForLA(errorCode: errorCode)
        }
        
        return message
    }
    func authenticationWithTouchID(islogin:Bool, completion:@escaping(Bool)->Void?){
        
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = "Use Passcode"

        var authError: NSError?
        let reasonString = "To access the secure data"

        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError) {
            
            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reasonString) { success, evaluateError in
                
                if success {
                    
                    DispatchQueue.main.async {
                       completion(true)
                    }
                    //TODO: User authenticated successfully, take appropriate action
                    
                } else {
                    //TODO: User did not authenticate successfully, look at error and take appropriate action
                    guard let error = evaluateError else {
                        return
                    }
                    if let message = Helper.shared.evaluateAuthenticationPolicyMessageForLA(errorCode: error._code) {
                        DispatchQueue.main.async {
                            APPDELEGATE.topViewController?.showAlertViewWithMessage("", message:message)
                        }
                    }
                   
                 
                    
                   
                    
                }
            }
        } else {
            
            if islogin {
                guard let error = authError else {
                    return
                }
                if let message = Helper.shared.evaluateAuthenticationPolicyMessageForLA(errorCode: error.code) {
                    DispatchQueue.main.async {
                        completion(false)
                        APPDELEGATE.topViewController?.showAlertViewWithMessage("", message:message)
                    }
                }
            }else {
                DispatchQueue.main.async {
                   completion(true)
                }
            }
            

            //TODO: Show appropriate alert if biometry/TouchID/FaceID is lockout or not enrolled
          //  print(Helper.shared.evaluateAuthenticationPolicyMessageForLA(errorCode: error.code))
        }
    }
}

