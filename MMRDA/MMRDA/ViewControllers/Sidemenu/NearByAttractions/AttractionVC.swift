//
//  AttractionVC.swift
//  MMRDA
//
//  Created by Kirti Chavda on 30/08/22.
//

enum fromAction:String {
    case sidemenu
    case station
}


enum attractionItem:String,CaseIterable {
    case restaurant = "tv_restaurant"
    case hotel = "tv_hotel"
    case groceries = "tv_groceries"
    case takeout = "tv_takeout"
    case gas = "tv_gas"
    case pharmacies = "tv_pharmacies"
    case coffee = "tv_coffee"
    
    var img:String?{
        switch(self) {
        case .restaurant:
            return "restaurnt"
        case .hotel:
            return "hotel"
        case .groceries:
            return "groceries"
        case .takeout:
            return "takeout"
        case .gas:
            return "gas"
        case .pharmacies:
            return "pharmacies"
        case .coffee:
            return "coffee"
        }
    }
    var pinimg:String?{
        switch(self) {
        case .restaurant:
            return "pin_restaurnt"
        case .hotel:
            return "pin_hotel"
        case .groceries:
            return "pin_groceries"
        case .takeout:
            return "pin_takeout"
        case .gas:
            return "pin_gas"
        case .pharmacies:
            return "pin_pharmacies"
        case .coffee:
            return "pin_coffee"
        }
    }
    var placeID:Int?{
        switch(self) {
        case .restaurant:
            return 2
        case .hotel:
            return 4
        case .groceries:
            return 1
        case .takeout:
            return 3
        case .gas:
            return 5
        case .pharmacies:
            return 6
        case .coffee:
            return 7
        }
    }
}

import UIKit
import GoogleMaps
import DropDown

