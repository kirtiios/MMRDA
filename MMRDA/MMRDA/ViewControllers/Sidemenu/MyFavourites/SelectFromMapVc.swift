//
//  SelectFromMapVc.swift
//  MMRDA
//
//  Created by Sandip Patel on 30/08/22.
//

import UIKit
import GoogleMaps
import CoreLocation

class SelectFromMapVc: BaseVC {
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var lblLocatioName: UILabel!
    
    @IBOutlet weak var infoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"myfavourites".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        LocationManager.sharedInstance.getCurrentLocation { success, location in
            if success {
                let camera = GMSCameraPosition.camera(withLatitude:LocationManager.sharedInstance.currentLocation.coordinate.latitude, longitude: LocationManager.sharedInstance.currentLocation.coordinate.longitude, zoom: 15)
                
                LocationManager.sharedInstance.getAddressFromCLocation(location: location) { placeMark in
                    if let placeMark = placeMark {
                        self.lblLocatioName.text = placeMark.getAddress()
                    }
                }
                self.mapView.camera = camera
            }
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionInfo(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            self.setView(view: infoView, hidden:false)
        }else{
            self.setView(view: infoView, hidden:true)
        }
        
    }
    
    @IBAction func actionclose(_ sender: Any) {
        self.setView(view: infoView, hidden:true)
        infoButton.isSelected = false
    }
    @IBAction func actionPinTouch(_ sender: Any) {
        let root = UIWindow.key?.rootViewController!
        if let firstPresented = UIStoryboard.SaveLocationVC() {
            firstPresented.modalTransitionStyle = .crossDissolve
            firstPresented.modalPresentationStyle = .overCurrentContext
            root?.present(firstPresented, animated: false, completion: nil)
        }
        
    }
    
    
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
    }
}
extension SelectFromMapVc:GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {

        let latitude = mapView.camera.target.latitude
        let longitude = mapView.camera.target.longitude
        
        LocationManager.sharedInstance.getAddressFromCLocation(location: CLLocation(latitude: latitude, longitude: longitude)) { placeMark in
            if let placeMark = placeMark {
                self.lblLocatioName.text = placeMark.getAddress()
            }
        }
    }
//    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
//
//        let latitude = mapView.camera.target.latitude
//           let longitude = mapView.camera.target.longitude
//
//        LocationManager.sharedInstance.getAddressFromCLocation(location: CLLocation(latitude: latitude, longitude: longitude)) { placeMark in
//            if let placeMark = placeMark {
//                self.lblLocatioName.text = placeMark.getAddress()
//            }
//        }
//    }
//    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
//        <#code#>
//    }
//    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//        let mapLatitude = mapView.centerCoordinate.latitude
//        let mapLongitude = mapView.centerCoordinate.longitude
//        center = "Latitude: \(mapLatitude) Longitude: \(mapLongitude)"
//        print(center)
//        self.yourLabelName.text = center
//    }
    
}
