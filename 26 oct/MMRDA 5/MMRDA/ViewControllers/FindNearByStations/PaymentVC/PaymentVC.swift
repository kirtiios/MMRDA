//
//  PaymentVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 26/08/22.
//

import UIKit
import DropDown
import LocalAuthentication
import SVProgressHUD

enum frompage:String {
    case NearByStop
    case JourneyPlanner
    case QRCodePenalty
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
    var boolPaymentGetway = false
    
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
    var objJourneyDownward:JourneyPlannerModel?
    
    var objTicket:myTicketList?
    var objPenaltyData:PenaltyDetails?
    var discountedFare:Int?
    var sumFinalRsDisplay:Int?
    var isfromSuggestedItineratyVCPass = false
    var isfromUpwoedNewJourneyVcPass = false
    
    var downfare = 0.0
    var isRoundJourney = false
    
   
    var passintTicketCode:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        lblPenalityText.superview?.isHidden = true
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
                   // DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self.getFareCalculatore(toStationid: "\(self.objToStation?.stationCode ?? 0)")
                  //  })
                   
                }
            }
            fromStationCode = "\(objFromStation?.stationCode ?? 0)"
        }
        else if fromType == .QRCodePenalty {
//            if objPenaltyData?.errorReasonCode == 6{
//                btnFromStation.setTitle(objTicket?.from_Station, for: .normal)
//                btnToStation.setTitle(objTicket?.to_Station, for: .normal)
//            }else{
//                btnFromStation.setTitle(objTicket?.to_Station, for: .normal)
//                btnToStation.setTitle(objPenaltyData?.strStationName, for: .normal)
//            }
            lblPenalityText.text = "strPenaltyReason".localized() + (objPenaltyData?.errorReasonDescription ?? "")
            lblPenalityText.superview?.isHidden = false
            btnNoOfPassengers.isUserInteractionEnabled = false
            btnViewFare.isSelected = false
            fromStationCode = "\(objTicket?.to_StationId ?? 0)"
            
           // self.getFareCalculatore(isPenalty: true,toStationid:"\(objPenaltyData?.intStationID ?? 0)") // it calling in willwillapear
            self.btnDistance.setTitle("\(self.objJourney?.journeyPlannerStationDetail?.km ?? 0) KM", for: .normal)
            let sum = (self.objPenaltyData?.surcharge ?? 0) + (self.objPenaltyData?.penalty ?? 0)
             sumFinalRsDisplay  =  sum/100
            self.btnTotalAmount.setTitle("RS.\(sumFinalRsDisplay ?? 0)", for: .normal)
            //self.btnTotalAmount .setTitle("Rs.\(self.objPenaltyData?.surcharge ?? 0 + (self.objPenaltyData?.penalty ?? 0))", for: .normal)
//            var param = [String:Any]()
//            param["intTripID"] = 0 //objTicket?.intTripID
//            param["intStationID"] = objPenaltyData?.intStationID
//            param["strStationName"] = ""
//            objViewModel.getNearbyStation(param:param) { arrList in
//                self.arrStationList = arrList ?? [FareStationListModel]()
//                if self.arrStationList.count > 0 {
//                    self.objToStation = self.arrStationList.first
//                    self.btnToStation.setTitle(self.objToStation?.displaystationname, for:.normal)
//                    self.getFareCalculatore()
//                }
//            }
//            fromStationCode = "\(objFromStation?.stationCode ?? 0)"
            self.btnFromStation.setTitle(objPenaltyData?.strStationName ?? "", for: .normal)
            self.btnToStation.setTitle(objPenaltyData?.strStationName ?? "", for: .normal)
            
        }
        else {
            btnFromStation.setTitle(objJourney?.journeyPlannerStationDetail?.strFromStationName, for: .normal)
            btnToStation.setTitle(objJourney?.journeyPlannerStationDetail?.strToStationName, for: .normal)
        
            btnViewFare.isSelected = false
            btnToStation.isUserInteractionEnabled = false
            btnToStation .setTitleColor(UIColor.lightGray, for: .normal)
            
            
            self.btnDistance.setTitle("\(self.objJourney?.journeyPlannerStationDetail?.km ?? 0) KM", for: .normal)
            let downfare_value = Int(downfare)
            let cal = downfare_value + Int(self.objJourney?.journeyPlannerStationDetail?.fare ?? 0)
            print(cal)
            if isfromUpwoedNewJourneyVcPass {
                self.btnTotalAmount .setTitle("Rs.\(cal)", for: .normal)
            }else{
                self.btnTotalAmount .setTitle("Rs.\(self.objJourney?.journeyPlannerStationDetail?.fare ?? 0)", for: .normal)
            }
            
        }
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
//        if fromType == .QRCodePenalty {
//              self.getFareCalculatore(isPenalty: true,toStationid:"\(objPenaltyData?.intStationID ?? 0)")
//        }
    }
    func getFareCalculatore(isPenalty:Bool = false,toStationid:String){
        if isfromSuggestedItineratyVCPass == true{
            self.passintTicketCode = 118
        }else if isfromUpwoedNewJourneyVcPass == true{
            self.passintTicketCode = 119
        }else{
            self.passintTicketCode = 118
        }
        
       // print("km",self.objToStation,self.objToStation?.km)
        
        if self.objToStation?.km != nil{
            self.btnDistance.setTitle("\(self.objToStation?.km ?? 0) KM", for: .normal)
        }else{
            self.btnDistance.setTitle("\(self.objJourney?.journeyPlannerStationDetail?.km ?? 0) KM", for: .normal)
        }
//        self.btnDistance.setTitle("\(self.objToStation?.km ?? 0) KM", for: .normal)
//        self.btnDistance.setTitle("\(self.objJourney?.journeyPlannerStationDetail?.km ?? 0) KM", for: .normal)
        objViewModel.getFareCalculator(fromStationID:fromStationCode ?? "" , toStationID:toStationid,isPenality: isPenalty, intTicketCode: passintTicketCode ?? 0) { faremodel in
            self.objFareCal = faremodel
            if self.fromType == .QRCodePenalty {
                
            }else{
                self.btnTotalAmount .setTitle("Rs.\(faremodel?.baseFare ?? 0)", for: .normal)
            }
            self.discountedFare = faremodel?.discountedFare
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
            self?.getFareCalculatore(toStationid:"\(self?.objToStation?.stationCode ?? 0)")
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
            
            
            let basicRate = self?.fromType == .NearByStop ? (self?.objFareCal?.baseFare ?? 0) :  Int((self?.objJourney?.journeyPlannerStationDetail?.fare ?? 0))
            
            
            var num2 = Int(basicRate)  * (Int(item) ?? 0)
            if self?.isfromUpwoedNewJourneyVcPass == true{
                if self?.isRoundJourney == true{
                    num2 = Int(self?.downfare ?? 0)  * (Int(item) ?? 0) * 2
                }else{
                    num2 = Int(self?.downfare ?? 0)  * (Int(item) ?? 0)
                }
               // print(num3)
            }
            
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
        
       let newReturnJourney =  Int(downfare) + Int(self.objJourney?.journeyPlannerStationDetail?.fare ?? 0)
        
        let basicRate:Int = (fromType == .NearByStop ||  fromType == .QRCodePenalty)  ? (objFareCal?.baseFare ?? 0) : newReturnJourney
//        let basicRate:Int = (fromType == .NearByStop ||  fromType == .QRCodePenalty)  ? (objFareCal?.baseFare ?? 0) : Int((objJourney?.journeyPlannerStationDetail?.baseFare ?? 0))
        
        if ispayMentGateway == false {
            self.objViewModel.inputErrorMessage.value = "tv_payment_options_valid".localized()
        }
        
        if ispayMentGateway == false {//|| basicRate == 0 {
            return
        }
        
        func gotoPaymentApi(){
            let numberQty = Int(self.btnNoOfPassengers.title(for:.normal) ?? "0") ?? 0
            
            let num1 = Int(numberQty)
            let rewardAmount = 0
            let discount = 0
            
            let total = ((num1 * basicRate) - discount)
            let totalQR = ((num1 * (objTicket?.totaL_FARE ?? 0)) - discount)// sumFinalRsDisplay ?? 0  //((num1 * (objTicket?.totaL_FARE ?? 0)) - discount)
            var param = [String:Any]()
            param["intTicketCode"] =  118 //self.passintTicketCode
            param["intProductCode"] = 1
            
           
            var strLineNumber = ""
            
            if fromType == .NearByStop {
                param["fltTotalDistanceTravelled"] = self.objStation?.arrRouteData?.first?.strKM
                param["intFromStationID"] = self.objFromStation?.stationid
                param["intRouteID"] = self.objStation?.arrRouteData?.first?.intRouteID
                param["intToStationID"] = self.objToStation?.stationid
                strLineNumber = self.objStation?.strMetroLineNo ?? ""
                param["intDisscount"] = self.discountedFare
                param["intBasicFare"] = basicRate
                param["decTotalKM"] = 0
                param["decKM"] = 0
                param["intUpwardRouteID"] = self.objStation?.arrRouteData?.first?.intRouteID
            }
            else if fromType == .QRCodePenalty {
                param["fltTotalDistanceTravelled"] = 0
             //   param["intFromStationID"] = self.objTicket?.to_StationId ?? 0
                param["intRouteID"] = 0
                param["decKM"] = 0
            //    param["intToStationID"] = self.objPenaltyData?.intStationID ?? 0
                
//
//                if objPenaltyData?.errorReasonCode == 6{
//                    param["intFromStationID"] = objTicket?.from_Station
//                    param["intToStationID"] = objTicket?.to_Station
//                }else{
//                    param["intFromStationID"] = self.objTicket?.to_StationId ?? 0
//                    param["intToStationID"] = objPenaltyData?.intStationID ?? 0
//                }
                
                param["intFromStationID"] = objPenaltyData?.intStationID ?? 0
                param["intToStationID"] = objPenaltyData?.intStationID ?? 0
//                param["intUpwardRouteID"] = 8
                param["errorReasonCode"] =  objPenaltyData?.errorReasonCode
                param["errorStationCode"] = objPenaltyData?.errorStationCode
                param["destinationCode"] =  objPenaltyData?.destinationStationCode
                param["refTicketNumber"] =  objPenaltyData?.ticketNumber///objTicket?.strTicketRefrenceNo
                param["penalty"] =  objPenaltyData?.penalty
                param["surcharge"] = objPenaltyData?.surcharge
                param["feesCode"] =  objPenaltyData?.feesCode
                param["price"] =  objPenaltyData?.price
                param["strErrorReason"] =  objPenaltyData?.errorReasonDescription
                param["isPenalty"] =  true
                
                param["intBasicFare"] = objTicket?.totaL_FARE
                param["intDisscount"] = objTicket?.total_Amount
                param["decTotalKM"] = 0
//                errorReasonCode - Integer
//                errorStationCode -  Integer
//                destinationCode -  Integer
//                refTicketNumber - string (Actual ticket number on which penalty is applied)
//                penalty -  Integer
//                surcharge -  Integer
//                feesCode -  Integer
//                price -  Integer
//                strErrorReason - String
//                isPenalty - boolean (true)
            }
            else {
                
             
                
                param["intBasicFare"] = objJourney?.journeyPlannerStationDetail?.fare ?? 0//basicRate
                param["fltTotalDistanceTravelled"] = self.objJourney?.journeyPlannerStationDetail?.km ?? 0
                param["intFromStationID"] = self.objJourney?.journeyPlannerStationDetail?.intFromStationID ?? 0
                param["intToStationID"] = self.objJourney?.journeyPlannerStationDetail?.intToStationID ?? 0
                strLineNumber = self.objJourney?.transitPaths?.first?.routeno ?? ""
                param["intDisscount"] = Int(self.objJourney?.journeyPlannerStationDetail?.fare ?? 0)
                param["intBasicFare"] = objJourney?.journeyPlannerStationDetail?.fare ?? 0//basicRate
                param["intUpwardRouteID"] = objJourney?.journeyPlannerStationDetail?.transportWiseFares?.first?.intRouteID
                if isfromSuggestedItineratyVCPass{
                    param["intDownwardRouteID"] = objJourney?.journeyPlannerStationDetail?.transportWiseFares?.first?.intRouteID  //*
                }else{ // downword
                    param["intDownwardRouteID"] = objJourney?.journeyPlannerStationDetail?.transportWiseFares?.first?.intRouteID  //*
                }
                
                if let objJourneydown = objJourneyDownward {
                    param["intDownwardRouteID"] = objJourneydown.journeyPlannerStationDetail?.transportWiseFares?.first?.intRouteID  //*
                }
            }
            
            if fromType == .QRCodePenalty {
                param["intTotalFare"] =  objPenaltyData?.price
                param["strCategoryWiseJSON"] = [["intBasicFare":objTicket?.totaL_FARE,"intCategoryID":0,"intTotalFare":objPenaltyData?.price,"intTotalQty":numberQty]]
                
                param["strTransportWiseJSON"] = [["decKM":0,
                                                  "intBasicFare":objTicket?.totaL_FARE,//objPenaltyData?.price,
                                                  "intFromStationID": param["intFromStationID"],
                                                  "intRouteID":self.objJourney?.transitPaths?.first?.routeid,
                                                  "intServiceTypeID":0,
                                                  "intToStationID":param["intToStationID"],
                                                  "intTotalFare":objTicket?.totaL_FARE,//objFareCal?.baseFare ?? 0,//totalQR,
                                                  "intTotalQty":numberQty ,
                                                  "strLine":strLineNumber,
                                                  "intTransportModeID":1]]
            }else{
                
                param["intTotalFare"] = objFareCal?.discountedFare ?? 0//total
                param["strCategoryWiseJSON"] = [["intBasicFare":objJourney?.journeyPlannerStationDetail?.fare ?? 0,"intCategoryID":1,"intTotalFare":total,"intTotalQty":numberQty   ]]
                
                if fromType  == .NearByStop  {
                                    param["strTransportWiseJSON"] = [["decKM":objJourney?.journeyPlannerStationDetail?.km, //*
                                                                      "intBasicFare": param["intBasicFare"],//objJourney?.journeyPlannerStationDetail?.baseFare ?? 0,//basicRate ,
                                                                      "intFromStationID": param["intFromStationID"],
                                                                      "intRouteID":param["intRouteID"],
                                                                      "intServiceTypeID":objJourney?.journeyPlannerStationDetail?.transportWiseFares?.first?.intServiceTypeID,
                                                                      "intToStationID":param["intToStationID"],
                                                                      "intTotalFare":param["intBasicFare"],//objJourney?.journeyPlannerStationDetail?.transportWiseFares?.first?.individualFare ?? 0,//total,
                                                                      "intTotalQty":numberQty ,
                                                                      "intTransportModeID":1,
                                                                      "strLine":objJourney?.journeyPlannerStationDetail?.transportWiseFares?.first?.schNo ?? "",//strLineNumber ,
                    //                                                  "intTransportModeID":0,
                                                                      "strTransportNumber" : 0,
                                                                      "bReturnJourney":objJourney?.journeyPlannerStationDetail?.transportWiseFares?.first?.bReturnJourney ?? false]] ////trasportid
                }else {
                    
                    var arr = [[String:Any]]()
                    var dict1 = [String:Any]()
                    dict1["decKM"] = objJourney?.journeyPlannerStationDetail?.km
                    dict1["intToStationID"] = objJourney?.journeyPlannerStationDetail?.transportWiseFares?.first?.toStation ?? 0
                    dict1["intBasicFare"] = objJourney?.journeyPlannerStationDetail?.baseFare ?? 0
                    dict1["intFromStationID"] = objJourney?.journeyPlannerStationDetail?.transportWiseFares?.first?.fromStation ?? 0
                    dict1["intRouteID"] = objJourney?.journeyPlannerStationDetail?.transportWiseFares?.first?.intRouteID ?? 0
                    dict1["intServiceTypeID"] = objJourney?.journeyPlannerStationDetail?.transportWiseFares?.first?.intServiceTypeID ?? 0
                    dict1["intTotalFare"] = objJourney?.journeyPlannerStationDetail?.transportWiseFares?.first?.individualFare ?? 0
                    dict1["intTotalQty"] = numberQty//1
                    dict1["intTransportModeID"] = 1
                    dict1["strLine"] = objJourney?.journeyPlannerStationDetail?.transportWiseFares?.first?.schNo ?? ""
                    dict1["strTransportNumber" ] = 0
                    dict1["bReturnJourney"] = objJourney?.journeyPlannerStationDetail?.transportWiseFares?.first?.bReturnJourney ?? false
                    
                    arr .append(dict1)
                    if let objJourneydown = objJourneyDownward {
                        dict1 = [String:Any]()
                        dict1["decKM"] = objJourneydown.journeyPlannerStationDetail?.km
                        dict1["intBasicFare"] = objJourneydown.journeyPlannerStationDetail?.baseFare ?? 0
                        dict1["intFromStationID"] = objJourneydown.journeyPlannerStationDetail?.transportWiseFares?.first?.fromStation ?? 0
                        dict1["intRouteID"] = objJourneydown.journeyPlannerStationDetail?.transportWiseFares?.first?.intRouteID ?? 0
                        dict1[ "intServiceTypeID"] = objJourneydown.journeyPlannerStationDetail?.transportWiseFares?.first?.intServiceTypeID
                        dict1["intToStationID"] = objJourneydown.journeyPlannerStationDetail?.transportWiseFares?.first?.toStation ?? 0
                        dict1["intTotalFare"] = objJourneydown.journeyPlannerStationDetail?.transportWiseFares?.first?.individualFare ?? 0
                        dict1["intTotalQty"] = numberQty//1
                        dict1[ "intTransportModeID"] = 1
                        dict1["strLine"] = objJourneydown.journeyPlannerStationDetail?.transportWiseFares?.first?.schNo ?? ""
                        dict1["strTransportNumber" ] =  0
                        dict1["bReturnJourney"] = objJourneydown.journeyPlannerStationDetail?.transportWiseFares?.first?.bReturnJourney ?? false
                        
                        arr .append(dict1)
                    }
                    
                    param["strTransportWiseJSON"] = arr
                }
                

            }
//            strTransportNumber
//            bReturnJourney
            
         
         
            if fromType == .QRCodePenalty {
                param["intPaidAmount"] = totalQR - rewardAmount
                param["intPaybleAmount"] = totalQR - discount
            }else {
                param["intPaidAmount"] = total - rewardAmount
              
                //let fare = objJourney?.journeyPlannerStationDetail?.fare ?? 0
                let numberOfPassengers = Int(self.btnNoOfPassengers.titleLabel?.text ?? "") ?? 1
                param["intPaybleAmount"] = basicRate * numberOfPassengers /*fare * numberOfPassengers*/


//                param["intPaybleAmount"] = objJourney?.journeyPlannerStationDetail?.fare ?? 0 * (Int(self.btnTotalAmount.currentTitle ?? "") ?? 1)//total - discount
            }
            
        
            
            param["intPlatformID"] = 1//3 //*
            param["intRewardAmount"] = rewardAmount //static now
            param["intServiceTypeID"] = 0
            param["intTotalQty"] = numberQty
            param["intTotalTicketAmount"] = total
            if fromType == .QRCodePenalty {
                param["intTicketAmount"] = objPenaltyData?.penalty
            }else{
                param["intTicketAmount"] = basicRate
            }
            param["strPlatformType"] = "IOS"
            param["intTransportModeID"] = 0
            param["intUserID"] = Helper.shared.objloginData?.intUserID
            param["isredeem"] = 0
            param["strPaymentMode"] = "2,undefined"
          //  param["strPaymentMode"] = "PG"
            
            
            if self.boolPaymentGetway == false{
                param["intPaymentGateWayID"] = 2
            }else{
                param["intPaymentGateWayID"] = 1
            }
            if fromType == .NearByStop{
                let discountRent =  objFareCal?.discountedFare ?? 0
                let baseFare = objFareCal?.baseFare ?? 0
                let intTotalFare = baseFare * numberQty
                param["isredeem"] = 1
                param["intFromStationID"] = self.objFromStation?.stationid
                param["intToStationID"] = self.objToStation?.stationid
                param["intTicketCode"] = 118
                param["intProductCode"] = 1
                param["intUpwardRouteID"] = self.objStation?.arrRouteData?.first?.intRouteID
                param["intDownwardRouteID"] = 0
                param["intUserID"] = Helper.shared.objloginData?.intUserID
                param["intPlatformID"] = 1
                param["fltTotalDistanceTravelled"] = self.objStation?.arrRouteData?.first?.strKM
                param["intTotalQty"] = numberQty
                param["strPaymentMode"] = "2,undefined"
                param["intPaymentGateWayID"] = 2
                param["strCategoryWiseJSON"] = [["intBasicFare":baseFare,"intCategoryID": 1,"intTotalFare": objFareCal?.discountedFare ?? 0,"intTotalQty":numberQty]]
                param["strTransportWiseJSON"] = [["decKM":0,
                                                  "intBasicFare":baseFare,
                                                  "intFromStationID": param["intFromStationID"],
                                                  "intRouteID":self.objStation?.arrRouteData?.first?.intRouteID ?? 0,
                                                  "intServiceTypeID":0,
                                                  "intToStationID":param["intToStationID"],
                                                  "strTransportNumber": nil,
                                                  "intTotalFare":objFareCal?.discountedFare ?? 0,
                                                  "intTotalQty":numberQty ,
                                                  "strLine":strLineNumber,
                                                  "intTransportModeID":1]]
                param["intBasicFare"] = baseFare
                param["intDisscount"] = objFareCal?.discountedFare ?? 0
                param["intPaybleAmount"] = discountRent * numberQty
                param["intRewardAmount"] = 0
                param["intPaidAmount"] = baseFare
            }else if fromType == .QRCodePenalty{
                param["intTicketCode"] =  112 //self.passintTicketCode
                param["intProductCode"] = 8
            }
            
            objViewModel.insertTicketHistory(param: param) { paymentModel in
                
                if let objmodel = paymentModel {

                    let obj = PaymentWebViewVC(nibName: "PaymentWebViewVC", bundle: nil)
                    obj.objPayment = objmodel
                    obj.completionBlock = { sucess in
                        var param = [String:Any]()
                        param["UserID"] = Helper.shared.objloginData?.intUserID
                        param["strTicketRefrenceNo"] = paymentModel?.strTicketRefrenceNo
//                        param["intFlag"] = 0
//                        param["intPageNo"] = 0
//                        param["intPageSize"] = 0
                        self.objViewModel.getTicketHistory(param:param) { objticketarr in
                            SVProgressHUD .dismiss()
                            if objticketarr?.count ?? 0 > 0 {
                            
                            if let firstPresented = UIStoryboard.ConfirmPaymentVC() {
//                                DispatchQueue.main.asyncAfter(deadline:.now() + 0.5) {
                                firstPresented.paymentStatus = sucess
                                firstPresented.fromType = self.fromType
                                firstPresented.strPaymentStatus = objticketarr?.first?.strPaymentStatus ?? ""
                                firstPresented.arrHistory = objticketarr ?? [myTicketList]()
                                firstPresented.objPayment = paymentModel
                                firstPresented.modalTransitionStyle = .crossDissolve
                                firstPresented.modalPresentationStyle = .overCurrentContext
                                firstPresented.completionBlockCancel = { sucss in
                                    SVProgressHUD .dismiss()
                                    self.navigationController?.popViewController(animated: true)
                                }
                                firstPresented.completionBlockViewTicket = { sucss in
                                    SVProgressHUD .dismiss()
                                    let vc = UIStoryboard.ViewTicketVC()
                                    vc.objPayment = paymentModel
                                    vc.arrHistory =  objticketarr ?? [myTicketList]()
                                    self.navigationController?.pushViewController(vc, animated:true)
                                }
                                self.present(firstPresented, animated: false, completion: nil)
//                            }
                                }
                            }
                        }
                        
                    }
                    self.navigationController?.pushViewController(obj, animated: true)
                }
                
            }
            
        }
        
//        Helper.shared.authenticationWithTouchID(islogin: false) { sucess in
//            if sucess {
               gotoPaymentApi()
//            }
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
            cell.btn1Pay.tag = indexPath.row
//            if indexPath.row == 0 {
//                cell.lblPaymentTitle.text = "tv_payment_gateway".localized()
//                cell.lblPaymentDetail.text = "tv_credit_card_debit_card_net_banking_e_wallet_net_banking".localized()
//                cell.btnSelection.isSelected = true
//            }else{
//                cell.lblPaymentTitle.text = "txtPaymentGetWay".localized()
//                cell.lblPaymentDetail.text = "txt1PaySubtitle".localized()
//            }
            if boolPaymentGetway == true{
                cell.btnSelection.isSelected = true
                cell.btn1Pay.isSelected = false
            
            }else{
                cell.btn1Pay.isSelected = true
                cell.btnSelection.isSelected = false
            }
            cell.completionPayment = { sucess in
                print("one pay payment:- \(sucess)")
                self.boolPaymentGetway = true
                self.tblPayment.reloadData()
                self.ispayMentGateway = sucess
//                if ((cell.btnSelection.currentImage?.isEqual(UIImage(named: "RectangleCheckBoxUnSelected"))) != nil) {
//                    cell.btnSelection.setImage(UIImage(named: "RectangleCheckBoxSelected"), for: .normal)
//                    cell.btn1Pay.setImage(UIImage(named: "RectangleCheckBoxUnSelected"), for: .normal)
//                }
            }
            
            cell.OnePayPayment = { success in
                print("one pay payment:- \(success)")
                self.boolPaymentGetway = false
                self.tblPayment.reloadData()
               
                self.ispayMentGateway = true
//                if ((cell.btn1Pay.currentImage?.isEqual(UIImage(named: "RectangleCheckBoxUnSelected"))) != nil) {
//                    cell.btn1Pay.setImage(UIImage(named: "RectangleCheckBoxSelected"), for: .normal)
//                    cell.btnSelection.setImage(UIImage(named: "RectangleCheckBoxUnSelected"), for: .normal)
//                }
            }
            DispatchQueue.main.async {
                self.constTblViewHeight.constant = tableView.contentSize.height
                self.tblPayment.layoutIfNeeded()
            
            }
            
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier:"PaymentAmountDetailCell") as? PaymentAmountDetailCell else  { return UITableViewCell() }
            cell.lblAdultCount.text = btnNoOfPassengers.title(for: .normal)
            var fare = 0.0
            let num1 = Double(cell.lblAdultCount.text ?? "0") ?? 0
            
            
            if fromType == .NearByStop {
                fare = Double(objFareCal?.baseFare ?? 0)
                cell.lblRouteNo.text = objStation?.strMetroLineNo ?? ""
                cell.lblFromStation.text = objStation?.strSourceName ?? ""
                cell.lblToStation.text =  objToStation?.displaystationname
                cell.lblAmountinRS.text = "Rs.\(num1 * fare)"
                cell.lblAmountinRS_topSide.text = "Rs.\(fare)"
            }
            else if fromType == .QRCodePenalty {
                fare = Double(objFareCal?.baseFare ?? 0)
                cell.lblRouteNo.text = objTicket?.routeNo ?? ""
                cell.lblFromStation.text = objTicket?.to_Station
                cell.lblToStation.text = objPenaltyData?.strStationName
                cell.lblAmountinRS.text = "Rs.\(sumFinalRsDisplay ?? 0)"
                cell.lblAmountinRS_topSide.text = "Rs.\(sumFinalRsDisplay ?? 0)"
            }
            else {
                fare = objJourney?.journeyPlannerStationDetail?.fare ?? 0.0
                cell.lblRouteNo.text = objJourney?.transitPaths?.first?.routeno
                cell.lblFromStation.text = objJourney?.journeyPlannerStationDetail?.strFromStationName
                cell.lblToStation.text = objJourney?.journeyPlannerStationDetail?.strToStationName
                
                let downfare_value = Int(downfare)
                let cal = downfare_value + Int(fare)
                print(cal)
                cell.lblAmountinRS.text = "Rs.\(num1 * Double(cal))"
                cell.lblAmountinRS_topSide.text = "Rs.\(fare)"
                
                if isfromUpwoedNewJourneyVcPass{
                    let downfare_value = Int(downfare)
                    let cal = downfare_value + Int(fare)
                    print(cal)
                    cell.lblAmountinRS_topSide.text = "Rs.\(cal)"
                    
                    self.btnTotalAmount .setTitle("Rs.\(cal * Int(num1))", for: .normal)
                   // cell.lblAmountinRS.text = "Rs.\(num1 * Double(cal))"
                                                   
                }
            }
            cell.lblBaseRate.text = "\(fare)"
           
            
            
            
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


