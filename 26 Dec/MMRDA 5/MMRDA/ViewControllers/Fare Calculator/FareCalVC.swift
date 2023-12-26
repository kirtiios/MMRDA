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
    @IBOutlet weak var lblFareTitle: UILabel!
    @IBOutlet weak var textTo: ACFloatingTextfield!
    @IBOutlet weak var textFrom: ACFloatingTextfield!
    private var  objViewModel = FareCalViewModel()
    
    @IBOutlet weak var btnTrasportModeMetro: UIButton!
    
    @IBOutlet weak var viewMBMCbusBack: UIView!
    @IBOutlet weak var viewMetroBack: UIView!
    @IBOutlet weak var btnTrasportModeMBMCBus: UIButton!
    @IBOutlet weak var btnSwitch: UIButton!
    @IBOutlet weak var btnTo: UIButton!
    @IBOutlet weak var btnFrom: UIButton!
    
    
    @IBOutlet var lblTripTypeTitle:UILabel!
    @IBOutlet var imgOneTrip:UIImageView!
    @IBOutlet var imgReturn:UIImageView!
    @IBOutlet var btnOnetrip:UIButton!
    @IBOutlet var btnReturn:UIButton!
    
    @IBOutlet var viewBackFare:UIView!
    
    @IBOutlet var btnBookTicket:UIButton!
    
    var intTicketCode = 118
    
    
    var objFareReponse:FareCalResponseModel?{
        didSet {
            lblFareCharge.superview?.isHidden = false
            self.lblFareCharge.isHidden = false
            self.lblFareTitle.isHidden = false
            lblFareCharge.text = "₹\(objFareReponse?.discountedFare ?? 0)"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        lblFareCharge.superview?.isHidden  = true
        
        self.setBackButton()
        self.setRightHomeButton()
        self.navigationItem.title = "bookticket".LocalizedString
        
        objViewModel.delegate = self
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.view.hideToastActivity()
                    self?.view.makeToast(message)
                }
            }
        }
       
        viewMetroBack.borderColor = UIColor(hexString: "#00397E")
        viewMBMCbusBack.borderColor = .clear
        // Do any additional setup after loading the view.
    }
    @IBAction func btnActionFareClicked(_ sender: UIButton) {
        objViewModel.getFareCalculator(completion: { fare in
            self.btnBookTicket.isHidden = false
        }, intTicketCodePass: self.intTicketCode)
        
       
//        objViewModel.getFareCalculator { fare in
//
//        }
        
    }
    @IBAction func btnTrasportModeMBMCBusClick(_ sender: UIButton) {
//        viewMetroBack.borderColor = .clear
//        viewMBMCbusBack.borderColor = UIColor(hexString: "#00397E")
    }
    @IBAction func btnTrasportModeMetroClick(_ sender: UIButton) {
//        viewMetroBack.borderColor = UIColor(hexString: "#00397E")
//        viewMBMCbusBack.borderColor = .clear
    }
    @IBAction func btnOneTripClick(_ sender: UIButton) {
        if imgOneTrip.image == UIImage(named: "radioUnSelected"){
            imgOneTrip.image = UIImage(named: "radioSelected")
            imgReturn.image = UIImage(named: "radioUnSelected")
            self.intTicketCode = 118
        }else{
            imgOneTrip.image = UIImage(named: "radioSelected")
            imgReturn.image = UIImage(named: "radioUnSelected")
            self.intTicketCode = 118
        }
        self.btnBookTicket.isHidden = true
        if self.lblFareCharge.superview?.isHidden == false {
            self.lblFareCharge.isHidden = true
            self.lblFareTitle.isHidden = true
//            self.btnBookTicket.isHidden = true
        }
      //  viewBackFare.isHidden = true
    }
    @IBAction func btnReturnTripClick(_ sender: UIButton) {
        if imgReturn.image == UIImage(named: "radioUnSelected"){
            imgOneTrip.image = UIImage(named: "radioUnSelected")
            imgReturn.image = UIImage(named: "radioSelected")
            self.intTicketCode  = 119
        }else{
            imgReturn.image = UIImage(named: "radioSelected")
            imgOneTrip.image = UIImage(named: "radioUnSelected")
            self.intTicketCode  = 119
        }
        self.btnBookTicket.isHidden = true
        if self.lblFareCharge.superview?.isHidden == false {
            self.lblFareCharge.isHidden = true
            self.lblFareTitle.isHidden = true
//            self.btnBookTicket.isHidden = true
            
        }
        //viewBackFare.isHidden = true
        
    }
    @IBAction func btnActionClicked(_ sender: UIButton) {
        

         if sender == btnSwitch {
            
             if self.objViewModel.objTOFareStation == nil  || self.objViewModel.objFromFareStation == nil {
                 self.objViewModel.inputErrorMessage.value = "please_select_from_and_to_stations_to_swipe".localized()
                 return
             }
            btnFrom .setTitle(nil, for: .normal)
            btnTo .setTitle(nil, for: .normal)
            let obj1 = self.objViewModel.objFromFareStation
             let obj2 = self.objViewModel.objTOFareStation
            if let obj = obj1 {
                btnTo .setTitle(obj.displaystationname, for: .normal)
                self.objViewModel.objTOFareStation = obj
            }
            if let obj = obj2 {
                btnFrom .setTitle(obj.displaystationname, for: .normal)
                self.objViewModel.objFromFareStation = obj
            }
        }
        else {
            
            let objtationList = UIStoryboard.FareStationsListVC()
            objtationList.objBindSelection = { obj in
                if sender == self.btnFrom {
                    self.btnFrom .setTitle(obj?.displaystationname, for: .normal)
                    self.objViewModel.objFromFareStation = obj
                }
                
                if sender == self.btnTo {
                    self.btnTo .setTitle(obj?.displaystationname, for: .normal)
                    self.objViewModel.objTOFareStation = obj
                }
                
                if self.lblFareCharge.superview?.isHidden == false {
                    self.lblFareCharge.isHidden = true
                    self.lblFareTitle.isHidden = true
                    
//                    self.btnBookTicket.isHidden = true
                }
            }
            self.navigationController?.pushViewController(objtationList, animated: true)
        }
    }
    @IBAction func btnActionBuyClicked(_ sender: UIButton) {
        
        
        if objViewModel.objTOFareStation?.stationid == objViewModel.objFromFareStation?.stationid {
            objViewModel.inputErrorMessage.value = "tv_from_to_validate".LocalizedString
            return
        }
        
        var param = [String:Any]()
        param["intUserID"] = Helper.shared.objloginData?.intUserID
        param["decFromStationLat"] = "\(objViewModel.objFromFareStation?.lattitude ?? 0)"
        param["decFromStationLong"] = "\( objViewModel.objFromFareStation?.longitude ?? 0)"
        param["decToStationLat"] = "\(objViewModel.objTOFareStation?.lattitude ?? 0)"
        param["decToStationLong"] = "\(objViewModel.objTOFareStation?.longitude ?? 0)"
        param["strStationName"] =  ""
        param["isReturnJourney"] = false
        param["decCyclingRange"] = 0
        param["decWalkingRange"] = 0
        param["isArrivalBased"] = false
        param["isAutoTaxiTransport"] = true
        param["isBusTransport"] = true
        param["isCyclingTransport"] = true
        param["isMetroTransport"] = true
        param["strHoltTime"] = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        param["strSelectedTime"] = dateFormatter.string(from: Date())
        let objstation = RecentPlaneStation(from_locationname: objViewModel.objFromFareStation?.sationname ?? "", from_latitude: objViewModel.objFromFareStation?.lattitude ?? 0, from_longitude: objViewModel.objFromFareStation?.longitude ?? 0, to_locationname: objViewModel.objTOFareStation?.sationname ?? "", to_latitude: objViewModel.objTOFareStation?.lattitude ?? 0, to_longitude: objViewModel.objTOFareStation?.longitude ?? 0)
//       
//        objViewModel.getJourneyPlanner(param: param) { array in
//            if array?.count == 1 && array?.first?.upwardTrip?.first?[0].transitPaths?.count ?? 0 < 1 {
//                self.showAlertViewWithMessage("", message: "tv_no_trip_found".localized())
//                return
//            }
            let vc = UIStoryboard.NewPlaneJourneyVC()
            vc.QuickFromstationName = self.objViewModel.objFromFareStation?.sationname ?? ""
            vc.QuickToStationName = self.objViewModel.objTOFareStation?.sationname ?? ""
            vc.objFrom = planeStation(locationname: self.objViewModel.objFromFareStation?.sationname ?? "", latitude: self.objViewModel.objFromFareStation?.lattitude ?? 0.0, longitude: self.objViewModel.objFromFareStation?.longitude ?? 0.0)
            
            vc.objTo = planeStation(locationname: self.objViewModel.objTOFareStation?.sationname ?? "", latitude: self.objViewModel.objTOFareStation?.lattitude ?? 0.0, longitude: self.objViewModel.objTOFareStation?.longitude ?? 0.0)
            
            vc.objFrom?.locationname = self.objViewModel.objFromFareStation?.sationname ?? ""
            vc.objTo?.locationname = self.objViewModel.objTOFareStation?.sationname ?? ""
            vc.objFrom?.latitude = self.objViewModel.objFromFareStation?.lattitude ?? 0.0
            vc.objFrom?.longitude = self.objViewModel.objFromFareStation?.longitude ?? 0.0
            
            vc.objTo?.latitude = self.objViewModel.objTOFareStation?.lattitude ?? 0.0
            vc.objTo?.longitude = self.objViewModel.objTOFareStation?.longitude ?? 0.0
            self.navigationController?.pushViewController(vc, animated:true)
            
//            if self.intTicketCode  == 119{
//                let vc =  UIStoryboard.UpwordNewJourneyVC()
//
//                vc.upwardRoundTrip = array?.first?.upwardTrip?[0].transitPaths as? [TransitPaths]
//                vc.upwardRoundJourney = array?.first?.upwardTrip?[0].journeyPlannerStationDetail
//                vc.newupwordtrip = array?.first?.upwardTrip as?[JourneyPlannerModel]
//
//                vc.downwardTripReturn = array?.first?.downwardTrip?[0].transitPaths as? [TransitPaths]
//                vc.downwardJourneyReturn = array?.first?.downwardTrip?[0].journeyPlannerStationDetail
//                self.navigationController?.pushViewController(vc, animated:true)
//            }else{
////                let vc =  UIStoryboard.UpwordNewJourneyVC()
////                vc.upwardRoundTrip = array?.first?.upwardTrip?[0].transitPaths as? [TransitPaths]
////                vc.upwardRoundJourney = array?.first?.upwardTrip?[0].journeyPlannerStationDetail
////                vc.newupwordtrip = array?.first?.upwardTrip as?[JourneyPlannerModel]
////
////                vc.downwardTripReturn = array?.first?.downwardTrip?[0].transitPaths as? [TransitPaths]
////                vc.downwardJourneyReturn = array?.first?.downwardTrip?[0].journeyPlannerStationDetail
////                self.navigationController?.pushViewController(vc, animated:true)
//
//                let vc =  UIStoryboard.JourneyPlannerStationListingVC()
//                vc.objStation = objstation
//                vc.arrData = array?.first?.upwardTrip ?? [JourneyPlannerModel]()
//                vc.isFromFareCalVC = true
//                self.navigationController?.pushViewController(vc, animated:true)
//            }
      //  }
    }

   

}
extension FareCalVC:UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        let objtationList = UIStoryboard.FareStationsListVC()
        objtationList.objBindSelection = { obj in
            if textField == self.textFrom {
                
                textField.text = obj?.displaystationname
                self.objViewModel.objFromFareStation = obj
            }
            
            if textField == self.textTo {
                textField.text = obj?.displaystationname
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
