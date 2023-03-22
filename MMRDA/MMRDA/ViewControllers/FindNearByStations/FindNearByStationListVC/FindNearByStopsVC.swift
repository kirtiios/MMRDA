//
//  FindNearByStopsVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 22/08/22.
//

import UIKit
import GoogleMaps
import DropDown
enum transPortType:Int {
    case all = 0
    case Metro = 1
    case bus = 2
    case Taxi = 3
    
    var pinImage:UIImage?{
        switch(self) {
            
        case .all:
            return UIImage()
        case .Metro:
            return UIImage(named: "pin_metro")
        case .bus:
            return UIImage(named: "pin_bus")
        case .Taxi:
            return UIImage(named: "pin_taxi")
        }
    }
}

let APP_ICONS_COLOR = UIColor(hexString: "#28D990")

class FindNearByStopsVC: BaseVC {
    
    @IBOutlet weak var lblTotalVehcile: UILabel!
    @IBOutlet weak var tblSearchResult: UITableView!
    @IBOutlet weak var viewSearchResult: UIView!
    @IBOutlet weak var txtSearchBar: UITextField!
    @IBOutlet weak var btnTaxi: UIButton!
    @IBOutlet weak var btnMetro: UIButton!
    @IBOutlet weak var btnBus: UIButton!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var dataContentView: UIView!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var lblNoDataFound: UILabel!
    @IBOutlet weak var searchBarView: UIView!
    var cirlce:GMSCircle?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var lblMetro:UILabel!
    @IBOutlet weak var lblBus:UILabel!
    @IBOutlet weak var lblTaxi:UILabel!
    @IBOutlet weak var lblNoStation:UILabel!
    
    var isApiResponded = false
    
    var path = GMSMutablePath()
    var arrAllStationList = [FareStationListModel]() {
        didSet{
            if btnMetro.isSelected {
                busttype = .Metro
            }
            else if btnBus.isSelected {
                busttype = .bus
            }else if btnTaxi.isSelected {
                busttype = .Taxi
            }else {
                busttype = .all
            }
        }
    }

