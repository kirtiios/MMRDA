//
//  PlanjourneyRouetDetailsVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 06/09/22.
//

import UIKit
import GoogleMaps

class PlanjourneyRouetDetailsVC: BaseVC {
    
    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var btnPayNow: UIButton!
    @IBOutlet weak var lblLastUpdatedtime: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    
    @IBOutlet weak var btnMapView: UIButton!
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var lblToStation: UILabel!
    @IBOutlet weak var lblFromStation: UILabel!
    @IBOutlet weak var lblStatusValue: UILabel!
    
    @IBOutlet weak var constMapViewHeight: NSLayoutConstraint!
    
   
    var objJourney:JourneyPlannerModel?
    var objStation:RecentPlaneStation?
    var arrRoutes:[TransitPaths]? {
        didSet {
            self.tblView.reloadData()
        }
    }
    var arrMarker = [GMSMarker]()
    private var  objViewModel = JourneyPlannerModelView()
    @IBOutlet weak var constTblViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var scrollview: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "routedetail".localized()
        let barButton = UIBarButtonItem(image:UIImage(named:"back"), style:.plain, target: self, action: #selector(btnActionBackClicked))
        barButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = barButton
        
      //  self.setBackButton()
        
        // self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"routedetail".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        lblFromStation.text = objJourney?.journeyPlannerStationDetail?.strFromStationName
        lblToStation.text = objJourney?.journeyPlannerStationDetail?.strToStationName
        lblStatus.text = objJourney?.journeyPlannerStationDetail?.strToStationName
        arrRoutes = objJourney?.transitPaths
        
        self.refreshandAddMarker()
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
        btnFav.isSelected = objJourney?.journeyPlannerStationDetail?.isFavorite ?? false
        
        
        
        // Do any additional setup after loading the view.
    }
    @objc private func btnActionBackClicked() {
        self.navigationController?.popToViewController(ofClass: JourneySearchVC.self)
        
    }
    func refreshandAddMarker(){
        let arr = objJourney?.transitPaths ?? [TransitPaths]()
        let path = GMSMutablePath()
        let pathDifferentFrom = GMSMutablePath()
        let pathDifferentTO = GMSMutablePath()
        arrMarker .removeAll()
        if let obj = objJourney?.journeyPlannerStationDetail {
            let marker = GMSMarker()
            let locationCordinate = CLLocationCoordinate2D(latitude: Double(obj.decFromStationLat ?? 0) , longitude:  Double(obj.decFromStationLong ?? 0) )
            marker.position = locationCordinate
            marker.icon = UIImage(named:"fromStation")
            marker.map = mapView
            marker.title = obj.strFromStationName
            marker.userData = obj
            pathDifferentFrom.add(locationCordinate)
            arrMarker .append(marker)
        }
        
        for  i in 0..<arr.count {
            let obj = arr[i]
            let marker = GMSMarker()
            let locationCordinate = CLLocationCoordinate2D(latitude: Double(obj.lat1 ?? "0") ?? 0, longitude:  Double(obj.long1 ?? "0") ?? 0)
            marker.position = locationCordinate
            marker.icon = (i == 0 ? UIImage(named:"metroPin") : UIImage(named: "Noncoveredstation"))
            marker.map = mapView
            marker.title = obj.fromStationName
            marker.userData = obj
            path.add(locationCordinate)
            arrMarker .append(marker)
            if i  == 0 {
                pathDifferentFrom.add(locationCordinate)
            }
        }
        if arr.count > 0 {
            let marker = GMSMarker()
            let locationCordinate = CLLocationCoordinate2D(latitude:Double(arr.last?.lat2 ?? "0") ?? 0, longitude:  Double(arr.last?.long2 ?? "0") ?? 0)
            marker.position = locationCordinate
            marker.icon = UIImage(named:"metroPin")
            marker.map = mapView
            marker.title = arr.last?.toStationName
            marker.userData = arr.last
            path.add(locationCordinate)
            arrMarker.append(marker)
            pathDifferentTO.add(locationCordinate)
        }
        if let obj = objJourney?.journeyPlannerStationDetail {
            let marker = GMSMarker()
            let locationCordinate = CLLocationCoordinate2D(latitude: Double(obj.decToStationLat ?? 0) , longitude:  Double(obj.decToStationLong ?? 0))
            marker.position = locationCordinate
            marker.icon = UIImage(named:"toStation")
            marker.map = mapView
            marker.title = obj.strToStationName
            marker.userData = obj
            pathDifferentTO.add(locationCordinate)
            arrMarker .append(marker)
            
        }
        let rectangle = GMSPolyline(path: path)
        rectangle.strokeWidth = 5
        rectangle.strokeColor = UIColor(hexString:"#339A4E")
        rectangle.map = mapView
        
        let rectanglefrom = GMSPolyline(path:pathDifferentFrom)
        rectanglefrom.strokeWidth = 5
        rectanglefrom.strokeColor = UIColor.blue.withAlphaComponent(0.5)
        rectanglefrom.map = mapView
        
        let rectangleTo = GMSPolyline(path:pathDifferentTO)
        rectangleTo.strokeWidth = 5
        rectangleTo.strokeColor = UIColor.blue.withAlphaComponent(0.5)
        rectangleTo.map = mapView
        
        
        
        self.tblView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        //  self.constTblViewHeight?.constant = self.tblView.contentSize.height
        
        print("height:",self.tblView.contentSize.height)
    }
    
