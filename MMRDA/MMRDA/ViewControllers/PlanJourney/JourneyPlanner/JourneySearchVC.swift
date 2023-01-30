//
//  JourneySerarchVC.swift
//  MMRDA
//
//  Created by Kirti Chavda on 24/08/22.
//

import UIKit
import CoreLocation

struct planeStation: Codable {
    var locationname: String
    var latitude: Double
    var longitude: Double
}

struct RecentPlaneStation: Codable {
    var from_locationname: String
    var from_latitude: Double
    var from_longitude: Double
    
    var to_locationname: String
    var to_latitude: Double
    var to_longitude: Double
}

class JourneySearchVC: BaseVC {

    @IBAction func btnActionCurrentClicked(_ sender: UIButton) {
        LocationManager.sharedInstance.getCurrentLocation { success, location in
            if success {
                LocationManager.sharedInstance.getaddessFromLatLong(coords:CLLocationCoordinate2D(latitude: LocationManager.sharedInstance.currentLocation.coordinate.latitude, longitude: LocationManager.sharedInstance.currentLocation.coordinate.longitude)) { address in
                    self.objFrom = planeStation(locationname: address, latitude: LocationManager.sharedInstance.currentLocation.coordinate.latitude, longitude: LocationManager.sharedInstance.currentLocation.coordinate.longitude)
                }
            }
               
        }
        
    }
    @IBOutlet weak var btnSwitch: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnTo: UIButton!
    @IBOutlet weak var btnFrom: UIButton!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var lblNotFound: UILabel!
    var objTo:planeStation? {
        didSet {
            btnTo.setTitle(objTo?.locationname, for: .normal)
        }
    }
    var objFrom:planeStation? {
        didSet {
            btnFrom.setTitle(objFrom?.locationname, for: .normal)
        }
    }
    var arrRecentData = [RecentPlaneStation]() {
        didSet {
            self.tableview.reloadData()
        }
    }
   // var arrRecentLocation = [String:any]()
    private var  objViewModel = JourneyPlannerModelView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       // self.callBarButtonForHome(isloggedIn:true,leftBarLabelName:"Plan_Journey".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        
        self.setRightHomeButton()
        self.setBackButton()
        self.navigationItem.title = "Plan_Journey".localized()
        
        self.tableview.register(UINib(nibName:"cellRecentSearch", bundle: nil), forCellReuseIdentifier: "cellRecentSearch")
        self.tableview.rowHeight = UITableView.automaticDimension
        self.tableview.estimatedRowHeight = 50
        