    var arrStationList = [FareStationListModel](){
        didSet{
            tblView .reloadData()
        }
    }
    var arrSearchStationList = [FareStationListModel]() {
        didSet {
            self.showDropDownData()
        }
    }
    var arrSuggestionStationList = [FareStationListModel]()
    var busttype:transPortType = .Metro {
        didSet {
            if busttype == .all {
                arrStationList = arrAllStationList
            }else {
                arrStationList =  arrAllStationList.filter({ obj in
                    return obj.transportType == busttype.rawValue
                })
            }
            
            mapView.clear()
            for obj in arrStationList {
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: obj.lattitude ?? 0, longitude: obj.longitude ?? 0)
                marker.icon = self.getStationPinImage(typeid: obj.transportType)
                marker.map = mapView
                marker.title = obj.displaystationname
                marker.userData = obj
            }
            self.setUserCurrentLocation()
            self.circleview(redius:5, location:mapView.camera.target)
            
            lblTotalVehcile.text = "tv_total_station".LocalizedString + " \(arrStationList.count)"
            tblView.reloadData()
          
        }
    }
    func setUserCurrentLocation(){
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: LocationManager.sharedInstance.currentLocation.coordinate.latitude , longitude: LocationManager.sharedInstance.currentLocation.coordinate.longitude )
        marker.icon = UIImage(named:"currentPIn")
        marker.map = mapView
       // marker.title = "you are here"
    }
    
    @IBOutlet weak var searchTableviewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnClose: UIButton!
    var isSearchActive  = false
    private var searchTimer: Timer?
    private let objViewModel  = FindeNearbyStopViewModel()
    lazy var dropDown = DropDown()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.callBarButtonForHome(isloggedIn:true,leftBarLabelName:"findnearbybusstops".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        
        self.setRightHomeButton()
        self.setBackButton()
        self.navigationItem.title = "findnearbybusstops".localized()
       // actionTransportMediaChange(btnMetro)
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        
        leftSwipe.direction = .up
        rightSwipe.direction = .down
        dataView.addGestureRecognizer(leftSwipe)
        dataView.addGestureRecognizer(rightSwipe)
        self.searchTableviewHeightConstraint.constant = 25
        
        txtSearchBar.delegate = self
        txtSearchBar.addTarget(self, action: #selector(textChanged(_:)), for:.editingChanged)
        
        mapView.delegate = self
        objViewModel.delegate = self
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
        
        self .getRefreshData()
        
        if let savedPerson = UserDefaults.standard.object(forKey: userDefaultKey.stationList.rawValue) as? Data {
            if let loadedPerson = try? JSONDecoder().decode([FareStationListModel].self, from: savedPerson) {
               arrSuggestionStationList = loadedPerson
            }
        }
        
        btnMetro.setImage(UIImage(named:"metroSelected"), for:.selected)
        btnMetro.setImage(UIImage(named:"metroUnselected"), for:.normal)
        btnTaxi.setImage(UIImage(named:"carUnselected"), for:.normal)
        btnTaxi.setImage(UIImage(named:"carSelected"), for:.selected)
        btnBus.setImage(UIImage(named:"busUnselected"), for:.normal)
        btnBus.setImage(UIImage(named:"busSelected"), for:.selected)
        
        lblTaxi.textColor = UIColor.blackcolor
        lblBus.textColor = UIColor.blackcolor
        lblMetro.textColor = UIColor.blackcolor
        btnMetro.sendActions(for: .touchUpInside)
        
    }
    func getRefreshData(){
        LocationManager.sharedInstance.getCurrentLocation { success, location in
            if success {
                self.getNearByStop(objStation:nil, location: LocationManager.sharedInstance.currentLocation.coordinate)
                self.setUserCurrentLocation()
                let camera = GMSCameraPosition.camera(withLatitude:LocationManager.sharedInstance.currentLocation.coordinate.latitude, longitude: LocationManager.sharedInstance.currentLocation.coordinate.longitude, zoom: 12)
                self.mapView.camera = camera
                self.circleview(redius:5, location:camera.target)
               
            }
        }
    }
    func getNearByStop(objStation:FareStationListModel?,location:CLLocationCoordinate2D){
        var param = [String:Any]()
        param["UserID"] = Helper.shared.objloginData?.intUserID
        param["decStationLat"] =  "\(objStation?.lattitude ?? 0)"
        param["decStationLong"] = "\(objStation?.longitude ?? 0)" //72.85872096902258
        param["strStationName"] = ""
        param["decCurrentLat"] = location.latitude
        param["decCurrentLong"] = location.longitude
        activityIndicator.isHidden = false
        self.objViewModel.getfindNearByStop(param: param)
        
        if objStation != nil {
            self.cirlce?.position = CLLocationCoordinate2D(latitude: objStation?.lattitude ?? 0, longitude: objStation?.longitude ?? 0)
        }
        
    }
    @objc func textChanged(_ textField: UITextField){
        if let searchTimer = searchTimer {
            searchTimer.invalidate()
        }
        isSearchActive = false
        searchTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(gotoApiSearch(_:)), userInfo:nil, repeats: false)
        if txtSearchBar.text?.trim().isEmpty ?? false {
            isSearchActive = false
            arrSearchStationList = arrSuggestionStationList
            showDropDownData()
            self.tblView.reloadData()
        }
    }
    @objc func gotoApiSearch(_ textField: UITextField) {
        
        if txtSearchBar.text?.count ?? 0 >= 3 {
            var param = [String:Any]()
            param["userId"] = Helper.shared.objloginData?.intUserID
            param["decStationLat"] =  0
            param["decStationLong"] =  0
            param["strStationName"] =  txtSearchBar.text
            self.objViewModel.getNearbyStationSearch(param: param)
            self.objViewModel.bindSearchStationData = { arr in
                if arr != nil {
                    self.arrSearchStationList = arr!
                }
            }
        }
      
    }
    // Chnage Bus,Train,Taxi
    @IBAction func actionTransportMediaChange(_ sender: UIButton) {
        
        btnMetro.isSelected = false
        btnTaxi.isSelected = false
        btnBus.isSelected = false
        lblTaxi.textColor = UIColor.blackcolor
        lblBus.textColor = UIColor.blackcolor
        lblMetro.textColor = UIColor.blackcolor
        if sender == btnMetro {
            btnMetro.isSelected = true
            busttype = transPortType.Metro
            lblMetro.textColor = UIColor.greenColor
        }else if sender == btnBus {
            btnBus.isSelected = true
            busttype = transPortType.bus
            lblBus.textColor = UIColor.greenColor
        }else{
            btnTaxi.isSelected = true
            busttype = transPortType.Taxi
            lblTaxi.textColor = UIColor.greenColor
        }
    }
    @IBAction func btnActionRefreshClicked(_ sender: UIButton) {
        isSearchActive = false
        txtSearchBar.text = nil
        arrAllStationList.removeAll()
        self.tblView.reloadData()
        
        self.getRefreshData()
    }
    func showDropDownData(){
        
        
        dropDown.anchorView = txtSearchBar.superview
        
        let array = arrSearchStationList.compactMap({ objList in
            return objList.displaystationname
        })
        dropDown.dataSource = array
        if array.count < 1 && txtSearchBar.text?.trim().count ?? 0 > 0 {
            dropDown.dataSource = ["no_nearby_bus_stops_list_found_for_you".localized()]
        }
        
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            cell.optionLabel.numberOfLines = 0
        }
        dropDown.bottomOffset = CGPoint(x: 0, y:txtSearchBar?.frame.height ?? 0)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            txtSearchBar.text = item
            
            if item == "no_nearby_bus_stops_list_found_for_you".localized() {
                txtSearchBar.text = ""
                return
            }
            
            arrSuggestionStationList.removeAll { objStationList in
                return objStationList.stationid == arrSearchStationList[index].stationid
            }
            arrSuggestionStationList.insert(arrSearchStationList[index], at: 0)
            
            if let encoded = try? JSONEncoder().encode(arrSuggestionStationList) {
                UserDefaults.standard.set(encoded, forKey: userDefaultKey.stationList.rawValue)
                UserDefaults.standard.synchronize()
            }
            
            self .getNearByStop(objStation: arrSearchStationList[index], location: LocationManager.sharedInstance.currentLocation.coordinate)
            isSearchActive = true
            self.tblView.reloadData()
            txtSearchBar.resignFirstResponder()
        }
        dropDown.show()
    }
    
    @objc func handleSwipes(_ sender: UISwipeGestureRecognizer){
       if sender.direction == .up{
            self.searchTableviewHeightConstraint.constant = IS_IPHONE_6_OR_LESS ? SCREEN_HEIGHT * 0.30 : IS_IPHONE_8_OR_LESS ? SCREEN_HEIGHT * 0.35 : SCREEN_HEIGHT * 0.25
        }
        
        if sender.direction == .down{
            self.searchTableviewHeightConstraint.constant = arrStationList.count > 0 ?  0 : 25
        }
        self.animationView()
    }
    /// SHOW ANIMATION
    func animationView(){
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            self.view.layoutSubviews()
        }
    }
    func circleview(redius:Double,location:CLLocationCoordinate2D) {
        let coOrdinate = location
        cirlce =  GMSCircle(position:coOrdinate, radius:(redius * 1000))
        cirlce?.fillColor = APP_ICONS_COLOR.withAlphaComponent(0.3)
        cirlce?.strokeColor = APP_ICONS_COLOR
        cirlce?.accessibilityRespondsToUserInteraction = false
        cirlce?.strokeWidth = 1
        cirlce?.isTappable = false
        cirlce?.map = mapView
    }
    func getStationPinImage(typeid:Int?)->UIImage{
        switch typeid {
        case transPortType.Metro.rawValue:
            return transPortType.Metro.pinImage ?? UIImage()
        case transPortType.Taxi.rawValue:
            return transPortType.Taxi.pinImage ?? UIImage()
        case transPortType.bus.rawValue:
            return transPortType.bus.pinImage  ?? UIImage()
        case .none:
            return  UIImage()

        case .some(_):
            return  UIImage()
        }
    }
}


