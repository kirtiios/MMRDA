//
//  FareCalVC.swift
//  MMRDA
//
//  Created by Kirti Chavda on 24/08/22.
//

import UIKit
import ACFloatingTextfield_Swift

class FareCalVC: BaseVC {

    @IBOutlet weak var lblFareCharge: UILabel!
    @IBOutlet weak var textTo: ACFloatingTextfield!
    @IBOutlet weak var textFrom: ACFloatingTextfield!
    private var  objViewModel = FareCalViewModel()
    
    
    @IBOutlet weak var btnSwitch: UIButton!
    @IBOutlet weak var btnTo: UIButton!
    @IBOutlet weak var btnFrom: UIButton!
    
    var objFareReponse:FareCalResponseModel?{
        didSet {
            lblFareCharge.superview?.isHidden = false
            lblFareCharge.text = "₹\(objFareReponse?.baseFare ?? 0)"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblFareCharge.superview?.isHidden  = true
        
        
        self.setBackButton()
        self.setRightHomeButton()
        self.navigationItem.title = "farecalculator".LocalizedString
        
        
        
        objViewModel.delegate = self
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
       

        // Do any additional setup after loading the view.
    }
    @IBAction func btnActionFareClicked(_ sender: UIButton) {
        objViewModel.getFareCalculator { fare in
            
        }
        
    }
    @IBAction func btnActionClicked(_ sender: UIButton) {
        
//        if sender == btnSearch {
//
//
//            if objViewModel.objFromFareStation == nil   {
//                objViewModel.inputErrorMessage.value = "tv_validate_from".localized()
//            }
//            else  if objViewModel.objTOFareStation == nil {
//                objViewModel.inputErrorMessage.value = "tv_validate_to".localized()
//            }else {
//
//                var param = [String:Any]()
//                param["intUserID"] = Helper.shared.objloginData?.intUserID
//                param["decFromStationLat"] = objFrom?.latitude
//                param["decFromStationLong"] =  objFrom?.longitude
//                param["decToStationLat"] = objTo?.latitude
//                param["decToStationLong"] = objTo?.longitude
//                param["strStationName"] =  ""
//
//
//                let objplanner = RecentPlaneStation(from_locationname: objFrom?.locationname ?? "", from_latitude: objFrom?.latitude ?? 0, from_longitude: objFrom?.longitude ?? 0, to_locationname: objTo?.locationname ?? "", to_latitude: objTo?.latitude ?? 0, to_longitude: objTo?.longitude ?? 0)
//                let obj = self.arrRecentData.first { objdata in
//                    return objdata.from_locationname.lowercased() == objFrom?.locationname.lowercased()  && objdata.to_locationname.lowercased() == objTo?.locationname.lowercased()
//                }
//
//                if obj == nil {
//                    arrRecentData.insert(objplanner, at: 0)
//                    if let encoded = try? JSONEncoder().encode(arrRecentData) {
//                        UserDefaults.standard.set(encoded, forKey: userDefaultKey.journeyPlannerList.rawValue)
//                        UserDefaults.standard.synchronize()
//                    }
//                }else {
//                    self.arrRecentData.removeAll { objdata in
//                        return objdata.from_locationname.lowercased() == objFrom?.locationname.lowercased()  && objdata.to_locationname.lowercased() == objTo?.locationname.lowercased()
//                    }
//                    arrRecentData.insert(objplanner, at: 0)
//                }
//                objViewModel.getJourneyPlanner(param: param) { array in
//
//                    if array?.count == 1 && array?.first?.transitPaths?.count ?? 0 < 1 {
//                        self.showAlertViewWithMessage("", message: "tv_no_trip_found".localized())
//                        return
//                    }
//                    let vc =  UIStoryboard.JourneyPlannerStationListingVC()
//                    vc.objStation = objplanner
//                    vc.arrData = array ?? [JourneyPlannerModel]()
//                    self.navigationController?.pushViewController(vc, animated:true)
//                }
//            }
//
//
//        }
         if sender == btnSwitch {
            
            btnFrom .setTitle(nil, for: .normal)
            btnTo .setTitle(nil, for: .normal)
            let obj1 = self.objViewModel.objFromFareStation
             let obj2 = self.objViewModel.objTOFareStation
            if let obj = obj1 {
                btnTo .setTitle(obj.sationname, for: .normal)
                self.objViewModel.objTOFareStation = obj
            }
            if let obj = obj2 {
                btnFrom .setTitle(obj.sationname, for: .normal)
                self.objViewModel.objFromFareStation = obj
            }
        }
        else {
            
            let objtationList = UIStoryboard.FareStationsListVC()
            objtationList.objBindSelection = { obj in
                if sender == self.btnFrom {
                    self.btnFrom .setTitle(obj?.sationname, for: .normal)
                    self.objViewModel.objFromFareStation = obj
                }
                
                if sender == self.btnTo {
                    self.btnTo .setTitle(obj?.sationname, for: .normal)
                    self.objViewModel.objTOFareStation = obj
                }
                
            }
            self.navigationController?.pushViewController(objtationList, animated: true)
        }
    }
    @IBAction func btnActionBuyClicked(_ sender: UIButton) {
        
        var param = [String:Any]()
        param["intUserID"] = Helper.shared.objloginData?.intUserID
        param["decFromStationLat"] = objViewModel.objFromFareStation?.lattitude
        param["decFromStationLong"] =  objViewModel.objFromFareStation?.longitude
        param["decToStationLat"] = objViewModel.objTOFareStation?.lattitude
        param["decToStationLong"] = objViewModel.objTOFareStation?.longitude
        param["strStationName"] =  ""
        
        let objstation = RecentPlaneStation(from_locationname: objViewModel.objFromFareStation?.sationname ?? "", from_latitude: objViewModel.objFromFareStation?.lattitude ?? 0, from_longitude: objViewModel.objFromFareStation?.longitude ?? 0, to_locationname: objViewModel.objTOFareStation?.sationname ?? "", to_latitude: objViewModel.objTOFareStation?.lattitude ?? 0, to_longitude: objViewModel.objTOFareStation?.longitude ?? 0)
       
        objViewModel.getJourneyPlanner(param: param) { array in
            
            if array?.count == 1 && array?.first?.transitPaths?.count ?? 0 < 1 {
                self.showAlertViewWithMessage("", message: "tv_no_trip_found".localized())
                return
            }
            let vc =  UIStoryboard.JourneyPlannerStationListingVC()
            vc.objStation = objstation
            vc.arrData = array ?? [JourneyPlannerModel]()
            self.navigationController?.pushViewController(vc, animated:true)
        }
    }

   

}
extension FareCalVC:UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        let objtationList = UIStoryboard.FareStationsListVC()
        objtationList.objBindSelection = { obj in
            if textField == self.textFrom {
                
                textField.text = obj?.sationname
                self.objViewModel.objFromFareStation = obj
            }
            
            if textField == self.textTo {
                textField.text = obj?.sationname
                self.objViewModel.objTOFareStation = obj
            }
            
        }
        self.navigationController?.pushViewController(objtationList, animated: true)
        
        return false
    }
}
extension FareCalVC:ViewcontrollerSendBackDelegate {
    func getInformatioBack<T>(_ handleData: inout T) {
        if let data = handleData as? [FareCalResponseModel] {
            objFareReponse = data.first
        }
    }
}
