//
//  LocationManager.swift
//  CropTrack
//
//  Created by Hardik Darji on 03/02/20.
//  Copyright © 2020 Hardik Darji. All rights reserved.

import CoreLocation
import Contacts
import UIKit
import GoogleMaps

class LocationManager: NSObject, CLLocationManagerDelegate
{
    let locationDistanceFilter = 100.0
    let locationDesiredAccuracy = kCLLocationAccuracyBest
    
    let locationManager = CLLocationManager()
    var checkLocationCompletion:((_ success: Bool,_ location: CLLocation?) -> Void)?
    
    var isContinuesFetchLocation: Bool = false
    private var requestLocationAuthorizationCallback: ((CLAuthorizationStatus) -> Void)?
    var currentLocation =  CLLocation()
    class var sharedInstance : LocationManager
    {
        struct Static {
            static let instance : LocationManager = LocationManager()
        }
        return Static.instance
    }
    
    func getAddressFromCurrentlLocation(completionHandler: @escaping (CLPlacemark?) -> Void ) {
        // Use the last reported location.
        if let lastLocation = self.locationManager.location {
            let geocoder = CLGeocoder()
            
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation,
                                            completionHandler: { (placemarks, error) in
                                                if error == nil {
                                                    let firstLocation = placemarks?[0]
                                                    completionHandler(firstLocation)
                                                }
                                                else {
                                                    // An error occurred during geocoding.
                                                    completionHandler(nil)
                                                }
            })
        }
        else {
            // No location was available.
            completionHandler(nil)
        }
    }
    func getAddressFromCLocation(location:CLLocation?,completionHandler: @escaping (CLPlacemark?) -> Void ) {
        // Use the last reported location.
        if let lastLocation = location {
            let geocoder = CLGeocoder()
            
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation,
                                            completionHandler: { (placemarks, error) in
                                                if error == nil {
                                                    let firstLocation = placemarks?[0]
                                                    completionHandler(firstLocation)
                                                }
                                                else {
                                                    // An error occurred during geocoding.
                                                    completionHandler(nil)
                                                }
            })
        }
        else {
            // No location was available.
            completionHandler(nil)
        }
    }
    func getaddessFromLatLong(coords: CLLocationCoordinate2D,completion: @escaping (String) -> Void){
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coords) { response , error in
            if let place = response?.firstResult() {
                let add = CurrentAddress(pickUp: place)
                completion(add.currentAddress ?? "")
            }
        }
    }
    func getCurrentLocation(isContinuesFetchRequest: Bool = false, completionHandler: @escaping ((_ success: Bool,_ location: CLLocation?) -> Void))
    {
        // For use in foreground
        locationManager.delegate = self
        
        //locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.desiredAccuracy = locationDesiredAccuracy
        locationManager.distanceFilter = locationDistanceFilter
        locationManager.activityType = .other
        
        self.checkLocationCompletion = completionHandler
        self.isContinuesFetchLocation = isContinuesFetchRequest
        
        
        let currentStatus = CLLocationManager.authorizationStatus()
        if  currentStatus == .notDetermined  {
            if #available(iOS 13.4, *) {
                self.requestLocationAuthorizationCallback = { status in
                    if status == .authorizedWhenInUse {
                      //  self.locationManager.requestAlwaysAuthorization()
                        self .startMonitoringLocation()
                    }
                }
                self .startMonitoringLocation()
               // self.locationManager.requestWhenInUseAuthorization()
            } else {
                self .startMonitoringLocation()
               // self.locationManager.requestAlwaysAuthorization()
            }
        }else if currentStatus == .denied  {
            self.locationAlertMessage()
        }else {
            self .startMonitoringLocation()
        }
        
//        if self .hasLocationPermission() {
//            self.startMonitoringLocation()
//        }else {
//            self.locationAlertMessage()
//        }
        
//
//            if CLLocationManager.locationServicesEnabled() {
//                if #available(iOS 14.0, *) {
//                    switch self.locationManager.authorizationStatus {
//                    case .notDetermined:
//                        // Request when-in-use authorization initially
//                        self.locationManager.requestWhenInUseAuthorization()
//                        break
//                    case .restricted, .denied:
//                        self.locationAlertMessage() // self.checkLocationPermission() // Check Location Permission
//                    case .authorizedAlways, .authorizedWhenInUse:
//                        self.startMonitoringLocation()
//                    @unknown default:
//                        print("Something went wrong")
//                    }
//                } else {
//                    // Fallback on earlier versions
//                }
//            } else {
//                self.locationAlertMessage()
//            }
       
       
        
//        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedWhenInUse
//        {
//            self.isAuthorizedtoGetUserLocation()
//        }
//        if CLLocationManager.locationServicesEnabled()  == false || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.denied
//        {
//           // guard let vc = APPDELEGATE.window?.rootViewController else {return}
//
////            vc.showAlertViewWithMessageAndActionHandler(<#T##String#>, message: <#T##String#>, actionHandler: <#T##(() -> Void)?#>)
////            Helper.showAlert(message: "LocationServicesDisabledMsg",
////                             parentVC: vc)
////            {_ in
////                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
////                    return
////                }
////
////                if UIApplication.shared.canOpenURL(settingsUrl)  {
////                    UIApplication.shared.open(settingsUrl, completionHandler: .none)
////                }
////            }
//            APPDELEGATE.topViewController?.showAlertViewWithMessageAndActionHandler("Location services disabled", message:"Please enable location services in settings to find out your current location.", actionHandler: {
//                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
//                    return
//                }
//                if UIApplication.shared.canOpenURL(settingsUrl) {
//                    if #available(iOS 10.0, *) {
//                        UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
//                    } else {
//                        UIApplication.shared.openURL(settingsUrl)
//                    }
//                }
//            })
//        }
//        else
//        {
//            self.startUpdateLocation()
//        }
    }
