//
//  StationListingVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 22/08/22.
//

import UIKit

class StationListingVC: BaseVC {
    
    @IBOutlet weak var segmentViewRunning: UIView!
    @IBOutlet weak var segmentViewScheDule: UIView!
    @IBOutlet weak var lblNoDataFound: UILabel!
    @IBOutlet weak var segmentRunning: UIButton!
    @IBOutlet weak var sgementSchedule: UIButton!
    @IBOutlet weak var tableview: UITableView!
    var objStation:FareStationListModel?
    var arrStationList:[StationListModel]?{
        didSet{
            self.tableview.reloadData()
        }
    }
 
    private let objViewModel  = StationListingViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        initalize()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.getStationList(time:0)
    }
    
    
    // MARK:  Action SEGMENT CHANGE
    @IBAction func actionSegmentChange(_ sender:UIButton) {
        if sender.tag == 101 { // Schedule
            segmentViewScheDule.backgroundColor = Colors.APP_Theme_color.value
            segmentViewRunning.backgroundColor = UIColor.lightGray
            sgementSchedule.setTitleColor(Colors.APP_Theme_color.value, for:.normal)
            segmentRunning.backgroundColor = UIColor.white
            segmentRunning.setTitleColor(UIColor.gray, for:.normal)
            
        }else { // Running
            segmentViewRunning.backgroundColor = Colors.APP_Theme_color.value
            segmentViewScheDule.backgroundColor = UIColor.lightGray
            segmentRunning.setTitleColor(Colors.APP_Theme_color.value, for:.normal)
            segmentRunning.backgroundColor = UIColor.white
            sgementSchedule.setTitleColor(UIColor.gray, for:.normal)
        }
        
        
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
                self .getStationList(time: strTime)
            }
            firstPresented.modalTransitionStyle = .crossDissolve
            firstPresented.modalPresentationStyle = .overCurrentContext
            root?.present(firstPresented, animated: false, completion: nil)
        }
        
        
    }
}


extension StationListingVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        self.navigationController?.pushViewController(vc!, animated:true)
        
    }
    
    
}
extension StationListingVC:ViewcontrollerSendBackDelegate {
    func getInformatioBack<T>(_ handleData: inout T) {
        
        if let data = handleData as? [StationListModel] {
                arrStationList = data
        }
    }
}
