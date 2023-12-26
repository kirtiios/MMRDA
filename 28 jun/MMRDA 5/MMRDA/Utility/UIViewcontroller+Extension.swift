//
//  UIAlertView+Extension.swift
//  MMRDA
//
//  Created by Sandip Patel on 18/08/22.
//

import Foundation
import UIKit
import CommonCrypto




extension UIViewController {
    
    enum navBackButtonSelection: Int {
        case sideMenu, backWithoutRoot, backWithRoot,backRootOnly, dissmissPresent, backWithoutSideMenu, backSelectedView
    }
    @objc func gotoHome(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    @objc func gotoBack(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func gotoSetting(){
        self.navigationController?.popViewController(animated: true)
    }
    func setRightHomeButton(){
        
        let barButton = UIBarButtonItem(image: UIImage(named:"Home"), style:.plain, target: self, action: #selector(gotoHome))
        barButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = barButton
    }
    func setBackButton(){
        
        let barButton = UIBarButtonItem(image: UIImage(named:"back"), style:.plain, target: self, action: #selector(gotoBack))
        barButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = barButton
    }
    func SettingRightButton(){
        
        let barButton = UIBarButtonItem(image: UIImage(named:"Setting"), style:.plain, target: self, action: #selector(gotoSetting))
        barButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    
    
    func setRightBackButton(){
        
        let barButton = UIBarButtonItem(image: UIImage(named:"back"), style:.plain, target: self, action: #selector(gotoBack))
        barButton.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = barButton
    }
    func randomString(_ length: Int) -> String {

        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)

        var randomString = ""

        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }

        return randomString
    }
    func showAlertViewWithMessage(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "ok".localized(), style: .default, handler: nil)
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertViewWithMessageCancelAndActionHandler(_ title: String, message: String, actionHandler:(() -> Void)?) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            let alAction = UIAlertAction(title: "yes".LocalizedString, style: .default) { (action) in
                action.setValue(UIColor.black, forKey: "titleTextColor")
                if let _ = actionHandler {
                    actionHandler!()
                }
            }
            let alAction1 = UIAlertAction(title: "no".LocalizedString, style: .default) { (action) in
                
            }
           
            alAction.setValue(UIColor.black, forKey: "titleTextColor")
            alAction1.setValue(UIColor.black, forKey: "titleTextColor")
            alertController.addAction(alAction1)
            alertController.addAction(alAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    func showAlertViewWithMessageAndActionHandler(_ title: String, message: String, actionHandler:(() -> Void)?) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            let alAction = UIAlertAction(title: "ok".LocalizedString, style: .default) { (action) in
                action.setValue(UIColor.black, forKey: "titleTextColor")
                if let _ = actionHandler {
                    actionHandler!()
                }
            }
            alAction.setValue(UIColor.black, forKey: "titleTextColor")
            alertController.addAction(alAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    // MARK: - call all bar Button
    func callBarButtonForHome(isloggedIn:Bool = false,leftBarLabelName : String,isDisplayAppIcon:Bool = false,isShowTitleImage:Bool = false, isHomeScreen : Bool,isBack:Bool = true,isPresent:Bool = false,isDisplaySOS:Bool = true,isDisPlayLanguage:Bool = false,isDisplayHome:Bool = false) {
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        if isBack == false {
            self.navigationItem.leftBarButtonItems = [self.barBackButton(imageName:"", isSideMenu: false, buttonTitle: leftBarLabelName, isLogin: navBackButtonSelection.backRootOnly.rawValue, isBack:isBack)]
            
        }else {
            if isHomeScreen == true {
                
                if isDisplayAppIcon == true {
                    self.navigationItem.leftBarButtonItems = [self.barBackButton(imageName: "SideMenu", isSideMenu: true,isShowAppIcon:true,isShowTitleImage: isShowTitleImage, buttonTitle: leftBarLabelName, isLogin: navBackButtonSelection.sideMenu.rawValue, isBack:isBack)] // setUp Left back Button
                    
                }else{
                    self.navigationItem.leftBarButtonItems = [self.barBackButton(imageName: "SideMenu", isSideMenu: true, isShowTitleImage: isShowTitleImage, buttonTitle: leftBarLabelName, isLogin: navBackButtonSelection.sideMenu.rawValue, isBack:isBack)] // setUp Left back Button
                }
                
            }else {
                
                if isloggedIn == true {
                    // FOR DISMISS CONTROLER
                    if isPresent == true {
                        self.navigationItem.leftBarButtonItems = [self.barBackButton(imageName: "back", isSideMenu: false, buttonTitle: leftBarLabelName, isLogin: navBackButtonSelection.dissmissPresent.rawValue, isBack:isBack)] // setUp Left back Button
                    }else{
                        self.navigationItem.leftBarButtonItems = [self.barBackButton(imageName: "back", isSideMenu: false, buttonTitle: leftBarLabelName, isLogin: navBackButtonSelection.backRootOnly.rawValue, isBack:isBack)] // setUp Left back Button
                    }
                }else{
                    // FOR DISMISS CONTROLER
                    if isPresent == true {
                        self.navigationItem.leftBarButtonItems = [self.barBackButton(imageName: "Back", isSideMenu: false, buttonTitle: leftBarLabelName, isLogin: navBackButtonSelection.dissmissPresent.rawValue, isBack:isBack)] // setUp Left back Button
                    }else{
                        self.navigationItem.leftBarButtonItems = [self.barBackButton(imageName: "Back", isSideMenu: false, buttonTitle: leftBarLabelName, isLogin: navBackButtonSelection.backRootOnly.rawValue, isBack:isBack)] // setUp Left back Button
                    }
                }
                
                
            }
        }
        
        
        
        var arrButtons = [UIBarButtonItem]()
        if isDisplaySOS == true {
            let rightButton = barButton(imageName:"SOS", selector:#selector(barButtonAction))
            arrButtons.append(rightButton)
        }
        if isDisplayHome == true {
            let rightButton = barButton(imageName:"Home", selector:#selector(barButtonHomeAction))
            arrButtons.append(rightButton)
        }
//        if isDisPlayLanguage == true {
//            let rightButton = barButton(imageName:"Language", selector:#selector(barButtonRightAction))
//            arrButtons.append(rightButton)
//        }
        self.navigationItem.rightBarButtonItems = arrButtons
    }
    
    func barButton(imageName: String, selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        
        if imageName == "SOS" {
            let jeremyGif = UIImage(named: "SOS")
            button.setImage(jeremyGif, for: .normal)
        }else{
            button.setImage(UIImage(named: imageName), for: .normal)
        }
        button.backgroundColor = .clear
        button.frame = CGRect(x: 0, y: 0, width:70, height: 40)
        button.widthAnchor.constraint(equalToConstant: 70).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.addTarget(self, action: #selector(openSOSVC), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }
    
    
    
    @objc func openSOSVC() {
        
        let alertController = UIAlertController(title: "tv_sos_alert_title".localized(), message: "tv_sos_alert".localized(), preferredStyle: .alert)
        let alAction = UIAlertAction(title: "cancel".LocalizedString.uppercased(), style: .default) { (action) in
            
            
        }
        let alAction1 = UIAlertAction(title: "tv_continue".LocalizedString.uppercased(), style: .default) { (action) in
            let vc = UIStoryboard.SOSVC()
            self.navigationController?.pushViewController(vc!, animated:true)
        }
        alertController.addAction(alAction)
        alertController.addAction(alAction1)
        self.present(alertController, animated: true, completion: nil)
        
     
       
    }
    
    func barButton2(imageName: String, selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.backgroundColor = .clear
        button.frame = CGRect(x:100, y: 0, width:40, height: 35)
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 35).isActive = true
        button.addTarget(self, action: selector, for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }
    
    @objc func barButtonAction() {
//        if UserDefaults.standard.isLoggedIn() == true {
//            self.gotoSOS()
//
//        }else{
//            self.showAlertViewWithOkButtonActionHandler("APPTITLE".LocalizedString, message: "txtLoginVC".LocalizedString, actionHandler: {
//                let login = UIStoryboard.LoginVC()
//                self.navigationController?.pushViewController(login!, animated:true)
//            })
//        }
    }
    @objc func barButtonHomeAction() {
//        if UserDefaults.standard.isLoggedIn() == true {
//            self.gotoSOS()
//
//        }else{
//            self.showAlertViewWithOkButtonActionHandler("APPTITLE".LocalizedString, message: "txtLoginVC".LocalizedString, actionHandler: {
//                let login = UIStoryboard.LoginVC()
//                self.navigationController?.pushViewController(login!, animated:true)
//            })
//        }
    }
    
    // MARK: - barBack BarButton
    func barBackButton(imageName : String, isSideMenu : Bool,isShowAppIcon:Bool = false,isShowTitleImage:Bool = false,buttonTitle : String, isLogin : Int,isBack:Bool) -> UIBarButtonItem {
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 40))
        
        let btnSort = UIButton(type: .custom)
        btnSort.frame =  CGRect(x: 0, y: 0, width: 40 , height: myView.frame.size.height)
        btnSort.setImage(UIImage(named : imageName), for: .normal)
        
      
        
        
       
        if isShowTitleImage == true {
            let logo = UIImage(named: "MMRDATopLogo")
            let imageView =  UIImageView() 
            imageView.image = logo
            imageView.contentMode = .scaleAspectFit
            myView.addSubview(imageView)
            let stackView1 = UIStackView(frame: CGRect(x: 40, y: 0, width: myView.frame.size.width - 140, height:  myView.frame.size.height))
            stackView1.alignment = .center
            stackView1.distribution = .fillEqually
            stackView1.axis = .horizontal
            stackView1.spacing = 5
            stackView1.addArrangedSubview(imageView)
            
          
            let imageView1 = UIImageView()
            imageView1.image = UIImage(named: "Mumbaiicon")
            imageView1.contentMode = .scaleAspectFit
            stackView1.addArrangedSubview(imageView1)
            myView.addSubview(stackView1)
            
            
            
        }else{
            let myFirstLabel = UILabel()
            myFirstLabel.textColor = UIColor.white
            myFirstLabel.text = buttonTitle
            myFirstLabel.numberOfLines = 1
            myFirstLabel.lineBreakMode = .byTruncatingTail
            myFirstLabel.textAlignment = .center
            myFirstLabel.numberOfLines = 1
            myFirstLabel.frame = CGRect(x: 30 , y: 0, width: myView.frame.size.width - 100, height: myView.frame.size.height)
            myFirstLabel.backgroundColor = .clear
            
            myView.addSubview(myFirstLabel)
        }
        
        
       
        
        
        
        myView.addSubview(btnSort)

        
        if isSideMenu == true {
            if isBack == true {
                btnSort.addTarget(self, action:#selector(sideMenuButtonAction), for: .touchUpInside)
            }
            
        }else {
            if isBack == true {
                if isLogin == navBackButtonSelection.backWithoutRoot.rawValue {
                    btnSort.addTarget(self, action:#selector(barBackButtonAction), for: .touchUpInside)
                }else if isLogin == navBackButtonSelection.backWithRoot.rawValue{
                    btnSort.addTarget(self, action:#selector(barBackRootVcButtonAction), for: .touchUpInside)
                }else if isLogin == navBackButtonSelection.dissmissPresent.rawValue{
                    btnSort.addTarget(self, action:#selector(dismissPresentVcButtonAction), for: .touchUpInside)
                }else if isLogin == navBackButtonSelection.backSelectedView.rawValue{
//                    btnSort.addTarget(self, action:#selector(barBackWithSelectedViewButtonAction), for: .touchUpInside)
                }else if isLogin == navBackButtonSelection.backRootOnly.rawValue {
                    btnSort.addTarget(self, action:#selector(navtoRootOnlyButtonAction), for: .touchUpInside)
                }else {
                    btnSort.addTarget(self, action:#selector(barBackWithOutSideMenuButtonAction), for: .touchUpInside)
                }
            }else {
                btnSort.addTarget(self, action:#selector(discardCurrentPropertyData), for: .touchUpInside)
            }
            
        }
        return UIBarButtonItem(customView: myView)
    }
    
    
    @objc func barBackRootVcButtonAction() {
        self.navigationController?.popToRootViewController(animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            APPDELEGATE.topViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    //This method will call when you press barBack button.
    @objc func barBackButtonAction() {
        self.navigationController?.popViewController(animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            APPDELEGATE.topViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    //This method will call when you press barBack button.
    @objc func barBackWithOutSideMenuButtonAction() {
        self.navigationController?.popViewController(animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            APPDELEGATE.topViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func sideMenuButtonAction() {
        APPDELEGATE.mainVC.openLeft(animated: true)
    }
    
    
    //This method will call when you press barBack button.
    @objc func dismissPresentVcButtonAction() {
        APPDELEGATE.topViewController?.dismiss(animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            APPDELEGATE.topViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    //This method will call when you press barBack button.
    @objc func navtoRootOnlyButtonAction() {
        self.navigationController?.popViewController(animated: true)
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        //            APPDELEGATE.topViewController?.dismiss(animated: true, completion: nil)
        //
    }
    
    @objc func discardCurrentPropertyData() {
        
    }
    
    
    
}
extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
  }
}
extension UIImage {
    
    public class func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("image doesn't exist")
            return nil
        }
        
        return UIImage.animatedImageWithSource(source)
    }
    
    public class func gifImageWithURL(_ gifUrl:String) -> UIImage? {
        guard let bundleURL = URL(string: gifUrl)
            else {
                print("image named \"\(gifUrl)\" doesn't exist")
                return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("image named \"\(gifUrl)\" into NSData")
            return nil
        }
        
        return gifImageWithData(imageData)
    }
    
    public class func gifImageWithName(_ name: String) -> UIImage? {
        guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "gif") else {
                print("SwiftGif: This image named \"\(name)\" does not exist")
                return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        
        return gifImageWithData(imageData)
    }
    
    class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties: CFDictionary = unsafeBitCast(
            CFDictionaryGetValue(cfProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()),
            to: CFDictionary.self)
        
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        
        delay = delayObject as! Double
        
        if delay < 0.1 {
            delay = 0.1
        }
        
        return delay
    }
    
    class func gcdForPair(_ a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }
        
        if a ?? 0 < b  ?? 0{
            let c = a
            a = b
            b = c
        }
        
        var rest: Int
        while true {
            rest = a! % b!
            
            if rest == 0 {
                return b!
            } else {
                a = b
                b = rest
            }
        }
    }
    
    class func gcdForArray(_ array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }
        
        var gcd = array[0]
        
        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }
        
        return gcd
    }
    
    class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        
        for i in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }
            
            let delaySeconds = UIImage.delayForImageAtIndex(Int(i),
                source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
        
        let duration: Int = {
            var sum = 0
            
            for val: Int in delays {
                sum += val
            }
            
            return sum
        }()
        
        let gcd = gcdForArray(delays)
        var frames = [UIImage]()
        
        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)
            
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
        let animation = UIImage.animatedImage(with: frames,
            duration: Double(duration) / 1000.0)
        
        return animation
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    
}



class gifmageView:UIImageView {
    
    override func draw(_ rect: CGRect) {
    }
           
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let jeremyGif = UIImage.gifImageWithName("BMTC_1")
        self.image = jeremyGif
    }
}
//extension UINavigationController {
//  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
//    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
//      popToViewController(vc, animated: animated)
//    }
//  }
//}
