//
//  StationListingVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 22/08/22.
//

import UIKit

enum listType:Int {
    case schedule = 1
    case Running = 2
}

class StationListingVC: BaseVC {
    
    @IBOutlet weak var segmentViewRunning: UIView!
    @IBOutlet weak var segmentViewScheDule: UIView!
    @IBOutlet weak var lblNoDataFound: UILabel!
    @IBOutlet weak var segmentRunning: UIButton!
    @IBOutlet weak var sgementSchedule: UIButton!
    @IBOutlet weak var tableview: UITableView!
    var objStation:FareStationListModel?
    var timeID:Int?
    var arrStationList:[StationListModel]?{
        didSet{
            self.tableview.reloadData()
        }
    }
    var arrAllStationList:[StationListModel]?
    
    var listtype :listType = .schedule
 
    private let objViewModel  = StationListingViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        initalize()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.getStationList(time:timeID ?? 0)
    }
    
    
    // MARK:  Action SEGMENT CHANGE
    @IBAction func actionSegmentChange(_ sender:UIButton) {
        if sender.tag == 101 { // Schedule
            segmentViewScheDule.backgroundColor = Colors.APP_Theme_color.value
            segmentViewRunning.backgroundColor = UIColor.lightGray
            sgementSchedule.setTitleColor(Colors.APP_Theme_color.value, for:.normal)
            segmentRunning.backgroundColor = UIColor.white
            segmentRunning.setTitleColor(UIColor.gray, for:.normal)
            listtype = .schedule
            
        }else { // Running
            segmentViewRunning.backgroundColor = Colors.APP_Theme_color.value
            segmentViewScheDule.backgroundColor = UIColor.lightGray
            segmentRunning.setTitleColor(Colors.APP_Theme_color.value, for:.normal)
            segmentRunning.backgroundColor = UIColor.white
            sgementSchedule.setTitleColor(UIColor.gray, for:.normal)
            listtype = .Running
        }
        
        arrStationList = arrAllStationList?.filter({ obj in
            let num = self.listtype == .schedule ? 0 : 1
            return (obj.intTripStatus ?? 0) ==  num
        })
        
    }
    
    
    @IBAction func actionbAroundTheStop(_ sender: Any) {
        let objAttraction = AttractionVC(nibName: "AttractionVC", bundle: nil)
        objAttraction.fromAction = .station
        objAttraction.objStation = objStation
        self.navigationController?.pushViewController(objAttraction, animated: true)
    }
    
    @IBAction func actionFavourites(_ sender: Any) {
        self.objViewModel.saveFavouriteStation(stationid:"\(objStation?.stationid ?? 0)")
    }
}


extension StationListingVC {
    private func initalize() {
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:objStation?.sationname ?? "", isHomeScreen:false,isDisplaySOS: false)
        self.actionSegmentChange(sgementSchedule)
        let filterButton = self.barButton2(imageName:"filter", selector: #selector(filterAction))
        self.navigationItem.rightBarButtonItems = [filterButton]
        objViewModel.delegate = self
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
            
        }
       // self.getStationList(time: "00:00")
        
        
        
    }
    func getStationList(time:Int){
        
        var param = [String:Any]()
        param["intUserID"] = Helper.shared.objloginData?.intUserID
        param["intStationID"] = objStation?.stationid
       // param["tmScheduleTime"] = "00:00"
        param["tmScheduleTimeID"] = time
        
        objViewModel.getfindNearByStation(param: param)
    }
    
    @objc func filterAction() {
        let root = UIWindow.key?.rootViewController!
        if let firstPresented = UIStoryboard.FilterVC() {
            firstPresented.completion = { strTime in
                self.timeID = strTime
                self .getStationList(time: strTime)
            }
            firstPresented.timeID = timeID
            firstPresented.modalTransitionStyle = .crossDissolve
            firstPresented.modalPresentationStyle = .overCurrentContext
            root?.present(firstPresented, animated: false, completion: nil)
        }
        
        
    }
}


extension StationListingVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        lblNoDataFound.isHidden = true
        if self.arrStationList?.count ?? 0  < 1 {
            lblNoDataFound.isHidden = false
        }
        return self.arrStationList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"StationListCell") as? StationListCell else  { return UITableViewCell() }
        let objdata = self.arrStationList?[indexPath.row]
        cell.lblFromStation.text = objdata?.strSourceName ?? ""
        cell.lblToStation.text = objdata?.strDestinationName ?? ""
        cell.lblTime.text = (objdata?.strArrivalTime ?? "").getCurrentDate().toString(withFormat: "hh:mm a")
        cell.btnRoute .setTitle(objdata?.strMetroLineNo ?? "", for: .normal)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.RoueDetailVC()
        vc?.objStation = self.arrStationList?[indexPath.row]
        vc?.objFromStation = objStation
        self.navigationController?.pushViewController(vc!, animated:true)
        
    }
    
    
}
extension StationListingVC:ViewcontrollerSendBackDelegate {
    func getInformatioBack<T>(_ handleData: inout T) {
        
        if let data = handleData as? [StationListModel] {
            arrAllStationList = data
        
            arrStationList = arrAllStationList?.filter({ obj in
                let num = self.listtype == .schedule ? 0 : 1
                return (obj.intTripStatus ?? 0) ==  num
            })
            
        }
    }
}