//    func locationAuthorizationStatus() -> CLAuthorizationStatus {
//        let locationManager = CLLocationManager()
//        var locationAuthorizationStatus : CLAuthorizationStatus
//        if #available(iOS 14.0, *) {
//            locationAuthorizationStatus =  locationManager.authorizationStatus
//        } else {
//            // Fallback on earlier versions
//            locationAuthorizationStatus = CLLocationManager.authorizationStatus()
//        }
//        return locationAuthorizationStatus
//    }
//    func hasLocationPermission() -> Bool {
//        var hasPermission = false
//        let manager = self.locationAuthorizationStatus()
//
//        if CLLocationManager.locationServicesEnabled() {
//            switch manager {
//            case .notDetermined, .restricted, .denied:
//                hasPermission = false
//            case .authorizedAlways, .authorizedWhenInUse:
//                hasPermission = true
//            @unknown default:
//                break
//            }
//        } else {
//            hasPermission = false
//        }
//
//        return hasPermission
//    }
    // MARK: - location failed Alert Message
    func locationAlertMessage() {
       
        APPDELEGATE.topViewController?.showAlertViewWithMessageAndActionHandler("Location services disabled", message:"Please enable location services in settings to find out your current location.", actionHandler: {
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(settingsUrl)
                }
            }
        })
        
    }
    
    func startMonitoringLocation() {
      //  if CLLocationManager.locationServicesEnabled() {
            self.locationManager.headingFilter = 1
            self.locationManager.requestWhenInUseAuthorization()
           // self.locationManager.startMonitoringSignificantLocationChanges()
            self.locationManager.startUpdatingLocation()
       // }
    }
    
    func stopMonitoringLocation() {
        self.locationManager.stopMonitoringSignificantLocationChanges()
        self.locationManager.stopUpdatingLocation()
    }
//    func startUpdateLocation()
//    {
//        if CLLocationManager.locationServicesEnabled() {
//            //SVProgressHUD.show()
//            //Helper.showLoader(true)
//            print("GET LOCATION - START")
//            locationManager.startUpdatingLocation();
//        }
//    }
    
//    func stopUpdateLocation()
//    {
//
//        locationManager.stopUpdatingLocation()
//        locationManager.delegate = nil
//    }
    //this method will be called each time when a user change his location access preference.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        
        //self.startMonitoringLocation()
        //if status == .authorizedWhenInUse {
            print("User allowed us to access location")
            //do whatever init activities here.
          //  self.startUpdateLocation()
       // }
        
        self.requestLocationAuthorizationCallback?(status)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        //SVProgressHUD.dismiss()
        //    Helper.showLoader(false)

        print(error.localizedDescription)
        if let fetchCompletion = self.checkLocationCompletion
        {
            fetchCompletion(false, nil)
        }
        
    }
    
    //if we have no permission to access user location, then ask user for permission.
//    func isAuthorizedtoGetUserLocation() {
//        // todo... //https://stackoverflow.com/questions/40951097/reevaluate-cllocationmanager-authorizationstatus-in-running-app-after-app-locati
//
//        //if CLLocationManager.authorizationStatus() != .authorizedWhenInUse     {
//            locationManager.requestWhenInUseAuthorization()
//       // }
//    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Helper.showLoader(false)
        //SVProgressHUD.dismiss()

        print("GET LOCATION - END")
        if let currentLocation = manager.location
        {
//            Assigned Ward no. :  47
//            Lat: 22.7217521786746
//            Long: 75.8773115649819
            
        print(manager.location)
           self.currentLocation = currentLocation
            
            //TODO...TEMP SETTING FOR STATIC LOCATION
            // self.currentLocation = CLLocation(latitude: 19.2307, longitude:72.8567)
            
            
           // print("locations = \(String(describing: currentLocation.coordinate.latitude)) \(String(describing: currentLocation.coordinate.longitude))")
            
            if self.isContinuesFetchLocation == false{
                self.stopMonitoringLocation()
                self.locationManager.delegate = nil
            }
            
            if let fetchCompletion = self.checkLocationCompletion{
                fetchCompletion(true, self.currentLocation)
            }
        }
    }
    
}
extension CLPlacemark {
    func getAddress() -> String {
        return [subThoroughfare, thoroughfare, locality, administrativeArea, postalCode, country]
            .compactMap({ $0 })
            .joined(separator: " ")
    }
    
    var formattedAddress: String? {
        guard let postalAddress = postalAddress else {
            return nil
        }
        let formatter = CNPostalAddressFormatter()
        return formatter.string(from: postalAddress)
    }
    
    
}
struct CurrentAddress {
    var currentAddress : String? = ""
    var currentPlaceName : String? = ""
    var currentAreaName : String? = ""
    var currentCity : String? = ""
    var currentState : String? = ""
    var currentPincode : String? = ""
    var currentCuntry : String? = ""
    var currentCoordinate : CLLocationCoordinate2D?
    
    
    init(pickUp: GMSAddress) {
        var adressString : String = ""
        
        for line in  pickUp.lines! {
            adressString += line + " "
        }
        self.currentAddress = adressString
        self.currentPlaceName = pickUp.thoroughfare ?? ""
        self.currentAreaName = pickUp.subLocality ?? ""
        self.currentCity = pickUp.locality ?? ""
        self.currentState = pickUp.administrativeArea ?? ""
        self.currentPincode = pickUp.postalCode ?? ""
        self.currentCuntry = pickUp.country ?? ""
        self.currentCoordinate = pickUp.coordinate
        
    }
}
