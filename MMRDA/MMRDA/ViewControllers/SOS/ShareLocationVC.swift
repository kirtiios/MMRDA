//
//  ShareLocationVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 08/09/22.
//

import UIKit
import AVFoundation
import MessageUI
import MobileCoreServices


class ShareLocationVC: UIViewController {
    @IBOutlet weak var consHeightImageView: NSLayoutConstraint!
    @IBOutlet weak var whatsappView: UIStackView!
    @IBOutlet weak var imgTop: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var btnWomenHelpLine: UIButton!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var btnWhatsappBusiness: UIButton!
    @IBOutlet weak var btnSMS: UIButton!
    @IBOutlet weak var txtLocationDetails: UILabel!
    @IBOutlet weak var shareVoiceView: UIView!
    @IBOutlet weak var btnVoiceRecord: UIButton!
    @IBOutlet weak var lblAudioFileName: UILabel!
    @IBOutlet weak var photVideoView: UIView!
    @IBOutlet weak var shareLocationView: UIView!
    @IBOutlet weak var AudioLabelView: UIView!
    @IBOutlet weak var btnWhatsApp: UIButton!
    @IBOutlet weak var lblNoOfContatcs: UILabel!
    @IBOutlet weak var btnphotoVideoCapture: UIButton!
    @IBOutlet weak var lblPhotoVideoName: UILabel!
    
    @IBOutlet weak var txtLinkTrackmyBus: UILabel!
    @IBOutlet weak var lblTrackMyBus: UILabel!
    @IBOutlet weak var caustomSharingView: UIStackView!
    
