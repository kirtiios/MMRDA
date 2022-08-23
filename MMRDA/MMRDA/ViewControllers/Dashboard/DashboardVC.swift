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
            break
        case .MYTicket:
            break
        case .Mypass:
            break
        case.Planyourjourney:
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
