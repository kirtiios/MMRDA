//
//  SettingsVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 22/08/22.
//

import UIKit



enum SettingmenuItem:String,CaseIterable {
    case mPIN = "tv_mpin_enable"
    case Profile = "profile"
    case Language = "language"
    case TrustedContacts = "trustedcontacts"
    case Terms = "termsconditions"
    case About_MMRDA = "aboutbmtc"
    case About_Developer = "aboutdevloper"
    case Logout = "signout"
    
}




class SettingsVC: BaseVC {

    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"settings".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        let Home = self.barButton2(imageName:"Home", selector: #selector(mpoveToHome))
        self.navigationItem.rightBarButtonItems = [Home]
        self.tblView.reloadData()
       
        // Do any additional setup after loading the view.
    }
    
    @objc func mpoveToHome() {
        self.navigationController?.popToRootViewController(animated:true)
        
    }
    
}


extension SettingsVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingmenuItem.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if SettingmenuItem.allCases[indexPath.row].rawValue.LocalizedString == "tv_mpin_enable".LocalizedString {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier:"SettingsCell") as? SettingsCell else  { return UITableViewCell() }
            
            cell.setMPinEnableSwitch.isHidden = false
            cell.lblName.text = SettingmenuItem.allCases[indexPath.row].rawValue.LocalizedString
            cell.imgMenu.image = UIImage(named:SettingmenuItem.allCases[indexPath.row].rawValue)
            cell.setMPinEnableSwitch.isOn = UserDefaults.standard.bool(forKey:userDefaultKey.isMpinEnable.rawValue)
            cell.completion = { status in
                
              
                if status {
                    if let firstPresented = UIStoryboard.SetupMPINVC() {
                        firstPresented.completion = { status  in
                            UserDefaults.standard.set(status, forKey: userDefaultKey.isMpinEnable.rawValue)
                            UserDefaults.standard.synchronize()
                            self.tblView.reloadData()
                        }
                        firstPresented.modalTransitionStyle = .crossDissolve
                        firstPresented.modalPresentationStyle = .overCurrentContext
                        self.present(firstPresented, animated: false, completion: nil)
                    }
                }
                UserDefaults.standard.set(status, forKey: userDefaultKey.isMpinEnable.rawValue)
                UserDefaults.standard.synchronize()
                
              
            }
            cell.sideArrowIcon.isHidden = true
            return cell
            
            
            
        }else if SettingmenuItem.allCases[indexPath.row].rawValue.LocalizedString == "language".LocalizedString {
            guard let cell = tableView.dequeueReusableCell(withIdentifier:"LanguageSelectCell") as? LanguageSelectCell else  { return UITableViewCell() }
            cell.completionBlock = {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    if let VC = UIStoryboard.DashboardVC() {
                        APPDELEGATE.openViewController(Controller:VC)
                    }
                }
            }
            return cell
            
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier:"SettingsCell") as? SettingsCell else  { return UITableViewCell() }
            cell.lblName.text = SettingmenuItem.allCases[indexPath.row].rawValue.LocalizedString
            cell.imgMenu.image = UIImage(named:SettingmenuItem.allCases[indexPath.row].rawValue)
            cell.setMPinEnableSwitch.isHidden = true
            cell.sideArrowIcon.isHidden = false
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // TRUSTED CONATCTS
        if  SettingmenuItem.allCases[indexPath.row].rawValue.LocalizedString == "trustedcontacts".LocalizedString {
            let vc = UIStoryboard.TrustedContactVC()
            self.navigationController?.pushViewController(vc!, animated:true)
        }else if SettingmenuItem.allCases[indexPath.row].rawValue.LocalizedString == "aboutbmtc".LocalizedString {
            // ABOUT MMRDA
            let vc = UIStoryboard.AboutDeveloperVC()
            vc?.titleValue = "aboutbmtc".LocalizedString
            vc?.contentValue = "about_mmrda".LocalizedString
            self.navigationController?.pushViewController(vc!, animated:true)
        }
        else if SettingmenuItem.allCases[indexPath.row].rawValue.LocalizedString == "aboutdevloper".LocalizedString {
            // ABOUT DEVELOPER
            let vc = UIStoryboard.AboutDeveloperVC()
            vc?.titleValue = "aboutdevloper".LocalizedString
            vc?.contentValue = "about_developer_mmrda".LocalizedString
            self.navigationController?.pushViewController(vc!, animated:true)
        }else if SettingmenuItem.allCases[indexPath.row].rawValue.LocalizedString == "lbl_agreetermsandcondition".LocalizedString {
            // TERMS AND CONDITION
            let objwebview = WebviewVC(nibName: "WebviewVC", bundle: nil)
            objwebview.titleString = "lbl_agreetermsandcondition".LocalizedString
            objwebview.url = URL(string:"https://www.mmmocl.co.in/terms-conditions-for-qr-ticket.html")
            self.navigationController?.pushViewController(objwebview, animated: true)
        }else if SettingmenuItem.allCases[indexPath.row].rawValue.LocalizedString == "profile".LocalizedString {
            // EDIT PROFILE
            let vc = UIStoryboard.EditProfileVC()!
            self.navigationController?.pushViewController(vc, animated: true)
        }else if SettingmenuItem.allCases[indexPath.row].rawValue.LocalizedString == "signout".LocalizedString {
            
            
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
            
//            self.showAlertViewWithMessageCancelAndActionHandler("", message: "log_out_confirmation".LocalizedString) {
//                UserDefaults.standard.set(false, forKey: userDefaultKey.isLoggedIn.rawValue)
//                UserDefaults.standard.synchronize()
//                APPDELEGATE.setupViewController()
//            }
            
        }
    }
    
}