    var trackMyBusLink:String?
    var arrContacts:[String]?
    var isShowCaustomView:Bool = false
    var timer = Timer()
    var strContact :String = ""
    var timeSec = 0
    var timelimit = 10
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var isShareLocation:Bool = false
    var isShareVoice:Bool = false
    var isSharephoto:Bool = false
    var locationDetails:String?
    var titleString:String = ""
    var messageString:String?
    var showOthetMessage:Bool = false
    var topImage = UIImage()
    var fileName:String?
    var strVideoPath : String?
    var isShowTrusedContacts:Bool = false
    var documentationInteractionController: UIDocumentInteractionController?
    var documentInteractionController: UIDocumentInteractionController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initilize()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated:true)
    }
    
    
    func initilize() {
        popupView.layer.cornerRadius = 6
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        lblName.text = titleString
        imgTop.image = topImage
        
        btnVoiceRecord .setImage(UIImage(named:"audiorecorder"), for: .normal)
        //popupView.borderWidth = 1
        
        if isShareLocation == true {
   
            
            
            
            txtLocationDetails.text = messageString
            shareLocationView.isHidden = true
            shareVoiceView.isHidden = true
            photVideoView.isHidden = true
            if isShowCaustomView == true {
                whatsappView.isHidden = true
                caustomSharingView.isHidden = false
            }else{
                whatsappView.isHidden = false
                caustomSharingView.isHidden = true
            }
            
            btnSMS.isHidden = false
            btnWomenHelpLine.isHidden = true
            
        }else if isSharephoto == true {
            shareVoiceView.isHidden = true
            photVideoView.isHidden = false
            shareLocationView.isHidden = true
            btnSMS.isHidden = true
            btnWomenHelpLine.isHidden = true
            self.consHeightImageView.constant = 380
        }else {
            self.consHeightImageView.constant = 350
            shareVoiceView.isHidden = false
            photVideoView.isHidden = true
            shareLocationView.isHidden = true
            btnSMS.isHidden = true
            btnWomenHelpLine.isHidden = true
            
        }
    }
    
    // reset timer
    @objc fileprivate func resetTimerAndLabel(){
        resetTimerToZero()
        lblTimer.text = String(format: "00:%02d", timeSec)
    }
    
    // stops the timer at it's current time
    @objc fileprivate func stopTimer(){
        timer.invalidate()
    }
    
    // SET TIMER TO ZERO
    @objc fileprivate func resetTimerToZero(){
        timeSec = 0
        stopTimer()
    }
    
    // DISPLAY TIMER
    @objc fileprivate func timerTick(){
        timeSec += 1
        
        if timeSec == 60{
            timeSec = 0
        }
        let timeNow = String(format: "00:%02d", timeSec)
        lblTimer.text = timeNow
        if timeSec >= 10 {
            finishRecording(success: true)
        }
    }
    
    
    // STOP RECORDING
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
            lblAudioFileName.text = "Recorded Successfuly"
            btnVoiceRecord.isUserInteractionEnabled = false
            lblTimer.isHidden = true
            btnVoiceRecord .setImage(UIImage(named:"audiorecorder"), for: .normal)
        } else {
            lblAudioFileName.text = "Recording Fail"
            // recording failed :(
        }
        stopTimer()
    }
    
    
    
    @IBAction func btnSMS_action(_ sender: Any) {
        if arrContacts?.count ?? 0 > 0 {
            
            sendMessageViaSMS(strMsg:txtLocationDetails.text ?? "", recipients:arrContacts!)
        }else{
            sendMessageViaSMS(strMsg:txtLocationDetails.text ?? "", recipients:[])
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    // START RECORDING
    func startRecording() {
        resetTimerToZero()
        lblAudioFileName.text = ""
        let audioFilename = getDocumentsDirectory().appendingPathComponent("\(fileName ?? "").m4a")
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.isMeteringEnabled = true
            audioRecorder.delegate = self
            audioRecorder.record(forDuration: 10.0)
            
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
                self?.timerTick()
                self?.btnVoiceRecord .setImage(UIImage(named: "pauseIcon"), for: .normal)
            }
            
            //recordButton.setTitle("Tap to Stop", for: .normal)
        } catch {
            finishRecording(success: false)
        }
    }
    
    
    @IBAction func btnPhotoVideoCapture_action(_ sender: Any) {
        DocumentPicker.shared.showCameraActionSheet(vc: self, name:"test\(Date.timeIntervalSinceReferenceDate)", completionBlock:{ (doc) in
            let url = self.getDocumentsDirectory()
            let path = url.appendingPathComponent(doc?.docPath ?? "")
            self.strVideoPath = doc?.docPath //path.absoluteString//
            _ = try? Data(contentsOf: path)
            self.dismiss(animated: true, completion:{
                if let image = path.generateThumbnail() {
                    self.btnphotoVideoCapture.setImage(image, for:.normal)
                }else if let image = Helper.getImageFromDocumentDir(named:path.lastPathComponent) {
                    self.btnphotoVideoCapture.setImage(image, for:.normal)
                  
                }else{
                  //  self.btnphotoVideoCapture.setImage(#imageLiteral(resourceName: "camera"), for:.normal)
                }
            })
        })
    }
    
    
    
    
  
    
}


// SEND SMS MESSAGE DELEGATE

