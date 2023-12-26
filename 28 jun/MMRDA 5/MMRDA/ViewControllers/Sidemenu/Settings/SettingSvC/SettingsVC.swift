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
    
    var clearArrayClosure: (([FareStationListModel]) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self .refrehData()
        
        tblView.backgroundColor = UIColor(hexString: "F1F2F7")
       // #F1F2F7
        // Do any additional setup after loading the view.
    }
    func refrehData(){
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"settings".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        let Home = self.barButton2(imageName:"Home", selector: #selector(mpoveToHome))
        self.navigationItem.rightBarButtonItems = [Home]
        self.tblView.reloadData()
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
                    
                    if let data = UserDefaults.standard.string(forKey:userDefaultKey.mpinData.rawValue) {}else {
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
                }
                UserDefaults.standard.set(status, forKey: userDefaultKey.isMpinEnable.rawValue)
                UserDefaults.standard.synchronize()
                
              
            }
            cell.sideArrowIcon.isHidden = true
            return cell
            
            
            
        }else if SettingmenuItem.allCases[indexPath.row].rawValue.LocalizedString == "language".LocalizedString {
            guard let cell = tableView.dequeueReusableCell(withIdentifier:"LanguageSelectCell") as? LanguageSelectCell else  { return UITableViewCell() }
            
             print(languageCode)
            
            if let selectedLanguage = languageCode as? String {
                cell.btnMarathi.isSelected = false
                cell.btnHindi.isSelected = false
                cell.btnEnglish.isSelected = false
                cell.btnEnglish.isUserInteractionEnabled = true
                cell.btnHindi.isUserInteractionEnabled = true
                cell.btnMarathi.isUserInteractionEnabled = true
                
                if selectedLanguage  ==  LanguageCode.Marathi.rawValue {
                    
                   // btnHindi.isSelected = false
                    cell.btnMarathi.isSelected = true
                    cell.btnMarathi.isUserInteractionEnabled = false
    //                btnEnglish.setImage(UIImage(named: "radioUnselected"), for:.normal)
    //                btnHindi.setImage(UIImage(named: "radioUnselected"), for:.normal)
    //                btnMarathi.setImage(UIImage(named: "radioSelected"), for:.normal)
                }else if selectedLanguage  ==  LanguageCode.Hindi.rawValue {
                    cell.btnHindi.isSelected = true
                    cell.btnHindi.isUserInteractionEnabled = false
    //                btnEnglish.setImage(UIImage(named: "radioUnselected"), for:.normal)
    //                btnHindi.setImage(UIImage(named: "radioSelected"), for:.normal)
    //                btnMarathi.setImage(UIImage(named: "radioUnselected"), for:.normal)
                }else{
                    cell.btnEnglish.isSelected = true
                    cell.btnEnglish.isUserInteractionEnabled = false
    //                btnEnglish.setImage(UIImage(named: "radioSelected"), for:.normal)
    //                btnHindi.setImage(UIImage(named: "radioUnselected"), for:.normal)
    //                btnMarathi.setImage(UIImage(named: "radioUnselected"), for:.normal)
                }
            }
            cell.lblTitle.text = "language".localized()
            cell.btnHindi .setTitle("hindi".localized(), for: .normal)
            cell.btnEnglish .setTitle("english".localized(), for: .normal)
            cell.btnMarathi .setTitle("Marathi".localized(), for: .normal)
            
            cell.btnEnglish.addTarget(self, action: #selector(self.lanButtonClick), for: .touchUpInside)
            cell.btnHindi.addTarget(self, action: #selector(self.lanButtonClick), for: .touchUpInside)
            cell.btnMarathi.addTarget(self, action: #selector(self.lanButtonClick), for: .touchUpInside)
            cell.completionBlock = {
//                self.showAlertViewWithMessageCancelAndActionHandler("APPTITLE".LocalizedString, message: "strLanguagePopup".LocalizedString) {
//                    self.refrehData()
//                   NotificationCenter.default.post(name:Notification.sidemenuUpdated, object: nil)
//
//                    UserDefaults.standard.removeObject(forKey: userDefaultKey.stationList.rawValue)
//                    UserDefaults.standard.synchronize()
//
//
//
//                }
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                    if let VC = UIStoryboard.DashboardVC() {
//                        APPDELEGATE.openViewController(Controller:VC)
//                    }
//                }
            }
            return cell
            
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier:"SettingsCell") as? SettingsCell else  { return UITableViewCell() }
            cell.lblName.text = SettingmenuItem.allCases[indexPath.row].rawValue.LocalizedString
            cell.imgMenu.image = UIImage(named:SettingmenuItem.allCases[indexPath.row].rawValue)
            cell.setMPinEnableSwitch.isHidden = true
            cell.sideArrowIcon.isHidden = false
            if SettingmenuItem.allCases[indexPath.row] ==  SettingmenuItem.Logout {
                cell.imgMenu.image = UIImage(named:"logoutSetting")
            }
            
            
            return cell
        }
    }
    @objc func lanButtonClick(_ sender: UIButton) {
        if sender.isSelected == true{
         
        }else{
           
            let alertController = UIAlertController(title: "APPTITLE".LocalizedString, message: "strLanguagePopup".LocalizedString, preferredStyle: UIAlertController.Style.alert)
            let alAction = UIAlertAction(title: "yes".LocalizedString, style: .default) { (action) in
                action.setValue(UIColor.black, forKey: "titleTextColor")
                
                NotificationCenter.default.post(name:Notification.sidemenuUpdated, object: nil)
                
                UserDefaults.standard.removeObject(forKey: userDefaultKey.stationList.rawValue)
                UserDefaults.standard.removeObject(forKey: userDefaultKey.journeyPlannerList.rawValue)
                UserDefaults.standard.synchronize()
                
                if sender.tag == 101{
                    languageCode = LanguageCode.English.rawValue
                }else if sender.tag == 102{
                    languageCode = LanguageCode.Hindi.rawValue
                }else {
                    languageCode = LanguageCode.Marathi.rawValue
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.refrehData()
                    self.tblView.layoutIfNeeded()
                }
//                UserDefaults.standard.removeObject(forKey: "arrRecentData")
//                UserDefaults.standard.synchronize()
               // UserDefaults.standard.set(arrRecentData, forKey: "arrRecentData")
            }
            
            
            
            
            let alAction1 = UIAlertAction(title: "no".LocalizedString, style: .default) { (action) in
                
            }
            
            alAction.setValue(UIColor.black, forKey: "titleTextColor")
            alAction1.setValue(UIColor.black, forKey: "titleTextColor")
            alertController.addAction(alAction1)
            alertController.addAction(alAction)
            self.present(alertController, animated: true, completion: nil)
        }

        
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // TRUSTED CONATCTS
        if  SettingmenuItem.allCases[indexPath.row] == SettingmenuItem.TrustedContacts {
            let vc = UIStoryboard.TrustedContactVC()
            self.navigationController?.pushViewController(vc!, animated:true)
        }else if SettingmenuItem.allCases[indexPath.row] == SettingmenuItem.About_MMRDA{
            // ABOUT MMRDA
            let vc = UIStoryboard.AboutDeveloperVC()
            vc?.titleValue = SettingmenuItem.allCases[indexPath.row].rawValue.localized()
            vc?.contentValue = "about_mmrda".LocalizedString
            self.navigationController?.pushViewController(vc!, animated:true)
        }
        else if SettingmenuItem.allCases[indexPath.row] == SettingmenuItem.About_Developer {
            // ABOUT DEVELOPER
            let vc = UIStoryboard.AboutDeveloperVC()
            vc?.titleValue = SettingmenuItem.allCases[indexPath.row].rawValue.localized()
            vc?.contentValue = "about_developer_mmrda".LocalizedString
            self.navigationController?.pushViewController(vc!, animated:true)
        }else if SettingmenuItem.allCases[indexPath.row] == SettingmenuItem.Terms {
            // TERMS AND CONDITION
            let objwebview = WebviewVC(nibName: "WebviewVC", bundle: nil)
            objwebview.titleString = SettingmenuItem.allCases[indexPath.row].rawValue.localized()
            objwebview.url = URL(string:"https://www.mmmocl.co.in/terms-conditions-for-qr-ticket.html")
            self.navigationController?.pushViewController(objwebview, animated: true)
        }else if SettingmenuItem.allCases[indexPath.row] == SettingmenuItem.Profile {
            // EDIT PROFILE
            let vc = UIStoryboard.EditProfileVC()!
            self.navigationController?.pushViewController(vc, animated: true)
        }else if SettingmenuItem.allCases[indexPath.row] == SettingmenuItem.Logout {
            
            
            let firstPresented = AlertViewVC(nibName:"AlertViewVC", bundle: nil)
            firstPresented.strMessage = "log_out_confirmation".LocalizedString
            firstPresented.img = UIImage(named:"logout")!
            firstPresented.completionOK = {
                UserDefaults.standard.set(false, forKey: userDefaultKey.isLoggedIn.rawValue)
                UserDefaults.standard.synchronize()
                APPDELEGATE.setupViewController()
            }
            firstPresented.modalTransitionStyle = .crossDissolve
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
