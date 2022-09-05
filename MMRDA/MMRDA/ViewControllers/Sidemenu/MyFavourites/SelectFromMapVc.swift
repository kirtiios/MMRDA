//
//  SelectFromMapVc.swift
//  MMRDA
//
//  Created by Sandip Patel on 30/08/22.
//

import UIKit
import GoogleMaps
import CoreLocation
import DropDown

class SelectFromMapVc: BaseVC {
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var lblLocatioName: UILabel!
    @IBOutlet weak var textSearch: UITextField!
    @IBOutlet weak var infoButton: UIButton!
    private var searchTimer: Timer?
    private var  objViewModel = FavouriteModelView()
    
    var arrPreditction = [Predictions]() {
        didSet {
            self.showDropDownData()
        }
    }
    var arrSearchDsiplayData = [attractionSearchDisplay]() {
        didSet {
        
          
            
            mapView.clear()
            for obj in arrSearchDsiplayData {
                
                let camera = GMSCameraPosition.camera(withLatitude:obj.decPlaceLat ?? 0, longitude: obj.decPlaceLong ?? 0, zoom: 15)
                mapView.camera = camera
                
                self.getAddressFromLocation(coordinate:CLLocationCoordinate2D(latitude: obj.decPlaceLat ?? 0, longitude: obj.decPlaceLong ?? 0))
//                let marker = GMSMarker()
//                marker.position = CLLocationCoordinate2D(latitude: obj.decPlaceLat ?? 0, longitude: obj.decPlaceLong ?? 0)
//                marker.icon = self.getPinImage(typeid: obj.placeTypeId)
//                marker.map = mapView
//                marker.title = obj.strPlaceName
//                marker.userData = obj
              
            }
        }
    }
    lazy var dropDown = DropDown()
    var completion:(()->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        objViewModel.delegate = self
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
        
        mapView.delegate = self
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"myfavourites".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        LocationManager.sharedInstance.getCurrentLocation { success, location in
            if success {
                let camera = GMSCameraPosition.camera(withLatitude:LocationManager.sharedInstance.currentLocation.coordinate.latitude, longitude: LocationManager.sharedInstance.currentLocation.coordinate.longitude, zoom: 15)
                
//                LocationManager.sharedInstance.getAddressFromCLocation(location: location) { placeMark in
//                    if let placeMark = placeMark {
//                        self.lblLocatioName.text = placeMark.getAddress()
//                    }
//                }
                
                self.getAddressFromLocation(coordinate:CLLocationCoordinate2D(latitude: LocationManager.sharedInstance.currentLocation.coordinate.latitude, longitude: LocationManager.sharedInstance.currentLocation.coordinate.longitude))
//                LocationManager.sharedInstance.getaddessFromLatLong(coords: CLLocationCoordinate2D(latitude: LocationManager.sharedInstance.currentLocation.coordinate.latitude, longitude: LocationManager.sharedInstance.currentLocation.coordinate.longitude)) { address in
//                    self.lblLocatioName.text = address
//                }
                
                self.mapView.camera = camera
            }
        }
        
        textSearch.addTarget(self, action: #selector(textChanged(_:)), for:.editingChanged)
        // Do any additional setup after loading the view.
    }
    
    func getAddressFromLocation(coordinate:CLLocationCoordinate2D){
        
        LocationManager.sharedInstance.getaddessFromLatLong(coords:coordinate) { address in
            self.lblLocatioName.text = address
        }
    }
    @IBAction func btnActionCurrentLocationClicked(_ sender: UIButton) {
        LocationManager.sharedInstance.getCurrentLocation { success, location in
            if success {
                let camera = GMSCameraPosition.camera(withLatitude:LocationManager.sharedInstance.currentLocation.coordinate.latitude, longitude: LocationManager.sharedInstance.currentLocation.coordinate.longitude, zoom: 15)
                
                
                self.getAddressFromLocation(coordinate:CLLocationCoordinate2D(latitude: LocationManager.sharedInstance.currentLocation.coordinate.latitude, longitude: LocationManager.sharedInstance.currentLocation.coordinate.longitude))
                
//                LocationManager.sharedInstance.getAddressFromCLocation(location: location) { placeMark in
//                    if let placeMark = placeMark {
//                        self.lblLocatioName.text = placeMark.formattedAddress
//                    }
//                }
                self.mapView.camera = camera
            }
        }
        
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
            firstPresented.compeltion = {
                self.navigationController?.popViewController(animated: true)
                self.completion?()
            }
            firstPresented.strLocation = self.lblLocatioName.text
            firstPresented.objLocation = mapView.camera.target
            firstPresented.modalTransitionStyle = .crossDissolve
            firstPresented.modalPresentationStyle = .overCurrentContext
            root?.present(firstPresented, animated: false, completion: nil)
        }
        
    }
    @objc func textChanged(_ textField: UITextField){
        if let searchTimer = searchTimer {
            searchTimer.invalidate()
        }
       
        searchTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(gotoApiSearch(_:)), userInfo:nil, repeats: false)
       
    }
    @objc func gotoApiSearch(_ textField: UITextField) {
        
        if textSearch.text?.count ?? 0 >= 3 {
            var param = [String:Any]()
            param["PlaceTypeId"] = "10" // for all location
             param["strPlaceName"] =  textSearch.text
            self.objViewModel.getFavouriteSearch(param: param)
        }
      
    }
    func showDropDownData(){
        dropDown.anchorView = textSearch
        dropDown.dataSource = arrPreditction.compactMap({ objList in
            return objList.description
        })
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            cell.optionLabel.numberOfLines = 0
        }
        dropDown.bottomOffset = CGPoint(x: 0, y:textSearch?.frame.height ?? 0)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            textSearch.text = item
            let obj = arrPreditction[index]
            var param = [String:Any]()
            param["strPlaceId"] = obj.place_id
            param["placeTypeId"] = "10"
            param["strPlaceName"] = obj.description?.components(separatedBy:",").first
            param["strAddressName"] = obj.description
            param["decCurrentLat"] =  LocationManager.sharedInstance.currentLocation.coordinate.latitude
            param["decCurrentLong"] = LocationManager.sharedInstance.currentLocation.coordinate.longitude
            self.objViewModel.getAttractionClickedData(param: param)
            textSearch.resignFirstResponder()
        }
        dropDown.show()
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
        
//        LocationManager.sharedInstance.getAddressFromCLocation(location: CLLocation(latitude: latitude, longitude: longitude)) { placeMark in
//            if let placeMark = placeMark {
//                self.lblLocatioName.text = placeMark.getAddress()
//            }
//        }
        
        self.getAddressFromLocation(coordinate:CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
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
extension SelectFromMapVc:ViewcontrollerSendBackDelegate {
    func getInformatioBack<T>(_ handleData: inout T) {
        
        if let data = handleData as? [Predictions] {
            arrPreditction = data
        }
        if let data = handleData as? [attractionSearchDisplay] {
            arrSearchDsiplayData = data
        }
        
        if let data = handleData as? [favouriteList] {
            
//            arrLocationfavList = data.filter({ obj in
//                return obj.intFavouriteTypeID == typeOfFav.Location.rawValue
//            })
//            arrRoutefavList = data.filter({ obj in
//                return obj.intFavouriteTypeID == typeOfFav.Route.rawValue
//            })
//            arrStationfavList = data.filter({ obj in
//                return obj.intFavouriteTypeID == typeOfFav.Station.rawValue
//            })
            
           
        }
       
    }
}
