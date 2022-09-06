//
//  DocumentPicker.swift
//  CropTrack
//
//  Created by hardik.darji on 27/01/2020.
//  Copyright © 2019 LearnExample. All rights reserved.


import MobileCoreServices
import UIKit
import AVFoundation

let videoMaxDuration: TimeInterval = 6
enum MediaType: Int
{
    case photo, video, document
}
class DocumentPicker: NSObject{
    
    class var shared : DocumentPicker {
        struct Static {
            static let instance : DocumentPicker = DocumentPicker()
        }
        return Static.instance
    }
    

    //MARK: Internal Properties
    typealias DocumentPickedBlock = ((UIImage?) -> Void)

    var documentPickedBlock: DocumentPickedBlock?
    var imagePicker: UIImagePickerController?
    var captureType: MediaType = .photo
    var parentVC: UIViewController?
    private func openCamera(parentVC: UIViewController)
    {
        self.parentVC = parentVC
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            DispatchQueue.main.async { // Make sure you're on the main thread here
                
                if self.imagePicker == nil
                {
                    self.imagePicker = UIImagePickerController()
                }
                
                if let picker = self.imagePicker
                {
                    picker.delegate = self
                    picker.sourceType = .camera
                    
                    //SHOW CAMERA OVERLAY FOR CHOOSE PHOTO FROM GALLERY
//                    let buttonGallery = RoundedActionButton(frame: CGRect(x: 12, y: SCREEN_HEIGHT - (hasTopNotch ? 194 : 150), width: 40, height: 40))
//                    buttonGallery.setImage(#imageLiteral(resourceName: "ic_gallery"), for: .normal)
//                    buttonGallery.addTarget(self, action: #selector(self.galleryactionTouched), for: .touchUpInside)
//                    picker.cameraOverlayView = buttonGallery
                    
                    if self.captureType == .video
                    {
                        picker.mediaTypes = [kUTTypeMovie as String]
                        picker.videoMaximumDuration = videoMaxDuration
                        picker.allowsEditing = true
                    }
                    
                    parentVC.present(picker, animated: true, completion: nil)
                }
            }
        }
    }
    
    //WHEN GALLERY BUTTON TOUCHED..
    @objc private func galleryactionTouched(_ sender: UIButton)
    {
        if let vc = self.parentVC{
            vc.dismiss(animated: true, completion: nil)
            self.openPhotoLibrary(parentVC: vc)
        }
    }
    func openPhotoLibrary(parentVC: UIViewController)
    {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            if imagePicker == nil
            {
                imagePicker = UIImagePickerController()
            }
            
            if let picker = self.imagePicker
            {
                if self.captureType == .video
                {
                    picker.mediaTypes = [kUTTypeMovie as String]
                    picker.videoMaximumDuration = videoMaxDuration
                    picker.allowsEditing = true
                }
                
                picker.delegate = self
                picker.sourceType = .photoLibrary
                parentVC.present(picker, animated: true, completion: nil)
            }
        }
    }
    
    func alertCameraAccessNeeded() {
        let settingsAppURL = URL(string: UIApplication.openSettingsURLString)!
        
        let alert = UIAlertController(
            title: "CameraAccessRequiredMsg",
            message: "",
            preferredStyle: UIAlertController.Style.alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Allow", style: .cancel, handler: { (alert) -> Void in
            UIApplication.shared.open(settingsAppURL, options: [:], completionHandler: nil)
        }))

        // show the alert
        
        if let vc = APPDELEGATE.topViewController
        {
            DispatchQueue.main.async {
                vc.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    //TO GET DOC FROM FILE
    func openDocumentPicker(vc: UIViewController, captureType: MediaType = .document ,  completionBlock: ((UIImage?) -> Void)?) {
        self.captureType = captureType
        
        let types: [String] = ["com.microsoft.word.doc","org.openxmlformats.wordprocessingml.document", kUTTypePDF as String]
        let documentPicker = UIDocumentPickerViewController(documentTypes: types, in: .import)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        vc.present(documentPicker, animated: true, completion: nil)
        
        // COMPLETION BLOCK
        self.documentPickedBlock = { doc in
            completionBlock!(doc)
        }
    }
    // IMPLEMENTED AS PER REQUIREMENT ... NO NEED TO GET IMAGE/VIDEO FROM LIBRARY..
    func openCameraModeDirectly(vc: UIViewController, captureType: MediaType = .photo ,  completionBlock: ((UIImage?) -> Void)?) {
        self.captureType = captureType
        
        // OPEN CAMERA FOR  CAPTURE PHOTO/VIDEO BY ASK USER PERMISSION FIRST...
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            //already authorized
            self.openCamera(parentVC: vc)
        }
        else
        {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                if granted {
                    //access allowed
                    self.openCamera(parentVC: vc)
                } else {
                    //access denied
                    self.alertCameraAccessNeeded()
                }
            })
        }
        
        // COMPLETION BLOCK
        self.documentPickedBlock = { doc in
            completionBlock!(doc)
        }
    }
    /// Show option to Capture photo or get from Gallary,
    /// default Medea type = Photo
    func showActionSheet(vc: UIViewController, captureType: MediaType = .photo ,  completionBlock: ((UIImage?) -> Void)?) {
        self.captureType = captureType
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
                //already authorized
                self.openCamera(parentVC: vc)
            }
            else
            {
                AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                    if granted {
                        //access allowed
                        self.openCamera(parentVC: vc)
                    } else {
                        //access denied
                        self.alertCameraAccessNeeded()
                    }
                })
            }
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.openPhotoLibrary(parentVC: vc)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        vc.present(actionSheet, animated: true, completion: nil)
        
        self.documentPickedBlock = { doc in
            completionBlock!(doc)
        }
    }
    
}

extension DocumentPicker: UIDocumentPickerDelegate
{
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let strURL = urls.first else {
            return
        }
        print("import result : \(strURL)")
        
        //
        if let docPiked = self.documentPickedBlock
        {
//            let objDoc = docsModel(docPath: strURL.absoluteString, docType: .document)
//            docPiked(objDoc)
        }
    }
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("Canceled")
        if let docPiked = self.documentPickedBlock
        {
            docPiked(nil)
        }
    }
}



extension DocumentPicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
       // currentVC.dismiss(animated: true, completion: nil)
        if let docPiked = self.documentPickedBlock
        {
            docPiked(nil)
        }
    }
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // To handle video
//        if let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? NSURL{
//            print("videourl: ", videoUrl)
//
//            //trying compression of video
//            let data = NSData(contentsOf: videoUrl as URL)!
//            print("File size : \(Double(data.length / 1048576)) mb")
//
//            if let guid = Helper.saveVideoToDocumentDir(data: data as Data)
//            {
//                if let docPiked = self.documentPickedBlock
//                {
//                    if let thumbImg = Helper.thumbnailForVideoAtURL(url: videoUrl as URL),
//                        let thumbPath = Helper.saveImageToDocumentDir(image: thumbImg)
//                    {
//                        let objDoc = docsModel(docPath: guid, docType: .video, thumbPath: thumbPath)
//                        docPiked(objDoc)
//                    }
//                }
//            }
//
//        }
         if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            if let docPiked = self.documentPickedBlock
            {
                docPiked(image)
                
//                if let data = image.jpegData(compressionQuality: 0.2)
//                {
//                    if let img = UIImage(data: data)
//                    {
//                        if let guid = Helper.saveImageToDocumentDir(image: img)
//                        {
//                            let objDoc = docsModel(docPath: guid)
//                            docPiked(objDoc)
//                        }
//                    }
//                 }
             }
        }else{
            print("Something went wrong")
        }
    }
}
