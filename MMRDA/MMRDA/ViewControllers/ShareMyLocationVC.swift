//
//  ShareMyLocationVC.swift
//  MMRDA
//
//  Created by Kirti Chavda on 05/09/22.
//

import UIKit
import MessageUI
//import FacebookShare



class ShareMyLocationVC: UIViewController {

    @IBOutlet weak var lblAddress: UILabel!
    @IBAction func btnActionFacebookClicked(_ sender: UIButton) {
      //  self.shareTextOnFaceBook()
    }
    @IBAction func btnActionEmailClicked(_ sender: UIButton) {
        if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
               // mail.setToRecipients([])
            mail.setMessageBody(lblAddress.text ?? "", isHTML: false)

                present(mail, animated: true)
            } else {
                // show failure alert
            }
    }
    @IBAction func btnActionWhatsupClicked(_ sender: UIButton) {
        self .sendWhatsdAppMessage(message: self.lblAddress.text ?? "")
    }
    @IBAction func btnActionSmsClicked(_ sender: UIButton) {
        self.sendMessageViaSMS(strMsg:self.lblAddress.text ?? "", recipients:[String]())
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationManager.sharedInstance.getCurrentLocation { success, location in
            if success {
                self.lblAddress.text = "share_my_loc".LocalizedString + "http://maps.google.com/maps?daddr=\(location?.coordinate.latitude ?? 0),\(location?.coordinate.longitude ?? 0)"
            }
        }
        
        let getsure = UITapGestureRecognizer(target: self, action: #selector(btnCloseCliced(gesture:)))
        self.view.addGestureRecognizer(getsure)
        
       // share_my_loc

        // Do any additional setup after loading the view.
    }
    @objc func btnCloseCliced(gesture:UITapGestureRecognizer){
        self .dismiss(animated: true, completion: nil)
    }
    func sendWhatsdAppMessage(message:String) {
//        let urlWhats = "whatsapp://send?text=\(message)"
//        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
//            if let whatsappURL = NSURL(string: urlString) {
//                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
//                    if #available(iOS 10.0, *) {
//                        UIApplication.shared.open(whatsappURL as URL, options: [:], completionHandler: nil)
//                    } else {
//                        UIApplication.shared.openURL(whatsappURL as URL)
//                    }
//                }
//                else {
//                    APPDELEGATE.topViewController?.showAlertViewWithMessage("APPTITLE".LocalizedString, message: "SHARE_TRIP_WHATS_APP_NOT_INSTALLED".LocalizedString)
//                }
//            }
//        }
        
        
        let urlWhats = "whatsapp://send?text=\(message)"

        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = NSURL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    UIApplication.shared.open(whatsappURL as URL, options: [:], completionHandler: { (Bool) in

                    })
                } else {
                    if let url = NSURL(string:"https://apps.apple.com/in/app/whatsapp-messenger/id310633997"){
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(url as URL)
                        }
                        
                        
                    }
                }
            }
        }
    }
    func sendMessageViaSMS(strMsg: String, recipients : [String]) {
       let strMessage = String(format: strMsg)
       
       let messageVC = MFMessageComposeViewController()
        messageVC.messageComposeDelegate = self

       // Configure the fields of the interface.
       messageVC.recipients = recipients
       messageVC.body = strMessage

       // Present the view controller modally.
       if MFMessageComposeViewController.canSendText() {
           self.present(messageVC, animated: true, completion: nil)
       }
    }


  

}
extension ShareMyLocationVC : MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
}
extension ShareMyLocationVC : MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
//extension ShareMyLocationVC : SharingDelegate {
//    func shareTextOnFaceBook() {
//        let shareContent = ShareLinkContent()
//
//        let url  = "http://maps.google.com/maps?daddr=\(LocationManager.sharedInstance.currentLocation.coordinate.latitude ?? 0),\(LocationManager.sharedInstance.currentLocation.coordinate.longitude ?? 0)"
//        shareContent.contentURL = URL.init(string:url)!
//        shareContent.quote  =  self.lblAddress.text
//        ShareDialog(fromViewController: self, content: shareContent, delegate: self).show()
//
//    }
//
//    func sharer(_ sharer: Sharing, didCompleteWithResults results: [String : Any]) {
//        if sharer.shareContent.pageID != nil {
//            print("Share: Success")
//            self.dismiss(animated:true, completion:nil)
//        }
//    }
//    func sharer(_ sharer: Sharing, didFailWithError error: Error) {
//        self.showAlertViewWithMessage("APPTITLE".LocalizedString, message:error.localizedDescription)
//    }
//    func sharerDidCancel(_ sharer: Sharing) {
//        print("Share: Cancel")
//        self.dismiss(animated:true, completion: nil)
//    }
//}
