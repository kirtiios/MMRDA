//
//  SidemenuVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 22/08/22.
//

import UIKit
import SDWebImage

enum sidemenuItem:String,CaseIterable {
    case myProfile = "--"
    case faretable = "lbl_fare_table"
    case timetable = "lbl_time_table"
    case networkmap = "tv_network_map"
    case nearbyattraction = "near_by_attraction"
    case cityguide = "city_guide"
    case myrewards = "lbl_my_rewards"
    case myfavourites = "myfavourites"
    case sharemylocation = "sharemylocation"
    case chatwithus = "tv_chat_with_us"
    case contactus = "lbl_contact_us"
    case feedback = "feedback"
    case heldesk = "lbl_heldesk"
    case settings = "settings"
    case helpline = "helpline"
    case signout = "signout"
    
}



class SidemenuVC: UIViewController {
    
    @IBOutlet weak var tblSideMenu: UITableView!
   // var arrMenus = [Menu]()
    override func viewDidLoad() {
        super.viewDidLoad()
//        tblSideMenu.tableHeaderView =
//        UIView(frame:
//                  CGRect(x: 0, y: 0,
//                         width: tblSideMenu.frame.width,
//                         height: CGFloat.leastNormalMagnitude))
//
        NotificationCenter.default.addObserver(forName: Notification.sidemenuUpdated, object: nil, queue: .main) { notification in
            self.tblSideMenu.reloadData()
        }
    }
}

// MARK: Tabelview delegate,datasource
extension SidemenuVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sidemenuItem.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserProfileCell") as? UserProfileCell else { return UITableViewCell() }
            cell.lblEmailID.text = Helper.shared.objloginData?.strEmailID
            cell.lblUserName.text = Helper.shared.objloginData?.strFullName
            cell.btnEdit.isUserInteractionEnabled = false
            if let url = URL(string: Helper.shared.objloginData?.strProfileURL ?? "") {
                cell.btnProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell.btnProfile.sd_setImage(with: url, for: .normal, placeholderImage: UIImage(named:"Profile"), context: nil)
               // cell.btnProfile.sd_setImage(with: url, for: .normal)
            }else {
                cell.btnProfile .setImage(UIImage(named:"Profile"), for: .normal)
            }
            cell.btnEdit .setTitle("lbl_edit".localized(), for: .normal)
            cell.btnProfile.layer.cornerRadius = cell.btnProfile.layer.frame.size.width/2
            cell.btnProfile.layer.masksToBounds = true
           
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as? MenuCell else { return UITableViewCell() }
            cell.lblMenuName.text = sidemenuItem.allCases[indexPath.row].rawValue.LocalizedString
            cell.imgMenu.image = UIImage(named:sidemenuItem.allCases[indexPath.row].rawValue)
            cell.viewComingSoon.isHidden = true
            if sidemenuItem.allCases[indexPath.row].rawValue == sidemenuItem.myrewards.rawValue {
                cell.viewComingSoon.isHidden = false
            }
            
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == sidemenuItem.allCases.count-1 {
            
            self.panel?.closeLeft()
            
            
            let firstPresented = AlertViewVC(nibName:"AlertViewVC", bundle: nil)
            firstPresented.strMessage = "log_out_confirmation".LocalizedString
            firstPresented.img = UIImage(named: "logout")!
            firstPresented.completionOK = {
                UserDefaults.standard.set(false, forKey: userDefaultKey.isLoggedIn.rawValue)
                UserDefaults.standard.synchronize()
                APPDELEGATE.setupViewController()
            }
            firstPresented.modalPresentationStyle = .overCurrentContext
            APPDELEGATE.topViewController!.present(firstPresented, animated: true, completion: nil)
            
            
          //  let root = UIWindow.key?.rootViewController!
//            self.showAlertViewWithMessageCancelAndActionHandler("", message: "log_out_confirmation".LocalizedString) {
//                UserDefaults.standard.set(false, forKey: userDefaultKey.isLoggedIn.rawValue)
//                UserDefaults.standard.synchronize()
//                APPDELEGATE.setupViewController()
//            }
//            
            
        }else {
            self.panel?.closeLeft()
            NotificationCenter.default.post(name:Notification.sideMenuDidSelectNotificationCenter, object: sidemenuItem.allCases[indexPath.row], userInfo: nil)
        }
        
    }
}

