//
//  RoueDetailVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 24/08/22.
//

import UIKit
import GoogleMaps

class RoueDetailVC: BaseVC {
    
    var timer:Timer?
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var lblRouteNo: UILabel!
    @IBOutlet weak var lblDestinationValue: UILabel!
    @IBOutlet weak var lblSourceValue: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblVehcileNumber: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var constTblviewHeight: NSLayoutConstraint!
    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var lblUpdateTime: UILabel!
    @IBOutlet weak var btnRefresh: UIButton!
    @IBOutlet weak var btnPayNow: UIButton!
    @IBOutlet weak var constMapViewHeight: NSLayoutConstraint!
    @IBOutlet var btnShowPopup:UIButton!
    var objStation:StationListModel?
    var objFromStation:FareStationListModel?
    private var objViewModel = RouteDetailModelView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"routedetail".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
	        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
        tblView.tableHeaderView = UIView(frame: frame)
        
        lblSourceValue.text = objStation?.arrRouteData?.first?.strSourceName
        lblDestinationValue.text = objStation?.arrRouteData?.first?.strDestinationName
        lblRouteNo.text =  objStation?.arrRouteData?.first?.strMetroLineNo
        lblVehcileNumber.text =  objStation?.arrRouteData?.first?.strMetroNo
        btnFav.isSelected =  objStation?.arrRouteData?.first?.isFavorite ?? false
        
        lblStatus.text =  (objStation?.intTripStatus == 0 ? "scheduled_label".localized() : "running_buses".localized())
        
        lblUpdateTime.text  = objStation?.dteLastUpdatedAt
        
        objViewModel.delegate = self
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
        self.refreshandAddMarker()
//        timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { timer in
//            self.btnRefresh .sendActions(for:.touchUpInside)
//        }
        
      
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { timer in
            self.btnRefresh .sendActions(for:.touchUpInside)
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
 //   "decStationLong": "72.85880456085309", "strStationName": "", "decCurrentLong": 72.8777, "decStationLat": "19.16935560914488", "UserID": 215, "decCurrentLat": 19.076
    
   

    func refreshandAddMarker(){
        let arr = objStation?.arrRouteData?.first?.arrStationData ?? [ArrStationData]()
        let path = GMSMutablePath()
        for  i in 0..<arr.count {
            let obj = arr[i]
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: obj.decStationLat ?? 0, longitude: obj.decStationLong ?? 0)
            marker.icon = UIImage(named:"metroPin")
            marker.map = mapView
            marker.title = obj.strStationName
            marker.userData = obj
            path.add(CLLocationCoordinate2D(latitude: obj.decStationLat ?? 0, longitude: obj.decStationLong ?? 0))
        }
        let rectangle = GMSPolyline(path: path)
        rectangle.strokeWidth = 5
        rectangle.strokeColor = UIColor(hexString: "#339A4E")
        rectangle.map = mapView
        self.tblView.reloadData()
        btnShowPopup.isHidden = true
    }
    
