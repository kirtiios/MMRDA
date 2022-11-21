//
//  ViewController.swift
//  MMRDA
//
//  Created by Sandip Patel on 17/08/22.
//

import UIKit
import ImageSlideshow
import CoreLocation

class DashboardVC: UIViewController {

    @IBOutlet weak var noInternetView: UIView!
    @IBOutlet weak var internalServrView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    
    @IBOutlet weak var btnHelpLine: UIButton!
    
    var arrName = ["bookticket",
                   "planjourney",
                   "findnearbybusstops",
                   "mytickets",
                   "mypass",
                   "smartcard"]
    
    var arrImage = ["FareCalculator","PlanYourJourney","FindNearByStation","MyTicket","MyPass","SmartCard"]
    func initialize(){
        lblFullName.text = "welcomeback".LocalizedString  + " "  +  (Helper.shared.objloginData?.strFullName ?? "")
        btnHelpLine .setTitle("helpline".localized(), for:.normal)
        self.collectionView.reloadData()
    }
    @IBOutlet var slideshow: ImageSlideshow!
    func decodeISO88591(str:String) -> String {
        if let utfData = str.data(using: .isoLatin1) {
            if let utf = String(data: utfData, encoding: String.Encoding(rawValue: NSUTF8StringEncoding)) {
               return utf
           }
        }
        return str
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//       let strbase64 = "VbNLG5mJ538AyPcEJCtTY/TGNDjqjaVkDvJPuDsFv24="
//       var data = Data(base64Encoded: strbase64, options:[])!
//       let str = String(decoding: data, as: UTF8.self)
        
      //  print("data:",str)
     //   print("data1:",self.decodeISO88591(str: str))
//        LocationManager.sharedInstance.getCurrentLocation { success, location in
//            self.getAddressFromLatLon(pdblLatitude: location!.coordinate.latitude, withLongitude: (location!.coordinate.longitude))
//        }
//
        
        self.callBarButtonForHome(leftBarLabelName:"", isShowTitleImage:true, isHomeScreen:true)
        self.navigationController?.navigationBar.isHidden = false
        
        slideshow.slideshowInterval = 5.0
        slideshow.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        slideshow.contentScaleMode = UIViewContentMode.scaleToFill

        slideshow.pageIndicator = nil

        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        slideshow.activityIndicator = DefaultActivityIndicator()
        slideshow.delegate = self

        // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
//        let sdWebImageSource = [SDWebImageSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, SDWebImageSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, SDWebImageSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]
        
        slideshow.setImageInputs([
            ImageSource(image:UIImage(named: "banner1")!),
            ImageSource(image:UIImage(named: "banner2")!)])

//        let recognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.didTap))
//        slideshow.addGestureRecognizer(recognizer)
        
      
        
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
                    //self.showAlertViewWithMessage("", message:"Coming Soon")
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
                    
                  //  self.showAlertViewWithMessage("", message:"Coming Soon")
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
            
            
            let obj  = MpinpopupVC(nibName: "MpinpopupVC", bundle: nil)
            obj.completionBlock = { status in
                let root = UIWindow.key?.rootViewController!
                if let firstPresented = UIStoryboard.SetupMPINVC() {
                    firstPresented.modalTransitionStyle = .crossDissolve
                    firstPresented.modalPresentationStyle = .overCurrentContext
                    root?.present(firstPresented, animated: false, completion: nil)
                }
            }
            obj.modalPresentationStyle = .overCurrentContext
            APPDELEGATE.topViewController!.present(obj, animated: true, completion: nil)
            
//            self.showAlertViewWithMessageCancelAndActionHandler("tv_are_you_want_to_set_mpin".LocalizedString, message:"") {
//                let root = UIWindow.key?.rootViewController!
//                if let firstPresented = UIStoryboard.SetupMPINVC() {
//                    firstPresented.modalTransitionStyle = .crossDissolve
//                    firstPresented.modalPresentationStyle = .overCurrentContext
//                    root?.present(firstPresented, animated: false, completion: nil)
//                }
//            }
        }
       // DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
          
       // }
        
       
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
        let iv = Array(Data(base64Encoded: "VbNLG5mJ538AyPcEJCtTY/TGNDjqjaVkDvJPuDsFv24=")!)

        
//        let decodedData = Data(base64Encoded: "VbNLG5mJ538AyPcEJCtTY/TGNDjqjaVkDvJPuDsFv24=", options:    Data.Base64DecodingOptions())
//           let bytes = decodedData?.bytes
        let strNew = String(bytes: iv, encoding: String.Encoding(rawValue: NSISOLatin1StringEncoding))
        
        var data = Data(base64Encoded: "VbNLG5mJ538AyPcEJCtTY/TGNDjqjaVkDvJPuDsFv24=", options:[])!
        let str = String(decoding: data, as: UTF8.self)
         print("data:",strNew, String(data: data, encoding: .isoLatin2))

        
        let isoDate = Helper.shared.objloginData?.dteAccessTokenExpirationTime ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = " yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" //"yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: isoDate) {
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss a"
            print("string:",dateFormatter.string(from: date))
        }
        self.lblCount.layer.cornerRadius = self.lblCount.frame.size.width/2
        self.lblCount.layer.masksToBounds = true
      //  self.lblCount.isHidden = true
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
                        
                       // self.lblCount.isHidden = arrayCount.count > 0 ? false : true
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
        cell.viewComingSoon.isHidden = true
        if DashboardMenus(rawValue: indexPath.row) == .SmartCard ||  DashboardMenus(rawValue: indexPath.row) == . Mypass {
            cell.viewComingSoon.isHidden = false
        }
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
           // self.showAlertViewWithMessage("", message: "Coming Soon")
            break
        case.Planyourjourney:
            let vc = UIStoryboard.JourneySearchVC()
            self.navigationController?.pushViewController(vc, animated:true)
            break
        case .SmartCard:
           // self.showAlertViewWithMessage("", message: "Coming Soon")
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
extension DashboardVC: ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        print("current page:", page)
    }
}
