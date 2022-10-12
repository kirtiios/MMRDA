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
    
    
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    
    @IBOutlet weak var btnHelpLine: UIButton!
    
    var arrName = ["findnearbybusstops",
                   "planjourney",
                   "farecalculator",
                   "mytickets",
                   "mypass",
                   "smartcard"]
    
    var arrImage = ["FindNearByStation","PlanYourJourney","FareCalculator","MyTicket","MyPass","SmartCard"]
    func initialize(){
        lblFullName.text = "welcomeback".LocalizedString  + " "  +  (Helper.shared.objloginData?.strFullName ?? "")
        btnHelpLine .setTitle("helpline".localized(), for:.normal)
        self.collectionView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        var arr1 = [1,2,3]
        var arr2 = arr1
        
        arr2.append(4)
        print(arr1.count)
       // print(ex.number2)
        
        self.callBarButtonForHome(leftBarLabelName:"", isShowTitleImage:true, isHomeScreen:true)
        self.navigationController?.navigationBar.isHidden = false
        
      
        
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
//
                   //
                    self.showAlertViewWithMessage("", message:"Coming Soon")
//                    let objwebview = UIStoryboard.MyRewardsVC()
//                    self.navigationController?.pushViewController(objwebview!, animated: true)
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
                    
                    self.showAlertViewWithMessage("", message:"Coming Soon")
//                    let objwebview = UIStoryboard.GrivanceDashBoardVC()
//                    self.navigationController?.pushViewController(objwebview!, animated: true)
                }
                else if obj == .settings {
                    let objwebview = UIStoryboard.SettingsVC()
                    self.navigationController?.pushViewController(objwebview!, animated: true)
                }
                else if obj == .myProfile {
                    let vc = UIStoryboard.EditProfileVC()!
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else if obj == .cityguide {
                    let vc = UIStoryboard.CityGuideVC()!
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else if obj == .contactus {
                    let vc = UIStoryboard.ConatctUSVC()!
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                
                
                else if obj == .sharemylocation {
                    LocationManager.sharedInstance.getCurrentLocation { success, location in
                        if success {
                            
                            let text = "share_my_loc".LocalizedString + "http://maps.google.com/maps?daddr=\(location?.coordinate.latitude ?? 0),\(location?.coordinate.longitude ?? 0)"
                            
                            // set up activity view controller
                            let textToShare = [ text ]
                            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
                            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
                            
                            // exclude some activity types from the list (optional)
                            activityViewController.excludedActivityTypes = []
                            
                            // present the view controller
                            self.present(activityViewController, animated: true, completion: nil)
                            //                            let objLocation = ShareMyLocationVC(nibName: "ShareMyLocationVC", bundle:nil)
                            //                            objLocation.modalTransitionStyle = .crossDissolve
                            //                            objLocation.modalPresentationStyle = .overCurrentContext
                            //                            self.present(objLocation, animated: false, completion: nil)
                        }
                    }
                }
                
                
            }
        }
        NotificationCenter.default.addObserver(forName: Notification.sidemenuUpdated, object: nil, queue: .main) { notification in
            self.initialize()
        }
        self.initialize()
       // APPDELEGATE.isFromLogin &&
        if UserDefaults.standard.bool(forKey: userDefaultKey.isMpinEnable.rawValue) == false {
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
        self.lblCount.isHidden = true
        self.getNotifcaitonCount()
        
        //2022-08-31T09:39:45.0977412+00:00
    }
    func getNotifcaitonCount(){
        var param = [String:Any]()
        param ["UserId"] = Helper.shared.objloginData?.intUserID
        param["intFlag"] = 0
        ApiRequest.shared.requestPostMethod(strurl: apiName.notifcaitonList, params: param, showProgress: false, completion: { suces, data, error in
            do {
            let obj = try JSONDecoder().decode(AbstractResponseModel<NotificationModel>.self, from: data)
                if obj.issuccess ?? false {
                    if let arry = obj.data {
                        let arrayCount = arry.filter { obj in
                            return (obj.bViewed ?? false == false)
                        }
                        self.lblCount.text = "\(arrayCount.count)"
                        self.lblCount.layer.cornerRadius = self.lblCount.frame.size.width/2
                        self.lblCount.layer.masksToBounds = true
                        self.lblCount.isHidden = arrayCount.count > 0 ? false : true
                    }
                }else {
                    if let message = obj.message {
                      //  self.inputErrorMessage.value = message
                    }
                }
            
            }catch {
                print(error)
            }
        })
        
    }

}

extension DashboardVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell:HomeCell = collectionView.dequeueReusableCell(withReuseIdentifier:"HomeCell", for: indexPath as IndexPath) as? HomeCell else { return UICollectionViewCell () }
        cell.contentView.backgroundColor = Colors.APP_Theme_color.value
        cell.lnlMenuName.text = arrName[indexPath.row].localized()
        cell.imgMenu.image = UIImage(named: arrImage[indexPath.row])
        //if indexPath.row == 2 {
          //  cell.imgMenu.contentMode = .center
//        }else {
//            cell.imgMenu.contentMode = .scaleAspectFit
//        }
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
            self.showAlertViewWithMessage("", message: "Coming Soon")
            break
        case.Planyourjourney:
            let vc = UIStoryboard.JourneySearchVC()
            self.navigationController?.pushViewController(vc, animated:true)
            break
        case .SmartCard:
            self.showAlertViewWithMessage("", message: "Coming Soon")
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
extension DashboardVC {
    @IBAction func btnActionHelpClicked(_ sender: UIButton) {
        NotificationCenter.default.post(name:Notification.sideMenuDidSelectNotificationCenter, object: sidemenuItem.helpline, userInfo: nil)
    }
    @IBAction func btnActionNotificationClicked(_ sender: UIButton) {
    
        let obj = UIStoryboard.FareCalculatorStoryBoard().instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(obj, animated: true)
    }
}
