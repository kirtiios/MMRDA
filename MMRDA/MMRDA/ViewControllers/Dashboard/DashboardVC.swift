//
//  ViewController.swift
//  MMRDA
//
//  Created by Sandip Patel on 17/08/22.
//

import UIKit

class DashboardVC: UIViewController {

    @IBOutlet weak var noInternetView: UIView!
    @IBOutlet weak var internalServrView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func btnActionHelpClicked(_ sender: UIButton) {
        NotificationCenter.default.post(name:Notification.sideMenuDidSelectNotificationCenter, object: sidemenuItem.helpline, userInfo: nil)
    }
    @IBOutlet weak var lblFullName: UILabel!
    
    var arrName = ["findnearbybusstops".LocalizedString,
                   "lbl_plan_journey".LocalizedString,
                   "farecalculator".LocalizedString,
                   "mypass".LocalizedString,
                   "smartcard".LocalizedString,
                   "mytickets".LocalizedString,
                   
    ]
    var arrImage = ["FindNearByStation","PlanYourJourney","FareCalculator","MyPass","SmartCard","MyTicket"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        self.callBarButtonForHome(leftBarLabelName:"", isShowTitleImage:true, isHomeScreen:true)
        self.navigationController?.navigationBar.isHidden = false
        
        lblFullName.text = "welcomeback".LocalizedString  + " " +  "to".LocalizedString + " " +  (Helper.shared.objloginData?.strFullName ?? "")
        
        NotificationCenter.default.addObserver(forName: Notification.sideMenuDidSelectNotificationCenter, object: nil, queue: .main) { notification in
            
            if let obj = notification.object as? sidemenuItem {
                if obj == .faretable {
                    let objwebview = WebviewVC(nibName: "WebviewVC", bundle: nil)
                    objwebview.objfromType = obj
                    objwebview.url = URL(string:"https://www.mmmocl.co.in/fare-table.php")
                    self.navigationController?.pushViewController(objwebview, animated: true)
                }
                else if obj == .timetable {
                    let objwebview = WebviewVC(nibName: "WebviewVC", bundle: nil)
                    objwebview.objfromType = obj
                    objwebview.url = URL(fileURLWithPath:Bundle.main.path(forResource: "timetable", ofType: "pdf")!)
                    self.navigationController?.pushViewController(objwebview, animated: true)
                }
                else if obj == .networkmap {
                    let objwebview = WebviewVC(nibName: "WebviewVC", bundle: nil)
                    objwebview.objfromType = obj
                    objwebview.url = URL(fileURLWithPath:Bundle.main.path(forResource: "metronetworkmap", ofType: "pdf")!)
                    self.navigationController?.pushViewController(objwebview, animated: true)
                }
                else if obj == .chatwithus {
                    let objwebview = ChatVC(nibName: "ChatVC", bundle: nil)
                    self.navigationController?.pushViewController(objwebview, animated: true)
                }
                else if obj == .myfavourites {
                    let objwebview = UIStoryboard.MyFavouritesVC()
                    self.navigationController?.pushViewController(objwebview!, animated: true)
                }
                else if obj == .myrewards {
                    let objwebview = UIStoryboard.MyRewardsVC()
                    self.navigationController?.pushViewController(objwebview!, animated: true)
                }
                else if obj == .helpline {
                    let objwebview = HelpLineVC(nibName: "HelpLineVC", bundle: nil)
                    self.navigationController?.pushViewController(objwebview, animated: true)
                }
                else if obj == .nearbyattraction {
                    let objwebview = AttractionVC(nibName: "AttractionVC", bundle: nil)
                    self.navigationController?.pushViewController(objwebview, animated: true)
                }
                else if obj == .feedback {
                    let objwebview = UIStoryboard.FeedBackDashBoardVC()
                    self.navigationController?.pushViewController(objwebview!, animated: true)
                }
                else if obj == .heldesk {
                    let objwebview = UIStoryboard.GrivanceDashBoardVC()
                    self.navigationController?.pushViewController(objwebview!, animated: true)
                }
                else if obj == .settings {
                    let objwebview = UIStoryboard.SettingsVC()
                    self.navigationController?.pushViewController(objwebview!, animated: true)
                }
                else if obj == .myProfile {
                    let vc = UIStoryboard.EditProfileVC()!
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else if obj == .sharemylocation {
                    LocationManager.sharedInstance.getCurrentLocation { success, location in
                        if success {
                            let objLocation = ShareMyLocationVC(nibName: "ShareMyLocationVC", bundle:nil)
                            objLocation.modalTransitionStyle = .crossDissolve
                            objLocation.modalPresentationStyle = .overCurrentContext
                            self.present(objLocation, animated: false, completion: nil)
                        }
                    }
                }
                
                
            }
        }
        
        if APPDELEGATE.isFromLogin && UserDefaults.standard.bool(forKey: userDefaultKey.isMpinEnable.rawValue) == false {
            self.showAlertViewWithMessageCancelAndActionHandler("APPTITLE".LocalizedString, message:"tv_are_you_want_to_set_mpin".LocalizedString) {
                let root = UIWindow.key?.rootViewController!
                if let firstPresented = UIStoryboard.SetupMPINVC() {
                    firstPresented.modalTransitionStyle = .crossDissolve
                    firstPresented.modalPresentationStyle = .overCurrentContext
                    root?.present(firstPresented, animated: false, completion: nil)
                }
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        let isoDate = Helper.shared.objloginData?.dteAccessTokenExpirationTime ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = " yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" //"yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: isoDate) {
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss a"
            print("string:",dateFormatter.string(from: date))
        }
        
        //2022-08-31T09:39:45.0977412+00:00
    }

}

extension DashboardVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell:HomeCell = collectionView.dequeueReusableCell(withReuseIdentifier:"HomeCell", for: indexPath as IndexPath) as? HomeCell else { return UICollectionViewCell () }
        cell.contentView.backgroundColor = Colors.APP_Theme_color.value
        cell.lnlMenuName.text = arrName[indexPath.row]
        cell.imgMenu.image = UIImage(named: arrImage[indexPath.row])
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let menusIndex:Int = indexPath.row
        switch DashboardMenus(rawValue:menusIndex) {
        case.FindNearBySyops:
            let vc = UIStoryboard.FindNearByStopsVC()
            self.navigationController?.pushViewController(vc!, animated:true)
        case .FareCalculator:
            let vc = UIStoryboard.FareCalVC()
            self.navigationController?.pushViewController(vc, animated:true)
            break
        case .MYTicket:
            let vc = UIStoryboard.MyticketsVC()
            self.navigationController?.pushViewController(vc, animated:true)
        case .Mypass:
            break
        case.Planyourjourney:
            let vc = UIStoryboard.JourneySearchVC()
            self.navigationController?.pushViewController(vc, animated:true)
            break
        case .SmartCard:
            break
        case .none:
            break
        }
            
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:(SCREEN_WIDTH/2.0 - 15), height:((collectionView.frame.size.height - 20)/3))
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
       let sectionInset = UIEdgeInsets(top:0, left:5, bottom:5, right:5)
            return sectionInset

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 5
        
        
    }
    
}
