//
//  PlanjourneyRouetDetailsVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 06/09/22.
//

import UIKit
import GoogleMaps

class PlanjourneyRouetDetailsVC: BaseVC {

    @IBOutlet weak var lblLastUpdatedtime: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var btnMapView: UIButton!
    @IBOutlet weak var mapView: GMSMapView!
   
    @IBOutlet weak var lblToStation: UILabel!
    @IBOutlet weak var lblFromStation: UILabel!
    @IBOutlet weak var lblStatusValue: UILabel!
    var arrRoutes = [String]() {
        didSet {
            
        }
    }
    @IBOutlet weak var constTblViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"routedetail".LocalizedString, isHomeScreen:false,isDisplaySOS: false)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.constTblViewHeight?.constant = self.tblView.contentSize.height
    }

    @IBAction func actionFavourites(_ sender: Any) {
        
    }
    
    
    @IBAction func actionShare(_ sender: Any) {
    }
    
    
    @IBAction func actionRefersh(_ sender: Any) {
    }
    
    
    @IBAction func actiobBookNow(_ sender: Any) {
        let vc = UIStoryboard.FareCalVC()
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
    
    @IBAction func actionSelectMapView(_ sender: UIButton) {
        sender.isSelected  = !sender.isSelected
        if sender.isSelected == true {
            sender.setTitle("tv_listView".LocalizedString, for: .normal)
            mapView.isHidden = false
            tblView.isHidden  = true
        }else{
            sender.setTitle("mapview".LocalizedString, for: .normal)
            mapView.isHidden = true
            tblView.isHidden  = false
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension PlanjourneyRouetDetailsVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
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
            cell.statioName = ["Abc","def","GhI"] 
            self.constTblViewHeight.constant = tableView.contentSize.height
            tblView.layoutIfNeeded()
            cell.completionBlockData = {
                DispatchQueue.main.async {
                    self.constTblViewHeight.constant = self.tblView.contentSize.height
                    //self.tblView.layoutIfNeeded()
                    self.tblView.beginUpdates()
                    self.tblView.endUpdates()
                   }
            }
            
            cell.completionBlock = {
                // OPEN REMIDENR VC
                let root = UIWindow.key?.rootViewController!
                if let firstPresented = UIStoryboard.ReminderVC() {
                    firstPresented.modalTransitionStyle = .crossDissolve
                    firstPresented.modalPresentationStyle = .overCurrentContext
                    root?.present(firstPresented, animated: false, completion: nil)
                }
            }
            
            cell.completionBlockOFAlternatives = {
                // OPEN REMIDENR VC
                let root = UIWindow.key?.rootViewController!
                if let firstPresented = UIStoryboard.AlertaltivesVC() {
                    firstPresented.modalTransitionStyle = .crossDissolve
                    firstPresented.modalPresentationStyle = .overCurrentContext
                    root?.present(firstPresented, animated: false, completion: nil)
                }
            }
            
            
            
            
            cell.isShowTable = { isShow in
                self.constTblViewHeight.constant = self.tblView.contentSize.height
                self.tblView.layoutIfNeeded()
                self.tblView.beginUpdates()
                self.tblView.endUpdates()
            }
           
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
