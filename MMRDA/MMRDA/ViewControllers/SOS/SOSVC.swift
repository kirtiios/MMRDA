//
//  SOSVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 08/09/22.
//

import UIKit
import Toast


class SOSVC: BaseVC {

    @IBOutlet weak var btnstartSos: UIButton!
    @IBOutlet weak var btnShareLocation: UIButton!
    @IBOutlet weak var btnSharePhoto: UIButton!
    @IBOutlet weak var btnShareVoice: UIButton!
    @IBOutlet weak var sosimageview: UIImageView!
    var intSOSid:Any?
    var arrContact = [SOSContact]()
    private var objViewModel = SosViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"sos".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        let jeremyGif = UIImage.gifImageWithName("timers")
        sosimageview.image = UIImage(named: "ic_sos_start") //jeremyGif
        btnSharePhoto.underline()
        btnShareVoice.underline()
        btnShareLocation.underline()
       
      

        
        objViewModel.delegate = self
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
        
       
            
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
       
    }
    func checkandLoadContact(){
        do {
            
            if let properyAsData = UserDefaults.standard.object(forKey:"contactNo") as? Data {
                if let placesArray = try (NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(properyAsData) as? [SOSContact] ) {
                    self.arrContact.removeAll()
                    for contact in placesArray {
                        let objContact : SOSContact = SOSContact.init(contactId: contact.SOSContact_ContactId, name: contact.SOSContact_Name, phone: contact.SOSContact_Phone.removeWhitespaceInString())
                        self.arrContact.append(objContact)
                    }
                    
                        
                    
                }
            }else{
                self.arrContact.removeAll()
            }
        }catch (let error){
            print("Failed to convert propert to Data : \(error.localizedDescription)")
            
        }
        
        if self.arrContact.count < 1 {
            let vc = UIStoryboard.TrustedContactVC()
            self.navigationController?.pushViewController(vc!, animated:true)
        }else {
          
            LocationManager.sharedInstance.getCurrentLocation { success, location in
                if success {
                    
                    let arrName = self.arrContact.map { obj in
                        return  obj.SOSContact_Name
                    }
                    let arrPhone = self.arrContact.map { obj in
                        return  obj.SOSContact_Phone
                    }
                    
                    var param = [String:Any]()
                    param["intUserID"] = Helper.shared.objloginData?.intUserID
                    param["decLatitude"] = "\(LocationManager.sharedInstance.currentLocation.coordinate.latitude)"
                    param["decLongitude"] = "\(LocationManager.sharedInstance.currentLocation.coordinate.longitude)"
                    param["strLocationName"] = ""
                    param["strMobileNo"] = arrPhone.joined(separator:",")
                    param["strUserName"] = arrName.joined(separator:",")
                    self.objViewModel.startSOS(param: param) { obj in
                        self.intSOSid = obj?["intSOSID"]
                        self.btnstartSos.isSelected = true
                        self.sosimageview.image = UIImage(named:"ic_sos_stop")
                        var param = [String:Any]()
                        param["strEmailID"] = ""
                        param["bOTPPrefix"] = false
                        param["intOTPTypeSR"] = 1
                        param["strOTPNo"] = "http://maps.google.com/maps?q=" + "\(LocationManager.sharedInstance.currentLocation.coordinate.latitude)" + "," + "\(LocationManager.sharedInstance.currentLocation.coordinate.longitude)";
                        param["intOTPTypeIDSMS"] = 19
                        param["intOTPTypeIDEMAIL"] = 0
                        param["bSendAsAttachment"] = false
                        self.objViewModel.startSOSSendSMS(param: param) { sucess in
                            self.view.makeToast("strSosStarted".localized())
                        }
                      
                    }
                    
                }
            }
                
               
           
        }
    }
    
    @IBAction func actionStartSOS(_ sender: Any) {
        if btnstartSos.isSelected {
            
            if intSOSid != nil {
                var param = [String:Any]()
                param["intSOSID"] = intSOSid
                self.objViewModel.EdnSOS(param: param) { dict in
                    self.btnstartSos.isSelected = false
                    self.sosimageview.image = UIImage(named: "ic_sos_start")
                    self.view.makeToast("strSosStopped".localized())
                  
                    
                    
                }
            }
            
        }else {
            self .checkandLoadContact()
        }
        
        
    }

    @IBAction func actionShareVoiceMesage(_ sender: Any) {
        if let firstPresented = UIStoryboard.ShareLocationVC() {
            firstPresented.modalTransitionStyle = .crossDissolve
            firstPresented.titleString = "sharevoicemessage".LocalizedString
            firstPresented.isSharephoto = false
            firstPresented.isShareVoice = true
            firstPresented.isShowTrusedContacts = false
            firstPresented.fileName = "\(Helper.shared.objloginData?.intUserID ?? 0)_SOS_\(Date().timeIntervalSinceNow)"
            firstPresented.isShareLocation = false
            firstPresented.topImage = #imageLiteral(resourceName: "audio")
            firstPresented.modalPresentationStyle = .overCurrentContext
            APPDELEGATE.topViewController!.present(firstPresented, animated: false, completion: nil)
        }
    }
    
    @IBAction func actionShareLocation(_ sender: Any) {
        
        
        
        LocationManager.sharedInstance.getCurrentLocation { success, location in
            if success {
                let text = "share_my_loc".LocalizedString + "http://maps.google.com/maps?daddr=\(location?.coordinate.latitude ?? 0),\(location?.coordinate.longitude ?? 0)"
                let textToShare = [ text ]
                let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
                activityViewController.excludedActivityTypes = []
                
                self.present(activityViewController, animated: true, completion: nil)
            }
        }
        
//        LocationManager.sharedInstance.getCurrentLocation { success, location in
//            if success {
//                if let urlStr = NSURL(string: "https://maps.google.com/maps/?q=\(LocationManager.sharedInstance.currentLocation.coordinate.latitude),\(LocationManager.sharedInstance.currentLocation.coordinate.longitude)") {
//                    let strMessage = String(format: "\("sos_msg_one".LocalizedString) %@ ", urlStr)
//                    if let firstPresented = UIStoryboard.ShareLocationVC() {
//                        firstPresented.modalTransitionStyle = .crossDissolve
//                        firstPresented.titleString = "lblsharelocation".LocalizedString
//                        firstPresented.isSharephoto = false
//                        firstPresented.isShareVoice = false
//                        firstPresented.messageString = strMessage
//                       // firstPresented.arrContacts = arrContatcs
//                        firstPresented.isShowTrusedContacts = true
//                       // firstPresented.vehicleID = vehcileID
//                        firstPresented.isShareLocation = true
//                        firstPresented.topImage = #imageLiteral(resourceName: "shareLocation")
//                        firstPresented.modalPresentationStyle = .overCurrentContext
//                        APPDELEGATE.topViewController!.present(firstPresented, animated: false, completion: nil)
//                    }
//                }
//            }
//        }
        
        
        
    }
    
    @IBAction func actionShareVideo(_ sender: Any) {
        if let firstPresented = UIStoryboard.ShareLocationVC() {
            firstPresented.modalTransitionStyle = .crossDissolve
            firstPresented.titleString = "sharepicvideo".LocalizedString
            firstPresented.isSharephoto = true
            firstPresented.isShowTrusedContacts = false
            firstPresented.fileName = "\(Helper.shared.objloginData?.intUserID ?? 0)_SOS_\(Date().timeIntervalSinceNow)"
            firstPresented.isShareVoice = false
            firstPresented.isShareLocation = false
            firstPresented.topImage = #imageLiteral(resourceName: "Group 16574")
            firstPresented.modalPresentationStyle = .overCurrentContext
            APPDELEGATE.topViewController!.present(firstPresented, animated: false, completion: nil)
        }
        
    }
}
extension SOSVC:ViewcontrollerSendBackDelegate {
    func getInformatioBack<T>(_ handleData: inout T) {
        if let data = handleData as? [myTicketList] {
           // arrTicketList = data
        }
        
       
    }
}
