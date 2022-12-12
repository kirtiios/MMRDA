//
//  PaymentVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 26/08/22.
//

import UIKit
import DropDown
import LocalAuthentication

enum frompage:String {
    case NearByStop
    case JourneyPlanner
    case QRCodeGenerator
}

class PaymentVC: BaseVC {
    
    @IBOutlet weak var lblPenalityText: UILabel!
    @IBOutlet weak var btnTotalAmount: UIButton!
    @IBOutlet weak var btnDistance: UIButton!
    @IBOutlet weak var btnChild: UIButton!
    @IBOutlet weak var btnSeniorcitizen: UIButton!
    @IBOutlet weak var btndifferentlyEnabled: UIButton!
    @IBOutlet weak var btnAddult: UIButton!
    @IBOutlet weak var btnNoOfPassengers: UIButton!
    @IBOutlet weak var btnToStation: UIButton!
    @IBOutlet weak var btnFromStation: UIButton!
    @IBOutlet weak var tblPayment: UITableView!
    @IBOutlet weak var constTblViewHeight: NSLayoutConstraint!
    @IBOutlet weak var constTblPaymentHeight: NSLayoutConstraint!
    @IBOutlet weak var tblview: UITableView!
    @IBOutlet weak var btnViewFare: UIButton!
    
    var fromType:frompage = .NearByStop
    
    var objViewModel = PaymentViewModel()
    let dropDown = DropDown()
    var objStation:StationListModel?
    var arrStationList = [FareStationListModel]()
    var ispayMentGateway = Bool()
    
    var fromStationCode:String?
    var objToStation:FareStationListModel?
    var objFareCal:FareCalResponseModel?
    var objFromStation:FareStationListModel?
    var objJourney:JourneyPlannerModel?
    
    var objTicket:myTicketList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ispayMentGateway = true
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"payment".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
        
        if fromType == .NearByStop {
            btnFromStation.setTitle(objFromStation?.displaystationname, for: .normal)
            btnToStation.setTitle(objStation?.strDestinationName, for: .normal)
        
            btnViewFare.isSelected = false
            var param = [String:Any]()
            param["intTripID"] = objStation?.intTripID
            param["intStationID"] = objFromStation?.stationid
            param["strStationName"] = ""
            objViewModel.getNearbyStation(param:param) { arrList in
                self.arrStationList = arrList ?? [FareStationListModel]()
                if self.arrStationList.count > 0 {
                    self.objToStation = self.arrStationList.first
                    self.btnToStation.setTitle(self.objToStation?.displaystationname, for:.normal)
                    self.getFareCalculatore()
                }
            }
            fromStationCode = "\(objFromStation?.stationCode ?? 0)"
        }
        else if fromType == .QRCodeGenerator {
            btnFromStation.setTitle(objTicket?.from_Station, for: .normal)
            btnToStation.setTitle(objTicket?.to_Station, for: .normal)
            lblPenalityText.text = "strPenaltyticket".localized()
            lblPenalityText.isHidden = false
            btnNoOfPassengers.isUserInteractionEnabled = false
            btnViewFare.isSelected = false
            var param = [String:Any]()
            param["intTripID"] = 0 //objTicket?.intTripID
            param["intStationID"] = objTicket?.from_StationId
            param["strStationName"] = ""
            objViewModel.getNearbyStation(param:param) { arrList in
                self.arrStationList = arrList ?? [FareStationListModel]()
                if self.arrStationList.count > 0 {
                    self.objToStation = self.arrStationList.first
                    self.btnToStation.setTitle(self.objToStation?.displaystationname, for:.normal)
                    self.getFareCalculatore()
                }
            }
            fromStationCode = "\(objFromStation?.stationCode ?? 0)"
            
            
        }
        else {
            btnFromStation.setTitle(objJourney?.journeyPlannerStationDetail?.strFromStationName, for: .normal)
            btnToStation.setTitle(objJourney?.journeyPlannerStationDetail?.strToStationName, for: .normal)
        
            btnViewFare.isSelected = false
            btnToStation.isUserInteractionEnabled = false
            btnToStation .setTitleColor(UIColor.lightGray, for: .normal)
            
            
            self.btnDistance.setTitle("\(self.objJourney?.journeyPlannerStationDetail?.km ?? 0) KM", for: .normal)
            self.btnTotalAmount .setTitle("Rs.\(self.objJourney?.journeyPlannerStationDetail?.fare ?? 0)", for: .normal)
        }
        
