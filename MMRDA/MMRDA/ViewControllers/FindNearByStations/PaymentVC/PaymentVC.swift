//
//  PaymentVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 26/08/22.
//

import UIKit
import DropDown

class PaymentVC: BaseVC {
    
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
    
    var objViewModel = PaymentViewModel()
    let dropDown = DropDown()
    var objStation:StationListModel?
    var arrStationList = [FareStationListModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"payment".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        btnFromStation.setTitle(objStation?.strSourceName, for: .normal)
        btnToStation.setTitle(objStation?.strDestinationName, for: .normal)
      //  objViewModel.delegate = self
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
        btnViewFare.isSelected = false
        var param = [String:Any]()
        param["intTripID"] = objStation?.intTripID
        param["intStationID"] = objStation?.intSourceID
        param["strStationName"] = ""
        objViewModel.getNearbyStation(param:param) { arrList in
            self.arrStationList = arrList ?? [FareStationListModel]()
        }
        self.getFareCalculatore()
        
        // Do any additional setup after loading the view.
    }
    func getFareCalculatore(){
        objViewModel.getFareCalculator(fromStationID: objStation?.arrRouteData?.first?.intSourceID ?? 0, toStationID: objStation?.arrRouteData?.first?.intDestinationID ?? 0) { faremodel in
            
            self.btnDistance .setTitle("\(faremodel?.discountedFare ?? 0)", for: .normal)
            self.btnTotalAmount .setTitle("\(faremodel?.baseFare ?? 0)", for: .normal)
        }
    }
    
    
    
    @IBAction func actionOpenFromStationList(_ sender: Any) {
        
    }
    
    
    @IBAction func actionOpenToStationList(_ sender: UIButton) {
        
        let arrayName = arrStationList.compactMap({
            return $0.sationname
        })
        dropDown.dataSource  = arrayName
        dropDown.anchorView = sender
        dropDown.direction = .bottom
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
       
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self?.btnToStation.setTitle(item, for:.normal)
            self?.objStation?.strDestinationName = item
            self?.objStation?.arrRouteData?[0].intDestinationID  =  self?.arrStationList[index].stationid
            self?.getFareCalculatore()
            self?.tblview .reloadData()
        }
        dropDown.show()

        
    }
    
    @IBAction func actionOpenNoOfpassengersList(_ sender: UIButton) {
       
        dropDown.dataSource  = ["1","2","3","4","5","6"]
        dropDown.anchorView = sender
        dropDown.direction = .bottom
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self?.btnNoOfPassengers.setTitle(item, for:.normal)
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
        let root = UIWindow.key?.rootViewController!
        if let firstPresented = UIStoryboard.PaymentFailedVC() {
            firstPresented.modalTransitionStyle = .crossDissolve
            firstPresented.modalPresentationStyle = .overCurrentContext
            root?.present(firstPresented, animated: false, completion: nil)
        }
    }
    
    @IBAction func actionPayNow(_ sender: Any) {
        
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
        
        let numberQty = self.btnNoOfPassengers.title(for:.normal) ?? "0"
        let basicRate = btnTotalAmount.title(for: .normal)?.digits ?? "0"
        
        
        let num1 = Int(numberQty) ?? 0
        let num2 = Int(basicRate) ?? 0
        
      
        
        let rewardAmount = 0
        let discount = 0
        
        let total = ((num1 * num2) - discount)
        
        var param = [String:Any]()
        param["decKM"] = 0
        param["decTotalKM"] = 0
        param["fltTotalDistanceTravelled"] = self.objStation?.arrRouteData?.first?.strKM
        param["intBasicFare"] = basicRate
        param["intDisscount"] = 0
        param["intFromStationID"] = self.objStation?.arrRouteData?.first?.intSourceID
        param["intPaidAmount"] = total - rewardAmount
        param["intPaybleAmount"] = total - discount
        param["intPlatformID"] = 3
        param["intRewardAmount"] = rewardAmount //static now
        param["intRouteID"] = self.objStation?.arrRouteData?.first?.intRouteID
        param["intServiceTypeID"] = 0
        param["intTicketAmount"] = basicRate
        param["intToStationID"] = self.objStation?.arrRouteData?.first?.intDestinationID
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
                                          "intFromStationID":self.objStation?.arrRouteData?.first?.intSourceID ?? 0,
                                          "intRouteID":self.objStation?.arrRouteData?.first?.intRouteID ?? 0,
                                          "intServiceTypeID":0,
                                          "intToStationID":self.objStation?.arrRouteData?.first?.intDestinationID ?? 0,
                                          "intTotalFare":total,
                                          "intTotalQty":numberQty ,
                                          "intTransportModeID":0]]
        
        objViewModel.insertTicketHistory(param: param) { paymentModel in
            
            if let objmodel = paymentModel {
                let obj = PaymentWebViewVC(nibName: "PaymentWebViewVC", bundle: nil)
                obj.objPayment = objmodel
                obj.completionBlock = { sucess in
                    let root = UIWindow.key?.rootViewController!
                    if let firstPresented = UIStoryboard.ConfirmPaymentVC() {
                        firstPresented.paymentStatus = sucess
                        firstPresented.objPayment = objmodel
                        firstPresented.modalTransitionStyle = .crossDissolve
                        firstPresented.modalPresentationStyle = .overCurrentContext
                        root?.present(firstPresented, animated: false, completion: nil)
                    }
                }
                self.navigationController?.pushViewController(obj, animated: true)
            }
            
        }
        
       
        
    
        
        

        
        
        
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
            if indexPath.row == 0 {
                cell.lblPaymentTitle.text = "tv_payment_gateway".localized()
                cell.lblPaymentDetail.text = "tv_credit_card_debit_card_net_banking_e_wallet_net_banking".localized()
                cell.btnSelection.isSelected = true
            }
        
            DispatchQueue.main.async {
                self.constTblViewHeight.constant = tableView.contentSize.height
                self.tblPayment.layoutIfNeeded()
            }
            
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier:"PaymentAmountDetailCell") as? PaymentAmountDetailCell else  { return UITableViewCell() }
            
            cell.lblRouteNo.text = objStation?.strMetroLineNo ?? ""
            cell.lblFromStation.text = objStation?.strSourceName ?? ""
            cell.lblToStation.text = objStation?.strDestinationName ?? ""
            cell.lblAdultCount.text = btnNoOfPassengers.title(for: .normal)
            cell.lblBaseRate.text = btnTotalAmount.title(for: .normal)?.digits
            
            let num1 = Int(cell.lblAdultCount.text ?? "0") ?? 0
            let num2 = Int(cell.lblBaseRate.text ?? "0") ?? 0
            cell.lblAmountinRS.text = "Rs.\(num1 * num2)"
            cell.lblAmountinRS_topSide.text = "Rs.\(num1 * num2)"
            
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