extension ShareLocationVC : MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated:true, completion:{
            // self.dismiss(animated: true, completion: nil)
        })
    }
    
    
    @IBAction func btnWhatsApp_action(_ sender: Any) {
        if isShareLocation == true {
            self.sendWhatsdAppMessage(message:messageString ?? "")
            
        }else if isShareVoice == true {
            self.audioFileSentViaWhatsApp(isAudio: true)
        }else if isSharephoto  == true {
            if self.strVideoPath != nil {
                self.audioFileSentViaWhatsApp(isAudio: false)
            }
        }
    }
    
    
    func audioFileSentViaWhatsApp(isAudio : Bool) {
        guard let fileName = isAudio ? ("\(fileName ?? "").m4a") : self.strVideoPath else { return }
        let audioFilename = getDocumentsDirectory().appendingPathComponent(fileName)
        //Creating audioURL type of URL
        if let audioUrl = URL(string: audioFilename.absoluteString) {
            let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let destinationUrl = documentsDirectoryURL.appendingPathComponent(audioUrl.lastPathComponent)
            if FileManager.default.fileExists(atPath: destinationUrl.path) {
                self.showShareView(destinationUrl, isVideoMode: isAudio ? true : false)
            }
            else {
                self.downloadFile(audioUrl, destinationUrl)
                DispatchQueue.main.async {
                    self.showShareView(destinationUrl, isVideoMode: isAudio ? true : false)
                }
            }
        }
    }
    //MARK: - Audio and Video downloading function from web URL
    func downloadFile(_ audioURL: URL, _ destinationUrl: URL) {
        URLSession.shared.downloadTask(with: audioURL) { location, response, error in
            guard let location = location, error == nil else { return }
            do { try FileManager.default.moveItem(at: location, to: destinationUrl) }
            catch { print(error) }
        }.resume()
    }
    //MARK: - Sharing view showing function
    func showShareView(_ destinationUrl: URL, isVideoMode : Bool) {
        if let aString = URL(string: "whatsapp://app") {
            if UIApplication.shared.canOpenURL(aString) {
                print("url:",destinationUrl)
                self.documentationInteractionController = UIDocumentInteractionController(url: destinationUrl)
               self.documentationInteractionController?.uti = isVideoMode ? "public.movie" : "public.audio"
            //    self.documentationInteractionController?.uti =  "net.whatsapp.image"//isVideoMode ? "net.whatsapp.movie" : "net.whatsapp.audio"
                self.documentationInteractionController?.delegate = self
                self.documentationInteractionController?.presentOpenInMenu(from: CGRect(x: 0, y: 0, width: 0, height: 0), in: self.view, animated: true)
               
            }else {
                showAlert()
            }
            
        }else{
            showAlert()
        }
        
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Error", message: "SHARE_TRIP_WHATS_APP_NOT_INSTALLED".LocalizedString, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("ok".LocalizedString, comment: "Default action"), style: .default, handler: { _ in
            if let url = NSURL(string:"https://apps.apple.com/in/app/whatsapp-messenger/id310633997"){
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url as URL)
                }
                
                
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    func sendWhatsdAppMessage(message:String) {
        let urlWhats = "whatsapp://send?text=\(message)"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = NSURL(string: urlString) {
                
                if UIApplication.shared.canOpenURL(whatsappURL as URL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL as URL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL as URL)
                    }
                }
                else {
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
extension ShareLocationVC:UIDocumentInteractionControllerDelegate{
    func documentInteractionController(_ controller: UIDocumentInteractionController, didEndSendingToApplication application: String?) {
        self.dismiss(animated:true, completion:nil)
    }
    
    func documentInteractionControllerDidDismissOpenInMenu(_ controller: UIDocumentInteractionController) {
        self.dismiss(animated:true, completion:nil)
    }
}

extension ShareLocationVC : AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
    
    // Voice Recorder Tapped
    @IBAction func btnAudioCapture_action(_ sender: Any) {
        recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if audioRecorder == nil {
                        //voice recording started
                        startRecording()
                    } else {
                        // stop Voice Recording
                        finishRecording(success: true)
                    }
                }
            }
        } catch {
            // failed to record!
        }
        
    }
     func shareImageViaWhatsapp(image: UIImage, onView: UIView) {
            let urlWhats = "whatsapp://app"
            if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed) {
                if let whatsappURL = URL(string: urlString) {
                    
                    if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                        
                        guard let imageData = image.pngData() else { debugPrint("Cannot convert image to data!"); return }
                        
                        let tempFile = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Documents/whatsAppTmp.wai")
                        do {
                            try imageData.write(to: tempFile, options: .atomic)
                            self.documentInteractionController = UIDocumentInteractionController(url: tempFile)
                            self.documentInteractionController.uti = "net.whatsapp.image"
                            self.documentInteractionController.presentOpenInMenu(from: CGRect.zero, in: onView, animated: true)
                            
                        } catch {
//                            self.callAlertView(title: NSLocalizedString("information", comment: ""),
//                                               message: "There was an error while processing, please contact our support team.",
//                                               buttonText: "Close", fromViewController: topViewController!)
//                            return
                        }
                        
                    } else {
//                        self.callAlertView(title: NSLocalizedString("warning", comment: ""),
//                                           message: "Cannot open Whatsapp, be sure Whatsapp is installed on your device.",
//                                           buttonText: "Close", fromViewController: topViewController!)
                    }
                }
            }
        }
    
    
}
