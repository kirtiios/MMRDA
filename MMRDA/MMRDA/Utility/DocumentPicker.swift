//
//  DocumentPicker.swift
//  BMTC
//
//  Created by khushbu on 01/06/21.
//
import MobileCoreServices
import UIKit
import AVFoundation


struct docsModel
{
    var url: String?
    var docPath: String?
    var docType: MediaType?
    var thumbPath: String?
    var attributeType: String?

    init(url: String = "",
         docPath: String = "",
         docType: MediaType = .photo,
         thumbPath: String = "",
         attributeType: String = ""
         )
    {
        
        self.url = url
        self.docPath = docPath
        self.docType = docType
        self.thumbPath = thumbPath
        self.attributeType = attributeType
    }
}

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
    typealias DocumentPickedBlock = ((docsModel?) -> Void)?
    typealias DocumentPickedBlockCaustom = ((UIImage) -> Void)?

    var documentPickedBlock: DocumentPickedBlock?
    var documentPickedBlockCaustom: DocumentPickedBlockCaustom?
    var imagePicker: UIImagePickerController?
    var captureType: MediaType = .photo
    var parentVC: UIViewController?
    var fileName:String?
    func openCamera(parentVC: UIViewController,fileName:String,type:MediaType)
    {
        self.captureType = type
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            self.fileName = fileName
            DispatchQueue.main.async { // Make sure you're on the main thread here
                
                if self.imagePicker == nil
                {
                    self.imagePicker = UIImagePickerController()
                }
                
                if let picker = self.imagePicker
                {
                    picker.delegate = self
                    picker.sourceType = .camera
                    
                    if self.captureType == .video
                    {
                        picker.mediaTypes = [kUTTypeMovie as String]
                        picker.videoMaximumDuration = 10
                        picker.showsCameraControls = true
                        picker.allowsEditing = true
                    }else{
                        picker.mediaTypes = [kUTTypeImage as String]
                        picker.showsCameraControls = true
                        picker.allowsEditing = true
                    }
                    
                    parentVC.present(picker, animated: true, completion: nil)
                }
            }
        }
    }
    
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
                        picker.videoMaximumDuration = 10
                        picker.allowsEditing = true
                    }
                    
                    parentVC.present(picker, animated: true, completion: nil)
                }
            }
        }
    }
    
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
        
        self.documentPickedBlockCaustom = { doc in
            completionBlock!(doc)
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
                    picker.videoMaximumDuration = 10
                    picker.allowsEditing = true
                }
                
                picker.delegate = self
                picker.sourceType = .photoLibrary
                parentVC.present(picker, animated: true, completion: nil)
            }
        }
    }
    
    func openPhotoLibrary(parentVC: UIViewController,name:String,type:MediaType)
    {
        self.captureType = type
        
        self.fileName = name
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
                    picker.videoMaximumDuration = 10
                       
                }
                picker.allowsEditing = true
                picker.delegate = self
                picker.sourceType = .photoLibrary
                parentVC.present(picker, animated: true, completion: nil)
            }
        }
    }
    
    func alertCameraAccessNeeded() {
        let settingsAppURL = URL(string: UIApplication.openSettingsURLString)!
        
        let alert = UIAlertController(
            title: "CameraAccessRequiredMsg".LocalizedString,
            message: "",
            preferredStyle: UIAlertController.Style.alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Allow", style: .cancel, handler: { (alert) -> Void in
            UIApplication.shared.open(settingsAppURL, options: [:], completionHandler: nil)
        }))

        // show the alert
        
        if let vc = Helper.getCurrentViewController()
        {
            DispatchQueue.main.async {
                vc.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    //TO GET DOC FROM FILE
    func openDocumentPicker(vc: UIViewController, captureType: MediaType = .document ,  completionBlock: ((docsModel?) -> Void)?) {
        self.captureType = captureType
        
        let types: [String] = ["com.microsoft.word.doc","org.openxmlformats.wordprocessingml.document", kUTTypePDF as String,kUTTypeImage as String]
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
    func openCameraModeDirectly(vc: UIViewController,name:String,captureType: MediaType = .photo ,  completionBlock: ((docsModel?) -> Void)?) {
        self.captureType = captureType
        
        // OPEN CAMERA FOR  CAPTURE PHOTO/VIDEO BY ASK USER PERMISSION FIRST...
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            //already authorized
            //self.openPhotoLibrary(parentVC: vc, name:name)
            self.openCamera(parentVC: vc, fileName:name, type:captureType)
        }
        else
        {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                if granted {
                    //access allowed
                    self.openCamera(parentVC: vc, fileName:name, type: captureType)
                    
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
    
    func showActionSheet(vc: UIViewController, captureType: MediaType = .photo ,name:String,  completionBlock: ((docsModel?) -> Void)?) {
        self.captureType = captureType
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera".LocalizedString, style: .default, handler: { (alert:UIAlertAction!) -> Void in
            if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
                //already authorized
                self.openCamera(parentVC: vc, fileName: name, type: captureType)
            }
            else
            {
                AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                    if granted {
                        //access allowed
                        self.openCamera(parentVC: vc, fileName:name, type: captureType)
                    } else {
                        //access denied
                        self.alertCameraAccessNeeded()
                    }
                })
            }
            
        })
        camera.setValue(UIColor.black, forKey: "titleTextColor")
        actionSheet.addAction(camera)
        
        
        let gallery = UIAlertAction(title: "Gallery".LocalizedString, style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.openPhotoLibrary(parentVC: vc, name:name, type:captureType)
        })
        gallery.setValue(UIColor.black, forKey: "titleTextColor")

        actionSheet.addAction(gallery)
        
        camera.setValue(UIColor.black, forKey: "titleTextColor")
        let cancel = UIAlertAction(title: "txtCancel".LocalizedString, style: .cancel, handler: nil)
        cancel.setValue(UIColor.black, forKey: "titleTextColor")
        actionSheet.addAction(cancel)

        vc.present(actionSheet, animated: true, completion: nil)
        
        self.documentPickedBlock = { doc in
            completionBlock!(doc)
        }
    }
    
    func showCameraActionSheet(vc: UIViewController, captureType: MediaType = .photo ,name:String,  completionBlock: ((docsModel?) -> Void)?) {
      
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let photo = UIAlertAction(title: "Photo".LocalizedString, style: .default, handler: { (alert:UIAlertAction!) -> Void in
            if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
                //already authorized
                self.openCamera(parentVC: vc, fileName: name,type:.photo)
                //self.openPhotoLibrary(parentVC: vc, name: name, type:.photo)
            }
            else
            {
                AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                    if granted {
                        //access allowed
                        self.openCamera(parentVC: vc, fileName:name, type:.photo)
                        //self.openPhotoLibrary(parentVC: vc, name: name, type:.photo)
                    } else {
                        //access denied
                        self.alertCameraAccessNeeded()
                    }
                })
            }
            
        })
        photo.setValue(UIColor.black, forKey: "titleTextColor")
        actionSheet.addAction(photo)
        
        
        let video = UIAlertAction(title: "Video".LocalizedString, style:.default, handler: { (alert:UIAlertAction!) -> Void in
            //self.openPhotoLibrary(parentVC: vc, name:name)
            if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
                //already authorized
               // self.openPhotoLibrary(parentVC: vc, name: name, type:.video)
                self.openCamera(parentVC: vc, fileName: name,type:.video)
            }
            else
            {
                AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                    if granted {
                        //access allowed
                        self.openCamera(parentVC: vc, fileName:name, type:.video)
                       // self.openPhotoLibrary(parentVC: vc, name: name, type:.video)
                    } else {
                        //access denied
                        self.alertCameraAccessNeeded()
                    }
                })
            }
            
        })
        video.setValue(UIColor.black, forKey: "titleTextColor")
        actionSheet.addAction(video)
        let cancel = UIAlertAction(title: "Cancel".LocalizedString, style: .cancel, handler: nil)
        cancel.setValue(UIColor.black, forKey: "titleTextColor")
        actionSheet.addAction(cancel)

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
            let objDoc = docsModel(docPath: strURL.absoluteString, docType: .document)
            docPiked!(objDoc)
            do {
                let path  = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                Helper.copyItemat(source:"\(strURL.path)", destination:"\(path.path)")
            }catch {
                
            }
            
        }
    }
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("Canceled")
        if let docPiked = self.documentPickedBlock
        {
            docPiked!(nil)
        }
        
    }
}



