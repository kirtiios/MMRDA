//
//  AppDelegate.swift
//  MMRDA
//
//  Created by Sandip Patel on 17/08/22.
//

import UIKit
import IQKeyboardManagerSwift
import FAPanels
import GoogleMaps
import CoreLocation


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var mainVC = FAPanelController() // for side menu object declare
    var window: UIWindow?
    var isFromLogin = false
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        appSettings()
        navigaitonbarColor()
        GMSServices.provideAPIKey(googleAPIKey)
        self.setupViewController()
        return true
    }




}



extension AppDelegate {
    // MARK: - Configure IQKeyboardManager
        fileprivate func enableInputAccessoryView() {
            IQKeyboardManager.shared.enable = true // Enable Auto Keyboard Manager
            IQKeyboardManager.shared.toolbarTintColor = UIColor.black
            //        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true
        }
        
    func appSettings() {
        self.enableInputAccessoryView()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().isTranslucent = true
    }
    
        
}

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
