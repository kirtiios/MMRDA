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
    
    func showAlertViewWithMessage(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertViewWithMessageCancelAndActionHandler(_ title: String, message: String, actionHandler:(() -> Void)?) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            let alAction = UIAlertAction(title: "Ok".LocalizedString, style: .default) { (action) in
                action.setValue(UIColor.black, forKey: "titleTextColor")
                if let _ = actionHandler {
                    actionHandler!()
                }
            }
            let alAction1 = UIAlertAction(title: "cancel".LocalizedString, style: .default) { (action) in
                
            }
            
            alAction.setValue(UIColor.black, forKey: "titleTextColor")
            alAction1.setValue(UIColor.black, forKey: "titleTextColor")
            alertController.addAction(alAction)
            alertController.addAction(alAction1)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    // MARK: - call all bar Button
    func callBarButtonForHome(leftBarLabelName : String,isDisplayAppIcon:Bool = false,isShowTitleImage:Bool = false, isHomeScreen : Bool,isBack:Bool = true,isPresent:Bool = false,isDisplaySOS:Bool = true,isDisPlayLanguage:Bool = false) {
        self.navigationController?.navigationBar.backgroundColor = Colors.navigationBarBackgroundColor.value
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
                
                // FOR DISMISS CONTROLER
                if isPresent == true {
                    self.navigationItem.leftBarButtonItems = [self.barBackButton(imageName: "Back", isSideMenu: false, buttonTitle: leftBarLabelName, isLogin: navBackButtonSelection.dissmissPresent.rawValue, isBack:isBack)] // setUp Left back Button
                }else{
                    self.navigationItem.leftBarButtonItems = [self.barBackButton(imageName: "Back", isSideMenu: false, buttonTitle: leftBarLabelName, isLogin: navBackButtonSelection.backRootOnly.rawValue, isBack:isBack)] // setUp Left back Button
                }
                
            }
        }
        
        
        
        var arrButtons = [UIBarButtonItem]()
        if isDisplaySOS == true {
            let rightButton = barButton(imageName:"SOS", selector:#selector(barButtonAction))
            arrButtons.append(rightButton)
            self.navigationItem.rightBarButtonItems = [rightButton]
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
        button.addTarget(self, action: selector, for: .touchUpInside)
        return UIBarButtonItem(customView: button)
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
    
    // MARK: - barBack BarButton
    func barBackButton(imageName : String, isSideMenu : Bool,isShowAppIcon:Bool = false,isShowTitleImage:Bool = false,buttonTitle : String, isLogin : Int,isBack:Bool) -> UIBarButtonItem {
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 40))
        
        let btnSort = UIButton(type: .custom)
        btnSort.frame =  CGRect(x: 0, y: 0, width: 40 , height: myView.frame.size.height)
        btnSort.setImage(UIImage(named : imageName), for: .normal)
        
        let appIcon = UIButton(type: .custom)
        appIcon.frame =  CGRect(x:0, y: 0, width:40, height:40)
        //        appIcon.layer.cornerRadius =  appIcon.frame.size.width/2
        //        appIcon.clipsToBounds = true
        appIcon.setImage(UIImage(named :"BMTC_icon"), for: .normal)
        
        if buttonTitle == ""{
            appIcon.imageView?.tintColor = Colors.navigationBarBackgroundColor.value
        }else{
            appIcon.imageView?.tintColor = .white
        }
        appIcon.imageView?.backgroundColor = UIColor.white
        appIcon.imageEdgeInsets = UIEdgeInsets(top:0,left:0,bottom: 0,right: 0)
        appIcon.cornerRadius =  appIcon.frame.size.width/2
        appIcon.clipsToBounds = true
        
        
       
        if isShowTitleImage == true {
            let logo = UIImage(named: "MMRDATopLogo")
            let imageView = UIImageView(frame: CGRect(x: 40, y: 0, width: myView.frame.size.width - 100, height: myView.frame.size.height))
            imageView.image = logo
            imageView.contentMode = .left
            myView.addSubview(imageView)
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
//        if isShowAppIcon == true {
//            appIcon.addTarget(self, action:#selector(movetoAppWebsite), for: .touchUpInside)
//            myView.addSubview(appIcon)
//        }
        
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


