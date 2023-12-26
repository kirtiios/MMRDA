//
//  JourneyPlannerStationListing.swift
//  MMRDA
//
//  Created by Sandip Patel on 29/08/22.
//

import UIKit

class JourneyPlannerStationListing: BaseVC {
    
    var arrData = [JourneyPlannerModel]()
    var objStation:RecentPlaneStation?
    var isFromFareCalVC = false
    @IBOutlet weak var lblDataNotFound: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.callBarButtonForHome(isloggedIn:true,leftBarLabelName:"tv_trip_details".localized(), isHomeScreen:false,isDisplaySOS: false)
        self.navigationItem.title = "tv_trip_details".localized()
        self.setBackButton()
        if let objdata = arrData.first?.journeyPlannerStationDetail,arrData.first?.transitPaths?.count ?? 0 > 0 {
            self.navigationItem.title = (objdata.strFromStationName ?? "") + " To " + (objdata.strToStationName ?? "")
        }
       
        // Do any additional setup after loading the view.
    }
}


extension JourneyPlannerStationListing :UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lblDataNotFound.isHidden = true
        if arrData.count < 1 {
            lblDataNotFound.isHidden = false
        }
        if arrData.count == 1 && arrData.first?.transitPaths?.count ?? 0 < 1 {
            lblDataNotFound.isHidden = false
            return 0
        }
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"JourneyplannerStationCell") as? JourneyplannerStationCell else  { return UITableViewCell() }
        let objdata = arrData[indexPath.row].journeyPlannerStationDetail
        cell.lblFromStation.text = objdata?.strFromStationName
        cell.lblToStation.text = objdata?.strToStationName
        cell.lblTime.text = (objdata?.stationArrival ?? "").getCurrentDatewithDash().toString(withFormat:"hh:mm a")
        cell.obj = objdata
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.PlanjourneyRouetDetailsVC()
        vc.objStation = objStation
        vc.objJourney = arrData[indexPath.row]
        vc.isFromFareCalVCValue = self.isFromFareCalVC
        self.navigationController?.pushViewController(vc, animated:true)
        
    }
    

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
}
