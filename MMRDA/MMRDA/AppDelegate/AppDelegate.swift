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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        appSettings()
        GMSServices.provideAPIKey(googleAPIKey)
        self.setupViewController()
        return true
    }

//    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }


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
