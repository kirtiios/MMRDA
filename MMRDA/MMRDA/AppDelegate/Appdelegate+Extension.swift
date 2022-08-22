//
//  Appdelegate+Extension.swift
//  MMRDA
//
//  Created by Sandip Patel on 19/08/22.
//

import Foundation
import UIKit
import FAPanels


extension AppDelegate :FAPanelStateDelegate{
    func setupViewController () {
        guard let objHome = UIStoryboard.DashboardVC() else { return }
        APPDELEGATE.openViewController(Controller: objHome)
         
    }
    public func openViewController(Controller : UIViewController) {
        self.mainVC = FAPanelController()
        let objSideViewController = UIStoryboard.SidemenuVC()
        let navigationController = UINavigationController(rootViewController: objSideViewController!)
        
        let centerNavVC = UINavigationController(rootViewController: Controller)
        let btnHome = UIImage(named: "SideMenu")
        //centerNavVC.navigationBar.tintColor = TEXT_COLOR
        
        
        Controller.navigationItem.leftBarButtonItem = UIBarButtonItem(image: btnHome, style: .plain, target: self, action:  #selector(barButtonDidTap(_:)))
        self.mainVC.leftPanelPosition = .front
        
        self.mainVC.configs.leftPanelWidth = UIScreen.main.bounds.width * 0.85
        self.mainVC.configs.centerPanelTransitionType = .crossDissolve
        self.mainVC.delegate = self
        _ = self.mainVC.center(centerNavVC).left(navigationController).right(nil)
        
        self.setUpWindow(Controller: self.mainVC)
    }
    
    @objc func barButtonDidTap(_ sender: UIBarButtonItem){
        self.mainVC.openLeft(animated: true)
    }
    
    func setUpWindow(Controller : UIViewController) {
//        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = Controller
            appDelegate.window?.makeKeyAndVisible()
            UIApplication.shared.statusBarUIView?.backgroundColor = Colors.navigationBarBackgroundColor.value
        //}
        
    }
    func leftPanelWillBecomeActive(){
      if let leftmenuVC = self.mainVC.left {
            leftmenuVC.viewWillAppear(true)
          NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RefreshLeftmenu"), object: nil, userInfo: nil)
            // `default` is now a property, not a method call
        }
    }
    
    var topViewController: UIViewController? {
        return topViewController(withRootViewController: UIWindow.key?.rootViewController)
    }
    
    func topViewController(withRootViewController rootViewController: UIViewController?) -> UIViewController? {
        if (rootViewController is UITabBarController) {
            let tabBarController1 = rootViewController as? UITabBarController
            return topViewController(withRootViewController: tabBarController1?.selectedViewController)
        } else if (rootViewController is UINavigationController) {
            let navigationController = rootViewController as? UINavigationController
            return topViewController(withRootViewController: navigationController?.visibleViewController)
        } else if rootViewController?.presentedViewController != nil {
            let presentedViewController: UIViewController? = rootViewController?.presentedViewController
            return topViewController(withRootViewController: presentedViewController)
        } else {
            return rootViewController
        }
    }
    
    

    
}



extension UIApplication {
    var statusBarUIView: UIView? {
            if #available(iOS 13.0, *) {
               let statusBar =  UIView()

                statusBar.frame = UIApplication.shared.statusBarFrame

                UIApplication.shared.keyWindow?.addSubview(statusBar)
              
                return statusBar
            } else {
                let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
                return statusBar
            }
        }
}
