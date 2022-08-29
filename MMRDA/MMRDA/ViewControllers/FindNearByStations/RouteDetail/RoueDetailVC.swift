//
//  RoueDetailVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 24/08/22.
//

import UIKit
import GoogleMaps

class RoueDetailVC: BaseVC {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var lblRouteNo: UILabel!
    @IBOutlet weak var lblDestinationValue: UILabel!
    @IBOutlet weak var lblSourceValue: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblVehcileNumber: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var constTblviewHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"routedetail".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
        tblView.tableHeaderView = UIView(frame: frame)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func actionMapView(_ sender: UIButton) {
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
    
     @IBAction func actionRefresh(_ sender: Any) {
         
     }
    
    
    @IBAction func actionShare(_ sender: Any) {
        
    }
    @IBAction func actionFavourite(_ sender: Any) {
        
    }
    

    @IBAction func actionBookNow(_ sender: Any) {
        let vc = UIStoryboard.PaymentVC()
        self.navigationController?.pushViewController(vc!, animated:true)
    }
}

extension RoueDetailVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier:"RouteDetailHeaderCell") as? RouteDetailHeaderCell else  { return UITableViewCell() }
            DispatchQueue.main.async {
                self.constTblviewHeight.constant = tableView.contentSize.height + 30
                self.tblView.layoutIfNeeded()
            }
            
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier:"RouteDetailCell") as? RouteDetailCell else  { return UITableViewCell() }
            constTblviewHeight.constant = tblView.contentSize.height
            cell.completionBlock = {
                // OPEN REMIDENR VC
                let root = UIWindow.key?.rootViewController!
                if let firstPresented = UIStoryboard.ReminderVC() {
                    firstPresented.modalTransitionStyle = .crossDissolve
                    firstPresented.modalPresentationStyle = .overCurrentContext
                    root?.present(firstPresented, animated: false, completion: nil)
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