        // Do any additional setup after loading the view.
    }
    func getFareCalculatore(){
        
       // print("km",self.objToStation,self.objToStation?.km)
        self.btnDistance.setTitle("\(self.objToStation?.km ?? 0) KM", for: .normal)
        objViewModel.getFareCalculator(fromStationID:fromStationCode ?? "" , toStationID:"\(self.objToStation?.stationCode ?? 0)") { faremodel in
            self.objFareCal = faremodel
            self.btnTotalAmount .setTitle("Rs.\(faremodel?.baseFare ?? 0)", for: .normal)
        }
    }
    
    
    
    @IBAction func actionOpenFromStationList(_ sender: Any) {
        
    }
    
    
    @IBAction func actionOpenToStationList(_ sender: UIButton) {
        
        let arrayName = arrStationList.compactMap({
            return $0.displaystationname
        })
        dropDown.dataSource  = arrayName
        dropDown.anchorView = sender
        dropDown.direction = .bottom
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
        
       
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self?.btnToStation.setTitle(item, for:.normal)
           // self?.objStation?.strDestinationName = item
            self?.objToStation = self?.arrStationList[index]
         
            self?.getFareCalculatore()
            self?.tblview .reloadData()
        }
        dropDown.show()

        
    }
    
    @IBAction func actionOpenNoOfpassengersList(_ sender: UIButton) {
       
        dropDown.dataSource  = ["01","02","03","04","05","06"]
        dropDown.anchorView = sender
        dropDown.direction = .bottom
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
       
        dropDown.customCellConfiguration = { index ,item,cell in
            cell.optionLabel.textAlignment = .center
        }
//        dropDown.cellConfiguration = { [unowned self] (index, item) in
//          return "      \(item)"
//        }
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self?.btnNoOfPassengers.setTitle(item, for:.normal)
            
            
            let basicRate = self?.fromType == .NearByStop ? (self?.objFareCal?.baseFare ?? 0) : (self?.objJourney?.journeyPlannerStationDetail?.fare ?? 0)
            
            let num2 = basicRate  * (Int(item) ?? 0)
            
            self?.btnTotalAmount .setTitle("Rs.\(num2)", for: .normal)
            
            self?.tblview.reloadData()
           
        }
        dropDown.show()
    }
    
    @IBAction func actionOpenAdultCategory(_ sender: Any) {
        
    }
    
    @IBAction func actionOpenChildCategory(_ sender: Any) {
        
    }
    
    @IBAction func actionOpenHandicapCategory(_ sender: Any) {
        
    }
    
    @IBAction func actionOpenSeniorCitizenCategory(_ sender: Any) {
        
    }
    @IBAction func actionViewFareOptionsList(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        tblview.reloadData()
    }
    
    @IBAction func actionCancel(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
//        let root = UIWindow.key?.rootViewController!
//        if let firstPresented = UIStoryboard.PaymentFailedVC() {
//            firstPresented.modalTransitionStyle = .crossDissolve
//            firstPresented.modalPresentationStyle = .overCurrentContext
//            root?.present(firstPresented, animated: false, completion: nil)
//        }
    }
    
    @IBAction func actionPayNow(_ sender: UIButton) {
        
        let basicRate:Int = fromType == .NearByStop ? (objFareCal?.baseFare ?? 0) : (objJourney?.journeyPlannerStationDetail?.fare ?? 0)
        
        if ispayMentGateway == false {
            self.objViewModel.inputErrorMessage.value = "tv_payment_options_valid".localized()
        }
        
        if ispayMentGateway == false || basicRate == 0 {
            return
        }
        
        func gotoPaymentApi(){
            let numberQty = self.btnNoOfPassengers.title(for:.normal) ?? "0"
            
            
            
            let num1 = Int(numberQty) ?? 0
            
            
            let rewardAmount = 0
            let discount = 0
            
            let total = ((num1 * basicRate) - discount)
            
            var param = [String:Any]()
            param["decKM"] = 0
            param["decTotalKM"] = 0
            var strLineNumber = ""
            
            if fromType == .NearByStop {
                param["fltTotalDistanceTravelled"] = self.objStation?.arrRouteData?.first?.strKM
                param["intFromStationID"] = self.objFromStation?.stationid
                param["intRouteID"] = self.objStation?.arrRouteData?.first?.intRouteID
                param["intToStationID"] = self.objToStation?.stationid
                strLineNumber = self.objStation?.strMetroLineNo ?? ""
                
                
            }
            else if fromType == .QRCodeGenerator {
                param["fltTotalDistanceTravelled"] = self.objStation?.arrRouteData?.first?.strKM
                param["intFromStationID"] = self.objTicket?.from_StationId
                param["intRouteID"] = self.objStation?.arrRouteData?.first?.intRouteID
                param["intToStationID"] = self.objTicket?.to_StationId
            }
            else {
                param["fltTotalDistanceTravelled"] = self.objJourney?.journeyPlannerStationDetail?.km
                param["intFromStationID"] = self.objJourney?.journeyPlannerStationDetail?.intFromStationID
                param["intRouteID"] = self.objJourney?.transitPaths?.first?.routeid
                param["intToStationID"] = self.objJourney?.journeyPlannerStationDetail?.intToStationID
                strLineNumber = self.objJourney?.transitPaths?.first?.routeno ?? ""
            }
            
            
            param["intBasicFare"] = basicRate
            param["intDisscount"] = 0
            
            param["intPaidAmount"] = total - rewardAmount
            param["intPaybleAmount"] = total - discount
            param["intPlatformID"] = 3
            param["intRewardAmount"] = rewardAmount //static now
            param["intServiceTypeID"] = 0
            param["intTicketAmount"] = basicRate
            param["intTotalFare"] = total
            param["intTotalQty"] = numberQty
            param["intTotalTicketAmount"] = total
            param["intTransportModeID"] = 0
            param["intUserID"] = Helper.shared.objloginData?.intUserID
            param["isredeem"] = 0
            param["strPaymentMode"] = "PG"
            param["strPlatformType"] = "IOS"
            param["strCategoryWiseJSON"] = [["intBasicFare":0,"intCategoryID":0,"intTotalFare":0,"intTotalQty":0]]
            param["strTransportWiseJSON"] = [["decKM":0,
                                              "intBasicFare":basicRate,
                                              "intFromStationID": param["intFromStationID"],
                                              "intRouteID":param["intRouteID"],
                                              "intServiceTypeID":0,
                                              "intToStationID":param["intToStationID"],
                                              "intTotalFare":total,
                                              "intTotalQty":numberQty ,
                                              "strLine":strLineNumber,
                                              "intTransportModeID":0]]
            
            objViewModel.insertTicketHistory(param: param) { paymentModel in
                
                if let objmodel = paymentModel {

                    let obj = PaymentWebViewVC(nibName: "PaymentWebViewVC", bundle: nil)
                    obj.objPayment = objmodel
                    obj.completionBlock = { sucess in
                        var param = [String:Any]()
                        param["UserID"] = Helper.shared.objloginData?.intUserID
                        param["strTicketRefrenceNo"] = paymentModel?.strTicketRefrenceNo
                        param["intFlag"] = 0
                        param["intPageNo"] = 0
                        param["intPageSize"] = 0
                        self.objViewModel.getTicketHistory(param:param) { objticketarr in
                            if objticketarr?.count ?? 0 > 0 {
                              
                                if let firstPresented = UIStoryboard.ConfirmPaymentVC() {
                                    firstPresented.paymentStatus = sucess
                                    firstPresented.fromType = self.fromType
                                    firstPresented.strPaymentStatus = objticketarr?.first?.strPaymentStatus ?? ""
                                    firstPresented.arrHistory = objticketarr ?? [myTicketList]()
                                    firstPresented.objPayment = paymentModel
                                    firstPresented.modalTransitionStyle = .crossDissolve
                                    firstPresented.modalPresentationStyle = .overCurrentContext
                                    firstPresented.completionBlockCancel = { sucss in
                                        self.navigationController?.popViewController(animated: true)
                                    }
                                    firstPresented.completionBlockViewTicket = { sucss in
                                        let vc = UIStoryboard.ViewTicketVC()
                                        vc.objPayment = paymentModel
                                        vc.arrHistory =  objticketarr ?? [myTicketList]()
                                        self.navigationController?.pushViewController(vc, animated:true)
                                    }
                                    self.present(firstPresented, animated: false, completion: nil)
                                }
                            }
                        }
                        
                        
                    }
                    self.navigationController?.pushViewController(obj, animated: true)
                }
                
            }
            
        }
        
        Helper.shared.authenticationWithTouchID { sucess in
            if sucess {
               gotoPaymentApi()
            }
        }
        
        
        
        
        
        
//        {
//          "decKM": 0.0, // static
//          "decTotalKM": 0.0,  // static
//          "fltTotalDistanceTravelled": 18.0, // dynamic
//          "intBasicFare": 0,
//          "intDisscount": 0,  // static
//          "intFromStationID": 47,
//          "intPaidAmount": 0,
//          "intPaybleAmount": 0,
//          "intPlatformID": 2,/ // ask backend
//          "intRewardAmount": 0,
//          "intRouteID": 4,
//          "intServiceTypeID": 0, // static
//          "intTicketAmount": 0, // base amount
//          "intToStationID": 46,
//          "intTotalFare": 0,
//          "intTotalQty": 1,
//          "intTotalTicketAmount": 0,
//          "intTransportModeID": 0,
//          "intUserID": 129,
//          "isredeem": 0,
//          "strCategoryWiseJSON": [
//            {
//              "intBasicFare": 0,
//              "intCategoryID": 0,
//              "intTotalFare": 0,
//              "intTotalQty": 0
//            }
//          ],
//          "strPaymentMode": "PG",
//          "strPlatformType": "Android",
//          "strTransportWiseJSON": [
//            {
//              "decKM": 0.0,
//              "intBasicFare": 0,
//              "intFromStationID": 47,
//              "intRouteID": 4,
//              "intServiceTypeID": 0,
//              "intToStationID": 46,
//              "intTotalFare": 0,
//              "intTotalQty": 1,
//              "intTransportModeID": 0
//            }
//          ]
//        }
        
      
       
        
    
        
        

        
        
        
    }
   
    
}



