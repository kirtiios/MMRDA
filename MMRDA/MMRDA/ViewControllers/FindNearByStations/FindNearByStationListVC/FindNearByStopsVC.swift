//
//  FindNearByStopsVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 22/08/22.
//

import UIKit
import GoogleMaps

class FindNearByStopsVC: BaseVC {

    @IBOutlet weak var lblTotalVehcile: UILabel!
    @IBOutlet weak var tblSearchResult: UITableView!
    @IBOutlet weak var viewSearchResult: UIView!
    @IBOutlet weak var txtSearchBar: UITextField!
    @IBOutlet weak var btnTaxi: UIButton!
    @IBOutlet weak var btnTrain: UIButton!
    @IBOutlet weak var btnBus: UIButton!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var dataContentView: UIView!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var lblNoDataFound: UILabel!
    @IBOutlet weak var searchBarView: UIView!
    
    @IBOutlet weak var btnClose: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.callBarButtonForHome(isloggedIn:true,leftBarLabelName:"findnearbybusstops".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        actionTransportMediaChange(btnTrain)
    }
    
    // Chnage Bus,Train,Taxi
    @IBAction func actionTransportMediaChange(_ sender: UIButton) {
        if sender.tag == 101 {
            btnTrain.setImage(UIImage(named: "metroSelected"), for:.normal)
            btnTaxi.setImage(UIImage(named: "carUnselected"), for:.normal)
            btnBus.setImage(UIImage(named: "busUnselected"), for:.normal)
        }else if sender.tag == 102 {
            btnTrain.setImage(UIImage(named: "metroUnselected"), for:.normal)
            btnTaxi.setImage(UIImage(named: "carUnselected"), for:.normal)
            btnBus.setImage(UIImage(named: "busSelected"), for:.normal)
        }else{
            btnTrain.setImage(UIImage(named: "metroUnselected"), for:.normal)
            btnTaxi.setImage(UIImage(named: "carSelected"), for:.normal)
            btnBus.setImage(UIImage(named: "busUnselected"), for:.normal)
        }
    }
}


extension FindNearByStopsVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"TransportDataCell") as? TransportDataCell else  { return UITableViewCell() }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.StationListingVC()
        self.navigationController?.pushViewController(vc!, animated:true)
    }
    
    
}