extension DocumentPicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        currentVC.dismiss(animated: true, completion: nil)
        if let docPiked = self.documentPickedBlock
        {
            docPiked!(nil)
        }
        picker.dismiss(animated:true, completion:nil)
    
    }
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // To handle video
        if let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? NSURL{
            print("videourl: ", videoUrl)
            
            //trying compression of video
            let data = NSData(contentsOf: videoUrl as URL)!
            print("File size : \(Double(data.length / 1048576)) mb")
            
            if let guid = Helper.saveVideoToDocumentDir(data: data as Data, name: fileName ?? "test")
            {
                if let docPiked = self.documentPickedBlock
                {
                    if let thumbImg = Helper.thumbnailForVideoAtURL(url: videoUrl as URL),
                        let thumbPath = Helper.saveImageToDocumentDir(image: thumbImg,name: videoUrl.deletingPathExtension?.lastPathComponent)
                    {
                        let objDoc = docsModel(docPath: guid, docType: .video, thumbPath: thumbPath)
                        docPiked!(objDoc)
                    }
                }
            }
            
        }
        else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            if let docPiked = self.documentPickedBlock
            {
                if let guid = Helper.saveImageToDocumentDir(image: image,name: fileName)
                {
                  let objDoc = docsModel(docPath: guid)
                    docPiked!(objDoc)
                }
            }
        }else{
            print("Something went wrong")
        }
    }
    
    
    
}