//    ALL(0),
//    Groceries(1),
//    Restaurants(2),
//    Takeout(3),
//    Hotels(4),
//    Gas(5),
//    Pharmacies(6),
//    Coffee(7),
//    ALL_LOCATION(10);

    
class AttractionVC: BaseVC {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var bottomViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var textSearch: UITextField!
    var currentSelectedTypeid:Int = 0
    var isSearchActive  = false
    private var searchTimer: Timer?
    private var  objViewModel = AttractionViewModel()
    lazy var dropDown = DropDown()
    var fromAction:fromAction = .sidemenu
    var objStation:FareStationListModel?
    var arrSearchDsiplayData = [attractionSearchDisplay]() {
        didSet {
            self.tableview.reloadData()
            mapView.clear()
            for obj in arrSearchDsiplayData {
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: obj.decPlaceLat ?? 0, longitude: obj.decPlaceLong ?? 0)
                marker.icon = self.getPinImage(typeid: obj.placeTypeId)
                marker.map = mapView
                marker.title = obj.strPlaceName
                marker.userData = obj
              
            }
        }
    }
    
    var arrPreditction = [Predictions]() {
        didSet {
            self.showDropDownData()
        }
    }
    var arrAttraction = [AttractionListModel]() {
        didSet {
            self.tableview.reloadData()
            mapView.clear()
            for obj in arrAttraction {
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: obj.latitude ?? 0, longitude: obj.longitude ?? 0)
                marker.icon = self.getPinImage(typeid: obj.placeTypeID)
                marker.map = mapView
                marker.title = obj.placeName
                marker.userData = obj
              
            }
        }
    }
    var arrFilterAttraction = [AttractionListModel]() {
        didSet {
            self.tableview.reloadData()
            mapView.clear()
            for obj in arrFilterAttraction {
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: obj.latitude ?? 0, longitude: obj.longitude ?? 0)
                marker.icon = self.getPinImage(typeid: obj.placeTypeID)
                marker.map = mapView
                marker.title = obj.placeName
                marker.userData = obj
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackButton()
        self.setRightHomeButton()
        self.navigationItem.title = sidemenuItem.nearbyattraction.rawValue.LocalizedString
        
        objViewModel.delegate = self
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
        self.collectionview.register(UINib(nibName: "cellClcAttraction", bundle: nil), forCellWithReuseIdentifier: "cellClcAttraction")
        self.tableview.register(UINib(nibName: "cellAttraction", bundle: nil), forCellReuseIdentifier: "cellAttraction")
        textSearch.placeholder = "searchSearchrestauranthotel".LocalizedString
        textSearch.addTarget(self, action: #selector(textChanged(_:)), for:.editingChanged)
        
        if fromAction == .sidemenu {
            LocationManager.sharedInstance.getCurrentLocation { success, location in
                if success {
                    
                    self .setLocationForApi(latitude:LocationManager.sharedInstance.currentLocation.coordinate.latitude, longitude:  LocationManager.sharedInstance.currentLocation.coordinate.longitude)
//                    var param = [String:Any]()
//                    param["UserID"] = Helper.shared.objloginData?.intUserID
//                    param["decCurrentLat"] =  LocationManager.sharedInstance.currentLocation.coordinate.latitude
//                    param["decCurrentLong"] = LocationManager.sharedInstance.currentLocation.coordinate.longitude
//                    self.objViewModel.getAttractionList(param: param)
//                    let camera = GMSCameraPosition.camera(withLatitude:LocationManager.sharedInstance.currentLocation.coordinate.latitude, longitude: LocationManager.sharedInstance.currentLocation.coordinate.longitude, zoom: 15)
//                    self.mapView.camera = camera
                }
            }
        }else {
            self.setLocationForApi(latitude:objStation?.lattitude ?? 0, longitude: objStation?.longitude ?? 0)
        }
        
       
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        
        leftSwipe.direction = .up
        rightSwipe.direction = .down
        bottomView.addGestureRecognizer(leftSwipe)
        bottomView.addGestureRecognizer(rightSwipe)
        self.bottomViewHeightConstraint.constant = 150
        
        
    }
    func setLocationForApi(latitude:Double,longitude:Double){
        var param = [String:Any]()
        param["UserID"] = Helper.shared.objloginData?.intUserID
        param["decCurrentLat"] = latitude
        param["decCurrentLong"] = longitude
        self.objViewModel.getAttractionList(param: param)
        let camera = GMSCameraPosition.camera(withLatitude:latitude, longitude: longitude, zoom: 15)
        self.mapView.camera = camera
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
            param["placeTypeId"] = currentSelectedTypeid
            param["strPlaceName"] = obj.description?.components(separatedBy:",").first
            param["strAddressName"] = obj.description
            param["decCurrentLat"] =  fromAction == .sidemenu ? LocationManager.sharedInstance.currentLocation.coordinate.latitude : (objStation?.lattitude ?? 0)
            param["decCurrentLong"] =  fromAction == .sidemenu ? LocationManager.sharedInstance.currentLocation.coordinate.longitude : (objStation?.longitude ?? 0)
            self.objViewModel.getAttractionClickedData(param: param)
            isSearchActive = true
            self.tableview.reloadData()
            textSearch.resignFirstResponder()
        }
        dropDown.show()
    }
    func getPinImage(typeid:Int?)->UIImage{
        switch typeid {
        case attractionItem.restaurant.placeID:
            return UIImage(named: attractionItem.restaurant.pinimg ?? "") ?? UIImage()
        case attractionItem.hotel.placeID:
            return UIImage(named: attractionItem.hotel.pinimg ?? "") ?? UIImage()
        case attractionItem.groceries.placeID:
            return UIImage(named: attractionItem.groceries.pinimg ?? "") ?? UIImage()
        case attractionItem.hotel.placeID:
            return UIImage(named: attractionItem.hotel.pinimg ?? "") ?? UIImage()
        case attractionItem.takeout.placeID:
            return UIImage(named: attractionItem.takeout.pinimg ?? "") ?? UIImage()
        case attractionItem.pharmacies.placeID:
            return UIImage(named: attractionItem.pharmacies.pinimg ?? "") ?? UIImage()
        case attractionItem.coffee.placeID:
            return UIImage(named: attractionItem.coffee.pinimg ?? "") ?? UIImage()
        case .none:
            return  UIImage(named: attractionItem.restaurant.pinimg ?? "") ?? UIImage() // default

        case .some(_):
            return  UIImage(named: attractionItem.restaurant.pinimg ?? "") ?? UIImage() // default
        }
    }
    func getcellImage(typeid:Int?)->UIImage{
        switch typeid {
        case attractionItem.restaurant.placeID:
            return UIImage(named: attractionItem.restaurant.img ?? "") ?? UIImage()
        case attractionItem.hotel.placeID:
            return UIImage(named: attractionItem.hotel.img ?? "") ?? UIImage()
        case attractionItem.groceries.placeID:
            return UIImage(named: attractionItem.groceries.img ?? "") ?? UIImage()
        case attractionItem.hotel.placeID:
            return UIImage(named: attractionItem.hotel.img ?? "") ?? UIImage()
        case attractionItem.takeout.placeID:
            return UIImage(named: attractionItem.takeout.img ?? "") ?? UIImage()
        case attractionItem.pharmacies.placeID:
            return UIImage(named: attractionItem.pharmacies.img ?? "") ?? UIImage()
        case attractionItem.coffee.placeID:
            return UIImage(named: attractionItem.coffee.img ?? "") ?? UIImage()
        case .none:
            return  UIImage(named: attractionItem.restaurant.img ?? "") ?? UIImage() // default
            
        case .some(_):
            return  UIImage(named: attractionItem.restaurant.img ?? "") ?? UIImage() // default
        }
    }
    @objc func textChanged(_ textField: UITextField){
        if let searchTimer = searchTimer {
            searchTimer.invalidate()
        }
        isSearchActive = false
        searchTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(gotoApiSearch(_:)), userInfo:nil, repeats: false)
        if textSearch.text?.trim().isEmpty ?? false {
            isSearchActive = false
            self.tableview.reloadData()
        }
    }
    @objc func gotoApiSearch(_ textField: UITextField) {
        
        if textSearch.text?.count ?? 0 >= 3 {
            var param = [String:Any]()
            param["PlaceTypeId"] = currentSelectedTypeid
            param["strPlaceName"] =  textSearch.text
            self.objViewModel.getAttractionSearch(param: param)
        }
      
    }
    @objc func handleSwipes(_ sender: UISwipeGestureRecognizer){
        if sender.direction == .up{
            self.bottomViewHeightConstraint.constant = 150 + ( IS_IPHONE_6_OR_LESS ? SCREEN_HEIGHT * 0.30 : IS_IPHONE_8_OR_LESS ? SCREEN_HEIGHT * 0.35 : SCREEN_HEIGHT * 0.4)
        }
        if sender.direction == .down{
            self.bottomViewHeightConstraint.constant = 150
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

  
    // Do any additional setup after loading the view.
}





extension AttractionVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearchActive {
            let arr = arrSearchDsiplayData.filter { objdata in
                return objdata.placeTypeId == currentSelectedTypeid
            }
            return arr.count
        }else {
            
            if currentSelectedTypeid > 0 {
                return arrFilterAttraction.count
            }
            return arrAttraction.count
        }
    }
   @objc func btnActiongoDirection(sender:UIButton){
       
       if isSearchActive {
           let arr = arrSearchDsiplayData.filter { objdata in
               return objdata.placeTypeId == currentSelectedTypeid
           }
           let objData = arr[sender.tag]
           
           if let url = URL(string:"http://maps.google.com/maps?daddr=\(objData.decPlaceLat ?? 0),\(objData.decPlaceLong ?? 0)") {
               if UIApplication.shared.canOpenURL(url) {
                   UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                       print("Open url : \(success)")
                   })
               }
           }
           
       }else {
           var objData:AttractionListModel?
           if currentSelectedTypeid > 0 {
               objData = arrFilterAttraction[sender.tag]
           }else {
               objData = arrAttraction[sender.tag]
           }
           
           if let url = URL(string:"http://maps.google.com/maps?daddr=\(objData?.latitude ?? 0),\(objData?.longitude ?? 0)") {
               if UIApplication.shared.canOpenURL(url) {
                   UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                       print("Open url : \(success)")
                   })
               }
           }
           
           
       }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:cellAttraction = tableView.dequeueReusableCell(withIdentifier: "cellAttraction") as? cellAttraction else { return UITableViewCell() }
        
        cell.btnDirection.tag = indexPath.row
        cell.btnDirection.addTarget(self, action: #selector(btnActiongoDirection(sender:)), for: .touchUpInside)
        if isSearchActive {
            let arr = arrSearchDsiplayData.filter { objdata in
                return objdata.placeTypeId == currentSelectedTypeid
            }
            let objData = arr[indexPath.row]
            cell.lblTitle.text = objData.strPlaceName
            cell.lblAddress.text = objData.strAddressName
            cell.lblDistance.text =  String(format: "%0.3f", objData.distance ?? 0) + " KM"
            cell.imgview.image = self.getcellImage(typeid: objData.placeTypeId)
            return cell
        }else {
            var objData:AttractionListModel?
            if currentSelectedTypeid > 0 {
                objData = arrFilterAttraction[indexPath.row]
            }else {
                objData = arrAttraction[indexPath.row]
            }
            cell.lblTitle.text = objData?.placeName
            cell.lblAddress.text = objData?.address
            cell.lblDistance.text =  String(format: "%0.3f", objData?.distance ?? 0) + " KM"
            cell.imgview.image = self.getcellImage(typeid: objData?.placeTypeID)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
extension AttractionVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return attractionItem.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell:cellClcAttraction = collectionView.dequeueReusableCell(withReuseIdentifier:"cellClcAttraction", for: indexPath as IndexPath) as? cellClcAttraction else { return UICollectionViewCell () }
        cell.lblName.text = attractionItem.allCases[indexPath.row].rawValue.LocalizedString
        if attractionItem.allCases[indexPath.row].placeID == currentSelectedTypeid {
            cell.imgView.image = UIImage(named:(attractionItem.allCases[indexPath.row].img ?? "") + "_sel")
        }else {
            cell.imgView.image = UIImage(named:(attractionItem.allCases[indexPath.row].img ?? ""))
        }
     
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        currentSelectedTypeid = attractionItem.allCases[indexPath.row].placeID ?? 0
        if isSearchActive {
            self.tableview.reloadData()
        }else {
            arrFilterAttraction = arrAttraction.filter { objdata in
                return objdata.placeTypeID == currentSelectedTypeid
            }
            
        }
        self.collectionview.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 120)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        let sectionInset = UIEdgeInsets(top:0, left:5, bottom:5, right:5)
        return sectionInset
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
        
        
    }
    
}
extension AttractionVC:ViewcontrollerSendBackDelegate {
    func getInformatioBack<T>(_ handleData: inout T) {
        if let data = handleData as? [AttractionListModel] {
            arrAttraction = data
        }
        if let data = handleData as? [Predictions] {
            arrPreditction = data
        }
        if let data = handleData as? [attractionSearchDisplay] {
            arrSearchDsiplayData = data
        }
    }
}
extension AttractionVC:UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.showDropDownData()
        return true
    }
    
}