    @IBAction func actionFavourites(_ sender: UIButton) {
        
        let strlocation = (objStation?.from_locationname ?? "") + "|" + (objStation?.to_locationname ?? "")
        
        let strLatLong = "\(objJourney?.journeyPlannerStationDetail?.decFromStationLat ?? 0)" + "," +
        "\(objJourney?.journeyPlannerStationDetail?.decFromStationLong  ?? 0)" + "|" +
        "\(objJourney?.journeyPlannerStationDetail?.decToStationLat  ?? 0)" + "," +
        "\(objJourney?.journeyPlannerStationDetail?.decToStationLong  ?? 0)"
        
        
        if btnFav.isSelected {
            objViewModel.deleteFavourite(strLocationLatLong:strLatLong, completionHandler: { sucess in
                self.btnFav.isSelected = false
            })
        }else {
            objViewModel.saveFavouriteStation(strLocationLatLong: strLatLong, strLocation: strlocation) { sucess in
                self.btnFav.isSelected = true
            }
        }
        
        
        
    }
    
    
    @IBAction func actionShare(_ sender: Any) {
        
        var metroNumber = objJourney?.transitPaths?.first?.routeno ?? ""
        if metroNumber.isEmpty  || metroNumber == "NA"  || metroNumber == "N/A" {
            metroNumber = "Mumbai Metro"
        }
        
        let strMessage = String(format: "\("travelling_inn".LocalizedString) %@ \("from".LocalizedString) %@  \("to".LocalizedString) %@,",metroNumber,objJourney?.journeyPlannerStationDetail?.strFromStationName ?? "",objJourney?.journeyPlannerStationDetail?.strToStationName ?? "")
        
        let activityViewController = UIActivityViewController(activityItems: [ strMessage ], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = []
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
//        if let firstPresented = UIStoryboard.ShareLocationVC() {
//            firstPresented.modalTransitionStyle = .crossDissolve
//            firstPresented.titleString = "sharebusdetails".LocalizedString
//            firstPresented.isSharephoto = false
//            firstPresented.isShareVoice = false
//            firstPresented.messageString = strMessage
//            firstPresented.isShowTrusedContacts = true
//            firstPresented.isShareLocation = true
//            firstPresented.topImage = #imageLiteral(resourceName: "shareLocation")
//            firstPresented.modalPresentationStyle = .overCurrentContext
//            APPDELEGATE.topViewController!.present(firstPresented, animated: false, completion: nil)
//        }
    }
    
    
    @IBAction func actionRefersh(_ sender: Any) {
        
    }
    @IBAction func actiobBookNow(_ sender: Any) {
        
        let vc = UIStoryboard.PaymentVC()
        vc?.objJourney = objJourney
        vc?.fromType  = .JourneyPlanner
        self.navigationController?.pushViewController(vc!, animated:true)
    }
    
    
    @IBAction func actionSelectMapView(_ sender: UIButton) {
        sender.isSelected  = !sender.isSelected
        if sender.isSelected == true {
            sender.setTitle("tv_listView".LocalizedString, for: .normal)
            mapView.isHidden = false
            tblView.isHidden  = true
            let buttonAbsoluteFrame = btnMapView.convert(btnMapView.bounds, to: self.view)
            let buttonPauNow = btnPayNow.convert(btnPayNow.bounds, to: self.view)
            self.constMapViewHeight.constant = buttonPauNow.origin.y - buttonAbsoluteFrame.origin.y - 70
            
            
            var bounds = GMSCoordinateBounds()
            let arr = objJourney?.transitPaths ?? [TransitPaths]()
            for obj in arr {
                let position = CLLocationCoordinate2D(latitude: ((obj.lat1 ?? "0") as? NSString)?.doubleValue ?? 0, longitude: ((obj.long1 ?? "0") as? NSString)?.doubleValue ?? 0)
                bounds = bounds.includingCoordinate(position)
            }
            
            if arr.count > 0 {
                let marker = GMSMarker()
                let position = CLLocationCoordinate2D(latitude:((arr.last?.lat2 ?? "0") as? NSString)?.doubleValue ?? 0, longitude:((arr.last?.long2 ?? "0") as? NSString)?.doubleValue ?? 0)
                arrMarker .append(marker)
            }
            let update = GMSCameraUpdate.fit(bounds, withPadding: 30.0)
            self.mapView.animate(with: update)
            DispatchQueue.main.async {
                self.mapView.animate(toZoom:11.5)
            }
           
        }else{
            sender.setTitle("mapview".LocalizedString, for: .normal)
            mapView.isHidden = true
            tblView.isHidden  = false
        }
    }
    func getFromStationImage()->UIImage? {
        if objJourney?.journeyPlannerStationDetail?.modeOfFromStationTravel == "T" {
            return UIImage(named: "Taxi")
        }
        else if objJourney?.journeyPlannerStationDetail?.modeOfFromStationTravel == "A" {
            return  UIImage(named: "Rickshaw")
        }else {
            return UIImage(named: "Walk")
        }
    }
    func getTOStationImage()->UIImage? {
        if objJourney?.journeyPlannerStationDetail?.modeOfToStationTravel == "A" {
            return UIImage(named: "Rickshaw")
        }
        else if objJourney?.journeyPlannerStationDetail?.modeOfToStationTravel == "T" {
            return UIImage(named: "Taxi")
        }else {
            return UIImage(named: "Walk")
        }
    }
    

}
extension PlanjourneyRouetDetailsVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier:"RouteDetailHeaderCell") as? RouteDetailHeaderCell else  { return UITableViewCell() }
                DispatchQueue.main.async {
                    self.tblView.layoutIfNeeded()
                }
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier:"JourneyPlannerRouteDetailCell") as? JourneyPlannerRouteDetailCell else  { return UITableViewCell() }
            cell.btnPrice .setTitle("Rs.\(objJourney?.journeyPlannerStationDetail?.fare ?? 0)", for: .normal)
            cell.lblStatioName.text = objJourney?.journeyPlannerStationDetail?.strFromStationName
            cell.lbltime.text =  (objJourney?.journeyPlannerStationDetail?.stationArrival ?? "").getCurrentDatewithDash().toString(withFormat:"hh:mm a")
            cell.btnPrice.setTitle("\(objJourney?.journeyPlannerStationDetail?.fare ?? 0) Rs.", for: .normal)
            cell.lbDistance.text = "\(objJourney?.journeyPlannerStationDetail?.km ?? 0) KM"
            cell.lblFromFare.text = "\(objJourney?.journeyPlannerStationDetail?.fareOfFromStationTravel ?? 0) Rs"
            cell.lblfromDistance.text = "\(objJourney?.journeyPlannerStationDetail?.fromStationWalkDistance ?? 0) KM"
            cell.lblToFare.text = "\(objJourney?.journeyPlannerStationDetail?.fareOfToStationTravel ?? 0) Rs"
            cell.lblToDistance.text = "\(objJourney?.journeyPlannerStationDetail?.toStationWalkDistance ?? 0) KM"
            
            if objJourney?.journeyPlannerStationDetail?.fareOfFromStationTravel ?? 0 < 1 {
                cell.lblFromFare.isHidden = true
            }
            
            if objJourney?.journeyPlannerStationDetail?.fareOfToStationTravel ?? 0 < 1 {
                cell.lblToFare.isHidden = true
            }
            
            cell.imgStartWalk.image = self.getFromStationImage()
            cell.imgEndWalk.image = self.getTOStationImage()
            
            if let obj = objJourney?.journeyPlannerStationDetail?.endingMYBYKPath {
                cell.lblTOSTation1.text = obj.strFromMYBYKStationName ?? ""
                cell.lblTOSTation2.text = obj.strToMYBYKStationName ?? ""
                cell.lblToDistance.text =  String(format:"%0.2f", obj.decFromMYBYKStationDistance ?? 0) + " KM"
                cell.lblTODistance1.text = String(format:"%0.2f", obj.decFrom_ToMYBYKStationDistance ?? 0) + " KM"
                cell.lblTODistance2.text = String(format:"%0.3f", obj.decToMYBYKStationDistance ?? 0) + " KM"
                
                cell.lblTOTime1.text =  (obj.strFromHubArrival ?? "").getCurrentDatewithDash().toString(withFormat:"hh:mm a")
                cell.lblTOTime2.text =  (obj.strToHubArrival ?? "").getCurrentDatewithDash().toString(withFormat:"hh:mm a")
            }else {
                cell.lblTOSTation1.superview?.superview?.superview?.isHidden = true
                cell.lblTOSTation2.superview?.superview?.superview?.isHidden = true
            }
            
            if let obj = objJourney?.journeyPlannerStationDetail?.startingMYBYKPath {
                cell.lblFromSTation1.text = obj.strFromMYBYKStationName ?? ""
                cell.lblFromSTation2.text = obj.strToMYBYKStationName ?? ""
                cell.lblfromDistance.text =  String(format:"%0.2f", obj.decFromMYBYKStationDistance ?? 0) + " KM"
                cell.lblFromDistance1.text = String(format:"%0.2f", obj.decFrom_ToMYBYKStationDistance ?? 0) + " KM"
                cell.lblFromDistance2.text = String(format:"%0.3f", obj.decToMYBYKStationDistance ?? 0) + " KM"
                
                cell.lblFromTime1.text =  (obj.strFromHubArrival ?? "").getCurrentDatewithDash().toString(withFormat:"hh:mm a")
                cell.lblFromTime2.text =  (obj.strToHubArrival ?? "").getCurrentDatewithDash().toString(withFormat:"hh:mm a")
            }else {
                cell.lblFromSTation1.superview?.superview?.superview?.isHidden = true
                cell.lblFromSTation2.superview?.superview?.superview?.isHidden = true
            }
            
            