        btnTo.titleLabel?.numberOfLines = 2
        btnFrom.titleLabel?.numberOfLines = 2
        if let savedPerson = UserDefaults.standard.object(forKey: userDefaultKey.journeyPlannerList.rawValue) as? Data {
            if let loadedPerson = try? JSONDecoder().decode([RecentPlaneStation].self, from: savedPerson) {
               arrRecentData = loadedPerson
            }
        }
        
        
        objViewModel.delegate = self
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.view.hideToastActivity()
                    self?.view.makeToast(message)
                }
            }
        }
        
        btnFrom .setTitle("select_from_location".localized(), for: .normal)
        btnTo .setTitle("select_to_location".localized(), for: .normal)
        
       
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnActionClicked(_ sender: UIButton) {
        
        if sender == btnSearch {
            
        
            if objFrom == nil   {
                objViewModel.inputErrorMessage.value = "tv_validate_from".localized()
            }
            else  if objTo == nil {
                objViewModel.inputErrorMessage.value = "tv_validate_to".localized()
            }else {
                
                var param = [String:Any]()
                param["intUserID"] = Helper.shared.objloginData?.intUserID
                param["decFromStationLat"] =  "\(objFrom?.latitude ?? 0)"
                param["decFromStationLong"] =   "\(objFrom?.longitude ?? 0)"
                param["decToStationLat"] =  "\(objTo?.latitude ?? 0)"
                param["decToStationLong"] =  "\(objTo?.longitude ?? 0)"
                param["strStationName"] =  ""
                
                
                let objplanner = RecentPlaneStation(from_locationname: objFrom?.locationname ?? "", from_latitude: objFrom?.latitude ?? 0, from_longitude: objFrom?.longitude ?? 0, to_locationname: objTo?.locationname ?? "", to_latitude: objTo?.latitude ?? 0, to_longitude: objTo?.longitude ?? 0)
                let obj = self.arrRecentData.first { objdata in
                    return objdata.from_locationname.lowercased() == objFrom?.locationname.lowercased()  && objdata.to_locationname.lowercased() == objTo?.locationname.lowercased()
                }
                
                if obj == nil {
                    arrRecentData.insert(objplanner, at: 0)
                }else {
                    self.arrRecentData.removeAll { objdata in
                        return objdata.from_locationname.lowercased() == objFrom?.locationname.lowercased()  && objdata.to_locationname.lowercased() == objTo?.locationname.lowercased()
                    }
                    arrRecentData.insert(objplanner, at: 0)
                }
                if arrRecentData.count > 5 {
                    arrRecentData.removeLast()
                }
                
                if let encoded = try? JSONEncoder().encode(arrRecentData) {
                    UserDefaults.standard.set(encoded, forKey: userDefaultKey.journeyPlannerList.rawValue)
                    UserDefaults.standard.synchronize()
                }
                objViewModel.getJourneyPlanner(param: param) { array in
                    let vc =  UIStoryboard.JourneyPlannerStationListingVC()
                    vc.objStation = objplanner
                    vc.arrData = array ?? [JourneyPlannerModel]()
                    self.navigationController?.pushViewController(vc, animated:true)
                }
            }
            
            
        }else if sender == btnSwitch {
            
            if objFrom == nil  && objTo == nil {
                self.objViewModel.inputErrorMessage.value = "please_select_from_and_to_stations_to_swipe".localized()
                return
            }
            btnFrom .setTitle(nil, for: .normal)
            btnTo .setTitle(nil, for: .normal)
            let obj1 = objFrom
            let obj2 = objTo
            if let obj = obj1 {
                btnTo .setTitle(obj.locationname, for: .normal)
                objTo = obj
            }
            if let obj = obj2 {
                btnFrom .setTitle(obj.locationname, for: .normal)
                objFrom = obj
            }
        }
        else {
            
            let vc = UIStoryboard.ChooseOrginVC()
            vc.arrRecentData = arrRecentData
            vc.objParent = self
            vc.completionBlock = { obj in
                sender .setTitle(obj.locationname, for: .normal)
                if sender == self.btnFrom {
                    self.objFrom = obj
                }else if sender == self.btnTo {
                    self.objTo = obj
                }
                    
            }
            self.navigationController?.pushViewController(vc, animated:true)
        }
    }
}

extension JourneySearchVC:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell : FavouriteHeaderCell = tableView.dequeueReusableCell(withIdentifier: "FavouriteHeaderCell") as! FavouriteHeaderCell
        cell.tag = section
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.lblHeaderName.text = "recentsearch".LocalizedString
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        lblNotFound.isHidden = true
        if arrRecentData.count < 1 {
            lblNotFound.isHidden = false
        }
        return arrRecentData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellRecentSearch", for: indexPath) as! cellRecentSearch
        let objdata = arrRecentData[indexPath.row]
        cell.lblFromStation.text = objdata.from_locationname
        cell.lblToStation.text = objdata.to_locationname
      
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let objData = arrRecentData[indexPath.row]
        
        objFrom = planeStation(locationname: objData.from_locationname, latitude: objData.from_latitude, longitude:objData.from_longitude)
        objTo = planeStation(locationname:objData.to_locationname, latitude: objData.to_latitude, longitude:objData.to_longitude)
        

    }
}
extension JourneySearchVC:ViewcontrollerSendBackDelegate {
    func getInformatioBack<T>(_ handleData: inout T) {
//        if let data = handleData as? [favouriteList] {
//            arrfavList = data
//        }
//        if let data = handleData as? [Predictions] {
//            arrPreditction = data
//        }
//        if let data = handleData as? [attractionSearchDisplay] {
//            arrSearchDsiplayData = data
//        }
    }
}