extension PaymentVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblPayment {
            return 1
        }
        return  btnViewFare.isSelected ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblPayment {
            guard let cell = tableView.dequeueReusableCell(withIdentifier:"PaymentOptionsCell") as? PaymentOptionsCell else  { return UITableViewCell() }
            cell.btnSelection.tag = indexPath.row
            if indexPath.row == 0 {
                cell.lblPaymentTitle.text = "tv_payment_gateway".localized()
                cell.lblPaymentDetail.text = "tv_credit_card_debit_card_net_banking_e_wallet_net_banking".localized()
                cell.btnSelection.isSelected = true
            }
            cell.completionPayment = { sucess in
                self.ispayMentGateway = sucess
            }
            
            DispatchQueue.main.async {
                self.constTblViewHeight.constant = tableView.contentSize.height
                self.tblPayment.layoutIfNeeded()
            }
            
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier:"PaymentAmountDetailCell") as? PaymentAmountDetailCell else  { return UITableViewCell() }
            
            var fare = 0
            
            if fromType == .NearByStop {
                fare = objFareCal?.baseFare ?? 0
                cell.lblRouteNo.text = objStation?.strMetroLineNo ?? ""
                cell.lblFromStation.text = objStation?.strSourceName ?? ""
                cell.lblToStation.text =  objToStation?.displaystationname
               
            }else {
                fare = objJourney?.journeyPlannerStationDetail?.fare ?? 0
                cell.lblRouteNo.text = objJourney?.transitPaths?.first?.routeno
                cell.lblFromStation.text = objJourney?.journeyPlannerStationDetail?.strFromStationName
                cell.lblToStation.text = objJourney?.journeyPlannerStationDetail?.strToStationName
               
            }
            cell.lblBaseRate.text = "\(fare)"
            cell.lblAdultCount.text = btnNoOfPassengers.title(for: .normal)
            let num1 = Int(cell.lblAdultCount.text ?? "0") ?? 0
            cell.lblAmountinRS.text = "Rs.\(num1 * fare)"
            cell.lblAmountinRS_topSide.text = "Rs.\(fare)"
            
            DispatchQueue.main.async {
                self.constTblPaymentHeight.constant = tableView.contentSize.height
                self.tblview.layoutIfNeeded()
            }
            
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
}