//            if objJourney?.journeyPlannerStationDetail?.modeOfFromStationTravel == "T" {
//                cell.imgStartWalk.image = UIImage(named: "Taxi")
//            }
//            else if objJourney?.journeyPlannerStationDetail?.modeOfFromStationTravel == "A" {
//                cell.imgStartWalk.image = UIImage(named: "Rickshaw")
//            }
//
//            if objJourney?.journeyPlannerStationDetail?.modeOfToStationTravel == "A" {
//                cell.imgEndWalk.image = UIImage(named: "Rickshaw")
//            }
//            else if objJourney?.journeyPlannerStationDetail?.modeOfToStationTravel == "T" {
//                cell.imgEndWalk.image = UIImage(named: "Taxi")
//            }
            
            
            cell.lblVehchcileStatus.text = "strNotArrived".LocalizedString
            cell.lblToStatus.text = "strNotArrived".LocalizedString
            cell.imgViewLine.tintColor = UIColor.blue
            cell.imgViewToLine.tintColor = UIColor.blue
            if objJourney?.transitPaths?.first?.bCovered1 == "1" {
                cell.btnNotify.superview?.isHidden = true
                cell.lblVehchcileStatus.text = "strArrived".LocalizedString
                cell.imgViewLine.tintColor = UIColor.greenColor
            }
        
            cell.btnNotify.backgroundColor = UIColor.white
            cell.btnNotify .setTitleColor(UIColor.greenColor, for: .normal)
            cell.btnToNOtify.backgroundColor = UIColor.white
            cell.btnToNOtify .setTitleColor(UIColor.greenColor, for: .normal)
            if objJourney?.transitPaths?.first?.bNotify1 ?? false {
                cell.btnNotify.backgroundColor =  UIColor.greenColor
                cell.btnNotify.setTitleColor(UIColor.white, for: .normal)
            }
            
            
            let arrOriginal = objJourney?.transitPaths ?? [TransitPaths]()
            var arrNew = objJourney?.transitPaths ?? [TransitPaths]()
            if arrNew.count > 0 {
                arrNew.removeFirst()
            }
            cell.arrOriginal = objJourney?.transitPaths ??  [TransitPaths]()
            cell.lblToStation.text = arrOriginal.last?.toStationName
            cell.lblToTime.text =  (arrOriginal.last?.etaNode2 ?? "").getCurrentDatewithDash().toString(withFormat:"hh:mm a")
            if arrOriginal.last?.bCovered2 == "1" {
                cell.btnToNOtify.superview?.isHidden = true
                cell.lblToStatus.text = "strArrived".LocalizedString
                cell.imgViewToLine.tintColor = UIColor.greenColor
            }
            if arrOriginal.last?.bNotify2 ?? false {
                cell.btnToNOtify.backgroundColor =  UIColor.greenColor
                cell.btnToNOtify.setTitleColor(UIColor.white, for: .normal)
            }
            cell.arrRoutePaths = arrNew
            cell.lblFromStation.text = objStation?.from_locationname
            cell.lblMainToStation.text = objStation?.to_locationname
            cell.btnNotify.tag = 0