    @IBAction func actionMapView(_ sender: UIButton) {
        sender.isSelected  = !sender.isSelected
        if sender.isSelected == true {
            sender.setTitle("tv_listView".LocalizedString, for: .normal)
            mapView.isHidden = false
            tblView.isHidden  = true
            let buttonAbsoluteFrame = btnRefresh.convert(btnRefresh.bounds, to: self.view)
            let buttonPauNow = btnPayNow.convert(btnPayNow.bounds, to: self.view)
            self.constMapViewHeight.constant = buttonPauNow.origin.y - buttonAbsoluteFrame.origin.y - 70
            let arr = objStation?.arrRouteData?.first?.arrStationData ?? [ArrStationData]()
            var bounds = GMSCoordinateBounds()
            for  i in 0..<arr.count {
                let obj = arr[i]
                let position = CLLocationCoordinate2D(latitude: obj.decStationLat ?? 0, longitude: obj.decStationLong ?? 0)
                bounds = bounds.includingCoordinate(position)
            }
            let update = GMSCameraUpdate.fit(bounds, withPadding: 30.0)
            mapView.animate(with: update)
            btnShowPopup.isHidden = true
        }else{
            sender.setTitle("mapview".LocalizedString, for: .normal)
            mapView.isHidden = true
            tblView.isHidden  = false
            btnShowPopup.isHidden = true
        }
        
    }
    @IBAction func btnShowBtnClick(_ sender: UIButton) {
        let vc = InformationVC()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func actionRefresh(_ sender: UIButton) {
//        self.lblUpdateTime.text  = Date().toString(withFormat: "dd-MM-yyyy hh:mm a")
        self.objViewModel.getRefreshStation(intTripID:String(objStation?.intTripID ?? 0))
        
    }
    
    
    @IBAction func actionShare(_ sender: Any) {
        
        var metroNumber = objStation?.arrRouteData?.first?.strMetroNo ?? ""
        if metroNumber.isEmpty  || metroNumber == "NA" || metroNumber == "N/A" {
            metroNumber = "Mumbai Metro"
        }
       
        let strMessage = String(format: "\("travelling_inn".LocalizedString) %@ \("from".LocalizedString) %@  \("to".LocalizedString) %@,", metroNumber ,objStation?.arrRouteData?.first?.strSourceName ?? "",objStation?.arrRouteData?.first?.strDestinationName ?? "")
        // set up activity view controller
        let activityViewController = UIActivityViewController(activityItems: [ strMessage ], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = []
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
//            if let firstPresented = UIStoryboard.ShareLocationVC() {
//                firstPresented.modalTransitionStyle = .crossDissolve
//                firstPresented.titleString = "sharebusdetails".LocalizedString
//                firstPresented.isSharephoto = false
//                firstPresented.isShareVoice = false
//                firstPresented.messageString = strMessage
//                firstPresented.isShowTrusedContacts = true
//                firstPresented.isShareLocation = true
//                firstPresented.topImage = #imageLiteral(resourceName: "shareLocation")
//                firstPresented.modalPresentationStyle = .overCurrentContext
//                APPDELEGATE.topViewController!.present(firstPresented, animated: false, completion: nil)
//            }
        
        
        
    }
    @IBAction func actionFavourite(_ sender: Any) {
        if btnFav.isSelected {
            objViewModel.deleteFavourite(routeid: "\(objStation?.arrRouteData?.first?.intRouteID ?? 0)", completionHandler: { sucess in
                self.btnFav.isSelected = false
            })
        }else {
            objViewModel.saveFavouriteStation(routeid:"\(objStation?.arrRouteData?.first?.intRouteID ?? 0)", completionHandler: { sucess in
                self.btnFav.isSelected = true
            })
        }
      
        
    }
    
    
    @IBAction func actionBookNow(_ sender: Any) {
        let vc = UIStoryboard.PaymentVC()
        vc?.objStation = objStation
        vc?.objFromStation = objFromStation
        self.navigationController?.pushViewController(vc!, animated:true)
    }
}

extension RoueDetailVC :UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return objStation?.arrRouteData?.first?.arrStationData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier:"RouteDetailHeaderCell") as? RouteDetailHeaderCell else  { return UITableViewCell() }
            DispatchQueue.main.async {
                self.constTblviewHeight.constant = tableView.contentSize.height + 30
                self.tblView.layoutIfNeeded()
            }
            
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier:"RouteDetailCell") as? RouteDetailCell else  { return UITableViewCell() }
            constTblviewHeight.constant = tblView.contentSize.height
            cell.indexpath = indexPath
            let obj = objStation?.arrRouteData?.first?.arrStationData?[indexPath.row]
            cell.lblStatioName.text = obj?.strStationName
            cell.lblTime.text = obj?.strETA?.getCurrentDatewithDay().toString(withFormat: "hh:mm a")
            cell.btnNotify.superview?.isHidden = false
            cell.lblStatus.text = "strNotArrived".LocalizedString
            cell.btnNotify.layer.borderColor = UIColor.greenColor.cgColor
            cell.btnNotify.layer.borderWidth = 1
            if obj?.bNotify ?? false {
                cell.btnNotify.backgroundColor =  UIColor.greenColor
                cell.btnNotify.setTitleColor(UIColor.white, for: .normal)
            }else {
                if obj?.bNotificationSent == true{
                    cell.btnNotify.backgroundColor =  UIColor.greenColor
                    cell.btnNotify.setTitleColor(UIColor.white, for: .normal)
                }else{
                    cell.btnNotify.backgroundColor = UIColor.white
                    cell.btnNotify .setTitleColor(UIColor.greenColor, for: .normal)
                }
            }
            cell.imgViewLine.tintColor = UIColor.blue
            cell.imgview.image = UIImage(named: "CenterPinGreen")
          
            if obj?.bCovered ?? 0 == 1 {
                cell.btnNotify.superview?.isHidden = true
                cell.lblStatus.text = "strArrived".LocalizedString
                cell.imgViewLine.tintColor =  UIColor.greenColor
                cell.imgview.tintColor = UIColor.greenColor
                cell.imgview.image = UIImage(named:"centerFillGreen")
            }
            
            
           
            if indexPath.row == 0 || indexPath.row == (objStation?.arrRouteData?.first?.arrStationData?.count ?? 0) - 1 {
                cell.imgview.image = UIImage(named: "metroRoute")
            }
            cell.imgViewLine.isHidden = false
            if indexPath.row == (objStation?.arrRouteData?.first?.arrStationData?.count ?? 0) - 1 {
                cell.imgViewLine.isHidden = true
            }
            cell.completionBlock = { indexpath  in
                // OPEN REMIDENR VC
                
                if let indexpath = indexpath {
                    let root = UIWindow.key?.rootViewController!
                    if let firstPresented = UIStoryboard.ReminderVC() {
                        firstPresented.obj = self.objStation?.arrRouteData?.first?.arrStationData?[indexpath.row]
                        firstPresented.routeid = self.objStation?.arrRouteData?.first?.intRouteID
                        firstPresented.tripID = self.objStation?.intTripID
                        firstPresented.indexpath = indexpath
                        firstPresented.completionNotifyDone = { indexpath in
                            if let index = indexpath {
                                self.objStation?.arrRouteData?[0].arrStationData?[index.row].bNotify = true
                                self.tblView.reloadData()
                                //sdfsd
                                
                                let firstPresented = AlertViewVC(nibName:"AlertViewVC", bundle: nil)
                                firstPresented.strMessage = "sucess_reminder".LocalizedString
                                firstPresented.img = UIImage(named:"Success")!
                                firstPresented.isHideCancel = true
                                firstPresented.okButtonTitle = "ok".LocalizedString
                                firstPresented.completionOK = {
                                    self.dismiss(animated: true) {
                                    }
                                }
                                firstPresented.modalTransitionStyle = .crossDissolve
                                firstPresented.modalPresentationStyle = .overCurrentContext
                                APPDELEGATE.topViewController!.present(firstPresented, animated: true, completion: nil)
                                
                                
                            }
                        }
                        firstPresented.completionNotifyRemove = { indexpath in
                            if let index = indexpath {
                                self.objStation?.arrRouteData?[0].arrStationData?[index.row].bNotify = false
                                self.tblView.reloadData()
                                
                                self.btnRefresh.sendActions(for: .touchUpInside)
                                //sdfsd
                                
                                let firstPresented = AlertViewVC(nibName:"AlertViewVC", bundle: nil)
                                firstPresented.strMessage = "removeReminder".LocalizedString
                                firstPresented.img = UIImage(named:"Success")!
                                firstPresented.isHideCancel = true
                                firstPresented.okButtonTitle = "ok".LocalizedString
                                firstPresented.completionOK = {
                                    self.dismiss(animated: true) {
                                        
                                    }
                                }
                                firstPresented.modalTransitionStyle = .crossDissolve
                                firstPresented.modalPresentationStyle = .overCurrentContext
                                APPDELEGATE.topViewController!.present(firstPresented, animated: true, completion: nil)
                                
                                
                            }
                        }
                        firstPresented.modalTransitionStyle = .crossDissolve
                        firstPresented.modalPresentationStyle = .overCurrentContext
                        root?.present(firstPresented, animated: false, completion: nil)
                        
                    }
                }
            }
            tblView.layoutIfNeeded()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = UIStoryboard.RoueDetailVC()
//        self.navigationController?.pushViewController(vc!, animated:true)
        
    }
    
    
}
extension RoueDetailVC:ViewcontrollerSendBackDelegate {
    func getInformatioBack<T>(_ handleData: inout T) {
        if let data = handleData as? [StationListModel] {
            objStation = data.first
            self.lblUpdateTime.text = objStation?.dteLastUpdatedAt
            
            self.refreshandAddMarker()
        }
        
    }
}
