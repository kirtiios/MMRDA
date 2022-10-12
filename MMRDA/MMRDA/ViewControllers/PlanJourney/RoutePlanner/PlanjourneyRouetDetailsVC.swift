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
        let barButton = UIBarButtonItem(image: UIImage(named:"back"), style:.plain, target: self, action: #selector(btnActionBackClicked))
        barButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = barButton
        
       // self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"routedetail".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        lblFromStation.text = objJourney?.journeyPlannerStationDetail?.strFromStationName
        lblToStation.text = objJourney?.journeyPlannerStationDetail?.strToStationName
        lblStatus.text = objJourney?.journeyPlannerStationDetail?.strToStationName
        arrRoutes = objJourney?.transitPaths
        
        self .refreshandAddMarker()
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
        self.navigationController?.popToRootViewController(animated: true)
    }
    func refreshandAddMarker(){
        let arr = objJourney?.transitPaths ?? [TransitPaths]()
        let path = GMSMutablePath()
        arrMarker .removeAll()
        
        for  i in 0..<arr.count {
            let obj = arr[i]
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: ((obj.lat1 ?? "0") as? NSString)?.doubleValue ?? 0, longitude: ((obj.long1 ?? "0") as? NSString)?.doubleValue ?? 0)
            marker.icon = UIImage(named:"metroPin")
            marker.map = mapView
            marker.title = obj.fromStationName
            marker.userData = obj
            path.add(CLLocationCoordinate2D(latitude: ((obj.lat1 ?? "0") as? NSString)?.doubleValue ?? 00, longitude: ((obj.long1 ?? "0") as? NSString)?.doubleValue ?? 0))
            
            arrMarker .append(marker)
            // bounds = bounds.includingCoordinate(marker.position)
            
        }
        if arr.count > 0 {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude:((arr.last?.lat2 ?? "0") as? NSString)?.doubleValue ?? 0, longitude: ((arr.last?.long2 ?? "0") as? NSString)?.doubleValue ?? 0)
            marker.icon = UIImage(named:"metroPin")
            marker.map = mapView
            marker.title = arr.last?.fromStationName
            marker.userData = arr.last
            path.add(CLLocationCoordinate2D(latitude:((arr.last?.lat2 ?? "0") as? NSString)?.doubleValue ?? 00, longitude: ((arr.last?.long2 ?? "0") as? NSString)?.doubleValue ?? 0))
            
            arrMarker .append(marker)
        }
        let rectangle = GMSPolyline(path: path)
        rectangle.strokeWidth = 5
        rectangle.strokeColor = UIColor(hexString: "#339A4E")
        rectangle.map = mapView
        
        
        
        self.tblView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
      //  self.constTblViewHeight?.constant = self.tblView.contentSize.height
        
        print("height:",self.tblView.contentSize.height)
    }

    @IBAction func actionFavourites(_ sender: UIButton) {
        
        let strlocation = (objJourney?.journeyPlannerStationDetail?.strFromStationName ?? "") + "|" + (objJourney?.journeyPlannerStationDetail?.strToStationName ?? "")
        
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
        
        let strMessage = String(format: "\("travelling_inn".LocalizedString) %@ \("from".LocalizedString) %@  \("to".LocalizedString) %@,",  objJourney?.transitPaths?.first?.routeno ?? "",objJourney?.journeyPlannerStationDetail?.strFromStationName ?? "",objJourney?.journeyPlannerStationDetail?.strToStationName ?? "")
        
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
                let position = CLLocationCoordinate2D(latitude:((arr.last?.lat2 ?? "0") as? NSString)?.doubleValue ?? 0, longitude: ((arr.last?.long2 ?? "0") as? NSString)?.doubleValue ?? 0)
                arrMarker .append(marker)
            }
            let update = GMSCameraUpdate.fit(bounds, withPadding: 30.0)
            self.mapView.animate(with: update)
        }else{
            sender.setTitle("mapview".LocalizedString, for: .normal)
            mapView.isHidden = true
            tblView.isHidden  = false
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
            
            cell.lblTripStatus.text = "Not Arrived"
            cell.lblToStatus.text = "Not Arrived"
            cell.imgViewLine.tintColor = UIColor.blue
            cell.imgViewToLine.tintColor = UIColor.blue
            if objJourney?.transitPaths?.first?.bCovered1 == "1" {
                cell.btnNotify.superview?.isHidden = true
                cell.lblTripStatus.text = "Covered"
                cell.imgViewLine.tintColor = UIColor.greenColor
            }
            
           
          
            let arrOriginal = objJourney?.transitPaths ?? [TransitPaths]()
            
            var arrNew = objJourney?.transitPaths ?? [TransitPaths]()
            if arrNew.count > 0 {
                arrNew.removeFirst()
//                var obj = arrNew.last
//                obj?.fromStationName = arrNew.last?.toStationName
//                obj?.lat1 = arrNew.last?.lat2
//                obj?.bCovered1 = arrNew.last?.bCovered2
//                obj?.long1 = arrNew.last?.long2
//                obj?.etaNode1 = arrNew.last?.etaNode2
//                if let obj = obj {
//                    arrNew .append(obj)
//                }
            }
            cell.arrOriginal = objJourney?.transitPaths ??  [TransitPaths]()
            cell.lblToStation.text = arrOriginal.last?.toStationName
            cell.lblToTime.text =  (arrOriginal.last?.etaNode2 ?? "").getCurrentDatewithDash().toString(withFormat:"hh:mm a")
            if arrOriginal.last?.bCovered2 == "1" {
                cell.btnToNOtify.superview?.isHidden = true
                cell.lblToStatus.text = "Covered"
                cell.imgViewToLine.tintColor = UIColor.greenColor
            }
            cell.arrRoutePaths = arrNew
            cell.lblFromStation.text = objStation?.from_locationname
            cell.lblMainToStation.text = objStation?.to_locationname
            cell.btnNotify.tag = indexPath.row
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
                }
            }
            
            cell.completionBlockNotify = { obj in
                // OPEN REMIDENR VC
                
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
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = UIStoryboard.RoueDetailVC()
//        self.navigationController?.pushViewController(vc!, animated:true)
        
    }
    
    
}
