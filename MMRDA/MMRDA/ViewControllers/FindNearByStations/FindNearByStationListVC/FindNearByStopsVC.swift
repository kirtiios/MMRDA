//
//  FindNearByStopsVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 22/08/22.
//

import UIKit
import GoogleMaps
import DropDown


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
    
    
    @IBOutlet weak var lblMetro:UILabel!
    @IBOutlet weak var lblBus:UILabel!
    @IBOutlet weak var lblTaxi:UILabel!
    
    var path = GMSMutablePath()
    
    
    enum transPortType:Int {
        case all = 0
        case Metro = 1
        case bus = 2
        case Taxi = 3
    }
    
    var arrAllStationList = [FareStationListModel]() {
        didSet{
            if btnMetro.isSelected {
                busttype = .Metro
            }
            else if btnBus.isSelected {
                busttype = .bus
            }else {
                busttype = .Taxi
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
    var busttype:transPortType = .all {
        didSet {
            if busttype == .all {
                arrStationList = arrAllStationList
            }else {
                arrStationList =  arrAllStationList.filter({ obj in
                    return obj.transportType == busttype.rawValue
                })
            }
            lblTotalVehcile.text = "tv_total_station".LocalizedString + " \(arrStationList.count)"
            tblView.reloadData()
          
        }
    }
    
    @IBOutlet weak var searchTableviewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnClose: UIButton!
    var isSearchActive  = false
    private var searchTimer: Timer?
    private let objViewModel  = FindeNearbyStopViewModel()
    lazy var dropDown = DropDown()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.callBarButtonForHome(isloggedIn:true,leftBarLabelName:"findnearbybusstops".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        actionTransportMediaChange(btnMetro)
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        
        leftSwipe.direction = .up
        rightSwipe.direction = .down
        dataView.addGestureRecognizer(leftSwipe)
        dataView.addGestureRecognizer(rightSwipe)
        self.searchTableviewHeightConstraint.constant = 0
        
      //  txtSearchBar.delegate = self
        txtSearchBar.addTarget(self, action: #selector(textChanged(_:)), for:.editingChanged)
        
        objViewModel.delegate = self
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
        
        LocationManager.sharedInstance.getCurrentLocation { success, location in
            if success {
              
                self .getNearByStop(objStation:nil)
                let camera = GMSCameraPosition.camera(withLatitude:LocationManager.sharedInstance.currentLocation.coordinate.latitude, longitude: LocationManager.sharedInstance.currentLocation.coordinate.longitude, zoom: 5)
                self.mapView.camera = camera
                self.circleview(redius:5, location:LocationManager.sharedInstance.currentLocation.coordinate)
            }
        }
        
        
        btnMetro.setImage(UIImage(named: "metroSelected"), for:.selected)
        btnMetro.setImage(UIImage(named: "metroUnselected"), for:.normal)
        btnTaxi.setImage(UIImage(named: "carUnselected"), for:.normal)
        btnTaxi.setImage(UIImage(named: "carSelected"), for:.selected)
        btnBus.setImage(UIImage(named: "busUnselected"), for:.normal)
        btnBus.setImage(UIImage(named: "busSelected"), for:.selected)
        
        lblTaxi.textColor = UIColor.blackcolor
        lblBus.textColor = UIColor.blackcolor
        lblMetro.textColor = UIColor.blackcolor
        
    }
    func getNearByStop(objStation:FareStationListModel?){
        var param = [String:Any]()
        param["UserID"] = Helper.shared.objloginData?.intUserID
        param["decStationLat"] =  objStation?.lattitude ?? 0
        param["decStationLong"] = objStation?.longitude ?? 0 //72.85872096902258
        param["strStationName"] =  ""
        param["decCurrentLat"] = LocationManager.sharedInstance.currentLocation.coordinate.latitude
        param["decCurrentLong"] = LocationManager.sharedInstance.currentLocation.coordinate.longitude
        self.objViewModel.getfindNearByStop(param: param)
        
        
      
        
//        API : Masters/GetStationListWithDistance
//        isSearch {
//        decStationLat
//        decStationLong
//        decCurrentLat
//        decCurrentLong
//        strStationName
//        UserID
//        }
//        else
//        {
//        decStationLat // 0
//        decStationLong // 0
//        decCurrentLat
//        decCurrentLong
//        strStationName  // blank
//        UserID
//        }
        
        
    }
    @objc func textChanged(_ textField: UITextField){
        if let searchTimer = searchTimer {
            searchTimer.invalidate()
        }
        isSearchActive = false
        searchTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(gotoApiSearch(_:)), userInfo:nil, repeats: false)
        if txtSearchBar.text?.trim().isEmpty ?? false {
            isSearchActive = false
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
    
    
    
    func showDropDownData(){
        dropDown.anchorView = txtSearchBar.superview
        dropDown.dataSource = arrSearchStationList.compactMap({ objList in
            return objList.sationname
        })
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            cell.optionLabel.numberOfLines = 0
        }
        dropDown.bottomOffset = CGPoint(x: 0, y:txtSearchBar?.frame.height ?? 0)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            txtSearchBar.text = item
            
            self .getNearByStop(objStation: arrSearchStationList[index])
//            let obj = arrPreditction[index]
//            var param = [String:Any]()
//            param["strPlaceId"] = obj.place_id
//            param["placeTypeId"] = currentSelectedTypeid
//            param["strPlaceName"] = obj.description?.components(separatedBy:",").first
//            param["strAddressName"] = obj.description
//            param["decCurrentLat"] =  LocationManager.sharedInstance.currentLocation.coordinate.latitude
//            param["decCurrentLong"] = LocationManager.sharedInstance.currentLocation.coordinate.longitude
//            self.objViewModel.getAttractionClickedData(param: param)
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
            self.searchTableviewHeightConstraint.constant = 0
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
        cirlce?.fillColor = APP_ICONS_COLOR.withAlphaComponent(0.2)
        cirlce?.strokeColor = APP_ICONS_COLOR
        cirlce?.accessibilityRespondsToUserInteraction = false
        cirlce?.strokeWidth = 1
        cirlce?.isTappable = false
        cirlce?.map = mapView
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
        cell.lblKm.text = String(format: "%0.3f", objdata.distance ?? 0) + " KM"
        cell.lblStopName.text = objdata.sationname
        if objdata.transportType == transPortType.Metro.rawValue {
            cell.imgTransportType.image = UIImage(named:"metroUnselected")
        }
        else if objdata.transportType == transPortType.bus.rawValue {
            cell.imgTransportType.image = UIImage(named:"busUnselected")
        }else {
            cell.imgTransportType.image = UIImage(named:"carUnselected")
        }
        cell.btnDirection.tag = indexPath.row
        cell.btnDirection.addTarget(self, action:  #selector(btnActionDirectionClicked(sender:)), for: .touchUpInside)
        
//        btnMetro.setImage(UIImage(named: "metroSelected"), for:.selected)
//        btnMetro.setImage(UIImage(named: "metroUnselected"), for:.normal)
//        btnTaxi.setImage(UIImage(named: "carUnselected"), for:.normal)
//        btnTaxi.setImage(UIImage(named: "carSelected"), for:.selected)
//        btnBus.setImage(UIImage(named: "busUnselected"), for:.normal)
//        btnBus.setImage(UIImage(named: "busSelected"), for:.selected)
        
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
        
                })
           }
        }
        
       // self.getNearByStop(objStation: obj)
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.StationListingVC()
        self.navigationController?.pushViewController(vc!, animated:true)
    }
    
    
}
extension FindNearByStopsVC:ViewcontrollerSendBackDelegate {
    func getInformatioBack<T>(_ handleData: inout T) {
        if let data = handleData as? [FareStationListModel] {
            
                arrAllStationList = data
            
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
        dmarker.title = objDestination?.sationname ?? ""
        dmarker.map = mapView
        dmarker.icon =  self.getPinImage(typeID: objDestination?.transportType ?? 0)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
//            let bounds = GMSCoordinateBounds(path: self.path)
//            self.mapView!.animate(with: GMSCameraUpdate.fit(bounds, withPadding:0.0))
//
//        })

        
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