extension FindNearByStopsVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lblNoDataFound.isHidden = false
        if arrStationList.count > 0{
            lblNoDataFound.isHidden = true
        }
        return arrStationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"TransportDataCell") as? TransportDataCell else  { return UITableViewCell() }
        
        let objdata = arrStationList[indexPath.row]
        cell.lblKm.text = String(format:"%0.2f", objdata.distance ?? 0) + " KM"
        cell.lblStopName.text = objdata.displaystationname
        if objdata.transportType == transPortType.Metro.rawValue {
            cell.imgTransportType.image = UIImage(named:"metroStation")
        }
        else if objdata.transportType == transPortType.bus.rawValue {
            cell.imgTransportType.image = UIImage(named:"busUnselected")
        }else {
            cell.imgTransportType.image = UIImage(named:"carUnselected")
        }
        cell.btnDirection.tag = indexPath.row
        cell.btnDirection.addTarget(self, action:  #selector(btnActionDirectionClicked(sender:)), for: .touchUpInside)
        

        
        return cell
    }
    @objc func btnActionDirectionClicked(sender:UIButton){
        
        var obj:FareStationListModel?
        if isSearchActive {
            obj = arrSearchStationList[sender.tag]
        }else {
            obj = arrStationList[sender.tag]
        }
        var param = [String:Any]()
        param["UserID"] = Helper.shared.objloginData?.intUserID
        param["decStationLat"] =  obj?.lattitude ?? 0
        param["decStationLong"] = obj?.longitude ?? 0
        param["decCurrentLat"] =  LocationManager.sharedInstance.currentLocation.coordinate.latitude
        param["decCurrentLong"] = LocationManager.sharedInstance.currentLocation.coordinate.longitude
        param["intTransportModeID"] =  1
//        1 for driving
//        2 for walking
        
        //near by 
        self.objViewModel.getDirectionStation(param: param)
        self.objViewModel.bindDirectionDataData = { responseDict in
            if let routes = responseDict?["routes"] as? [[String:Any]] {
                let routes = (routes.first as Dictionary<String, AnyObject>?) ?? [:]
                let overviewPolyline = (routes["overview_polyline"] as? Dictionary<String,AnyObject>) ?? [:]
                let polypoints = (overviewPolyline["points"] as? String) ?? ""
                let line  = polypoints
                self.addPolyLine(encodedString: line, objDestination: obj)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
                    let bounds = GMSCoordinateBounds(path: self.path)
                    self.mapView!.animate(with: GMSCameraUpdate.fit(bounds, withPadding:0.0))
                    self.searchTableviewHeightConstraint.constant = 0
                    self.animationView()
                })
            }
        }
        
       // self.getNearByStop(objStation: obj)
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let obj = arrStationList[indexPath.row]
        let vc = UIStoryboard.StationListingVC()
        vc?.objStation = obj
        self.navigationController?.pushViewController(vc!, animated:true)
    }
    
    
}
extension FindNearByStopsVC:ViewcontrollerSendBackDelegate {
    func getInformatioBack<T>(_ handleData: inout T) {
        if let data = handleData as? [FareStationListModel] {
            isApiResponded = true
            arrAllStationList = data
            activityIndicator.isHidden = true
        }
        
        
    }
}
extension FindNearByStopsVC {
    func addPolyLine(encodedString: String,objDestination:FareStationListModel?) {
        
        self.path = GMSMutablePath(fromEncodedPath: encodedString)!
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 5
        polyline.strokeColor = .blue
        polyline.map = mapView
        
        
        let smarker = GMSMarker()
        smarker.position = CLLocationCoordinate2D(latitude:LocationManager.sharedInstance.currentLocation.coordinate.latitude, longitude: LocationManager.sharedInstance.currentLocation.coordinate.longitude)
        smarker.title = "Your Location"
        smarker.icon = UIImage.init(named:"Pin")
        smarker.map = mapView

        let dmarker = GMSMarker()
        dmarker.position = CLLocationCoordinate2D(latitude:CLLocationDegrees(objDestination?.lattitude ?? 0.0), longitude: CLLocationDegrees(objDestination?.longitude ?? 0.0))
        dmarker.title = objDestination?.displaystationname ?? ""
       // dmarker.userData = objDestination
        dmarker.map = mapView
        dmarker.icon =  self.getPinImage(typeID: objDestination?.transportType ?? 0)
        
        
    }
    func getPinImage(typeID:Int)->UIImage{
        if typeID == transPortType.Metro.rawValue {
            return UIImage(named: "pin_metro") ?? UIImage()
        }
        else  if typeID == transPortType.bus.rawValue {
            return UIImage(named: "pin_bus") ?? UIImage()
        }
        else  if typeID == transPortType.Taxi.rawValue {
            return UIImage(named: "pin_taxi") ?? UIImage()
        }else {
            return UIImage(named: "pin_metro") ?? UIImage()
        }
        
    }
}
extension FindNearByStopsVC:UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        arrSearchStationList = arrSuggestionStationList
        self.showDropDownData()
        return true
    }
    
}
extension FindNearByStopsVC:GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("InfoView tapped")
        if let objmarker = marker.userData as? FareStationListModel {
            let vc = UIStoryboard.StationListingVC()
            vc?.objStation = objmarker
            self.navigationController?.pushViewController(vc!, animated:true)
        }
    }
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        print("\(position.target.latitude) \(position.target.longitude)")
        if isSearchActive == false,isApiResponded {
           
            
            if let searchTimer = searchTimer {
                searchTimer.invalidate()
            }
            
            searchTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(circlviewRefresh), userInfo:nil, repeats: false)
           
        }
        
    }
    @objc func circlviewRefresh(){
        cirlce?.position = mapView.camera.target
        self.getNearByStop(objStation:nil, location:mapView.camera.target)
    }
}
