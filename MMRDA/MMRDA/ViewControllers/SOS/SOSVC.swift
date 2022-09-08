//
//  SOSVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 08/09/22.
//

import UIKit

class SOSVC: BaseVC {

    @IBOutlet weak var btnShareLocation: UIButton!
    
    @IBOutlet weak var btnSharePhoto: UIButton!
    @IBOutlet weak var btnShareVoice: UIButton!
    @IBOutlet weak var sosimageview: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"sos".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        let jeremyGif = UIImage.gifImageWithName("timers")
        sosimageview.image = jeremyGif
        btnSharePhoto.underline()
        btnShareVoice.underline()
        btnShareLocation.underline()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionStartSOS(_ sender: Any) {
       
        
    }
    
    
    
    
    @IBAction func actionShareVoiceMesage(_ sender: Any) {
        if let firstPresented = UIStoryboard.ShareLocationVC() {
            firstPresented.modalTransitionStyle = .crossDissolve
            firstPresented.titleString = "sharevoicemessage".LocalizedString
            firstPresented.isSharephoto = false
            firstPresented.isShareVoice = true
            firstPresented.isShowTrusedContacts = false
            firstPresented.fileName = "\(Helper.shared.objloginData?.intUserID ?? 0)_SOS_\(Date())"
            firstPresented.isShareLocation = false
            firstPresented.topImage = #imageLiteral(resourceName: "audio")
            firstPresented.modalPresentationStyle = .overCurrentContext
            APPDELEGATE.topViewController!.present(firstPresented, animated: false, completion: nil)
        }
    }
    
    @IBAction func actionShareLocation(_ sender: Any) {
        if let urlStr = NSURL(string: "https://maps.google.com/maps/?q=\(LocationManager.sharedInstance.currentLocation.coordinate.latitude),\(LocationManager.sharedInstance.currentLocation.coordinate.longitude)") {
            let strMessage = String(format: "\("sos_msg_one".LocalizedString) %@ ,\("sos_msg_two".LocalizedString) %@ ", urlStr,"")
            if let firstPresented = UIStoryboard.ShareLocationVC() {
                firstPresented.modalTransitionStyle = .crossDissolve
                firstPresented.titleString = "lblsharelocation".LocalizedString
                firstPresented.isSharephoto = false
                firstPresented.isShareVoice = false
                firstPresented.messageString = strMessage
               // firstPresented.arrContacts = arrContatcs
                firstPresented.isShowTrusedContacts = true
               // firstPresented.vehicleID = vehcileID
                firstPresented.isShareLocation = true
                firstPresented.topImage = #imageLiteral(resourceName: "shareLocation")
                firstPresented.modalPresentationStyle = .overCurrentContext
                APPDELEGATE.topViewController!.present(firstPresented, animated: false, completion: nil)
            }
        }
        
    }
    
    @IBAction func actionShareVideo(_ sender: Any) {
        if let firstPresented = UIStoryboard.ShareLocationVC() {
            firstPresented.modalTransitionStyle = .crossDissolve
            firstPresented.titleString = "sharepicvideo".LocalizedString
            firstPresented.isSharephoto = true
            firstPresented.isShowTrusedContacts = false
            firstPresented.fileName = "\(Helper.shared.objloginData?.intUserID ?? 0)_SOS_\(Date())"
            firstPresented.isShareVoice = false
            firstPresented.isShareLocation = false
            firstPresented.topImage = #imageLiteral(resourceName: "Group 16574")
            firstPresented.modalPresentationStyle = .overCurrentContext
            APPDELEGATE.topViewController!.present(firstPresented, animated: false, completion: nil)
        }
        
    }
}
