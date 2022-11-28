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
import Firebase


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    var mainVC = FAPanelController() // for side menu object declare
    var window: UIWindow?
    var isFromLogin = false
    var FCM_TOKEN = ""
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        appSettings()
        navigaitonbarColor()
        GMSServices.provideAPIKey(googleAPIKey)
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
        Thread.sleep(forTimeInterval: 1)

//        Messaging.messaging().isAutoInitEnabled = true
        registerForRemoteNotification()
        self.setupViewController()
        
        return true
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UIApplication.shared.applicationIconBadgeNumber = 0
    }



}



extension AppDelegate {
    // MARK: - Configure IQKeyboardManager
    fileprivate func enableInputAccessoryView() {
        IQKeyboardManager.shared.enable = true // Enable Auto Keyboard Manager
        IQKeyboardManager.shared.toolbarTintColor = UIColor.black
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "done".LocalizedString
        
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
extension AppDelegate:MessagingDelegate {
  
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        FCM_TOKEN = fcmToken ?? ""
        print("fcm:",FCM_TOKEN)
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingDelegate) {
        print("Received data message: \(remoteMessage.description)")
    }

    func registerForRemoteNotification() {
        
        let center  = UNUserNotificationCenter.current()
        center.requestAuthorization(options:[.sound, .alert, .badge]) { (granted, error) in
            if error == nil {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
        center.delegate = self
        
    }
}

extension AppDelegate:UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                               willPresent notification: UNNotification,
                               withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound,.alert])
        
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                        didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        DispatchQueue.main.asyncAfter(deadline:.now() + 0.5) {
            NotificationCenter.default.post(name:Notification.notificationClicked, object:nil, userInfo: nil)
        }
        // Print full message.
        print(userInfo)
        completionHandler()
    }
    
}