//            cell.btnNotify.tag = indexPath.row
            DispatchQueue.main.async {
                self.constTblViewHeight.constant = tableView.contentSize.height
            }
            tblView.layoutIfNeeded()
            cell.completionBlockData = {
                DispatchQueue.main.async {
                    self.tblView.beginUpdates()
                    self.tblView.endUpdates()
                    print("height:",self.tblView.contentSize.height)
                    self.constTblViewHeight.constant = self.tblView.contentSize.height
                    print("height11:",self.tblView.contentSize.height)
                    self.scrollview.layoutIfNeeded()
                    self.scrollview.contentSize = self.scrollview.subviews.reduce(CGRect.zero, {
                        return $0.union($1.frame)
                    }).size
                    
                    DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.3, execute:{
                        self.tblView.beginUpdates()
                        self.tblView.endUpdates()
                        self.constTblViewHeight.constant = self.tblView.contentSize.height
                        self.scrollview.layoutIfNeeded()
                        self.scrollview.contentSize = self.scrollview.subviews.reduce(CGRect.zero, {
                            return $0.union($1.frame)
                        }).size
                    })
                }
            }
            
            cell.completionBlockNotify = { obj in
                if let obj = obj {
                    let root = UIWindow.key?.rootViewController!
                    if let firstPresented = UIStoryboard.ReminderVC() {
                        firstPresented.obj = obj
                        firstPresented.routeid = obj.routeid
                        firstPresented.tripID = obj.tripId
                        firstPresented.modalTransitionStyle = .crossDissolve
                        firstPresented.modalPresentationStyle = .overCurrentContext
                        root?.present(firstPresented, animated: false, completion: nil)
                        
                    }
                }
            }
            cell.btnToNOtify
            cell.completionBlockOFAlternatives = {
               
//                let root = UIWindow.key?.rootViewController!
//                if let firstPresented = UIStoryboard.AlertaltivesVC() {
//                    firstPresented.modalTransitionStyle = .crossDissolve
//                    firstPresented.modalPresentationStyle = .overCurrentContext
//                    root?.present(firstPresented, animated: false, completion: nil)
//                }
            }
            
            
            
            
//            cell.isShowTable = { isShow in
//                self.constTblViewHeight.constant = self.tblView.contentSize.height
//                self.tblView.layoutIfNeeded()
//                self.tblView.beginUpdates()
//                self.tblView.endUpdates()
//            }
           
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        self.viewWillLayoutSubviews()
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = UIStoryboard.RoueDetailVC()
//        self.navigationController?.pushViewController(vc!, animated:true)
        
    }
    
    
}
