//
//  ConfirmPaymentVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 29/08/22.
//

import UIKit

class ConfirmPaymentVC: UIViewController {

    @IBOutlet weak var lblAmount: UILabel!
    
    @IBOutlet weak var lblToStation: UILabel!
    @IBOutlet weak var lblFromStation: UILabel!
    @IBOutlet weak var lblConfirmDay: UILabel!
    @IBOutlet weak var lblPenaltiyText: UILabel!
    var objPayment:PaymentModel?
    var paymentStatus = Bool()
    var strPaymentStatus = String()
    var completionBlockCancel:((Bool)->Void)?
    var completionBlockViewTicket:((Bool)->Void)?
    var arrHistory = [myTicketList]()
    var fromType:frompage = .NearByStop
    @IBOutlet weak var popupView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 6
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        lblToStation.text = objPayment?.to_Station
        lblFromStation.text = objPayment?.from_Station
        lblAmount.text = "Rs.\(objPayment?.totaL_FARE ?? 0)"
        lblConfirmDay.text = strPaymentStatus
        
        if arrHistory.count > 0 {
            lblConfirmDay.textColor = UIColor(hexString: arrHistory.first?.strColorCode ?? "")
        }
       
//        if paymentStatus == false {
//            lblConfirmDay.textColor = UIColor.red
//        }
        
        
        if self.fromType == .QRCodePenalty {
            self.lblPenaltiyText.isHidden = false
            self.lblPenaltiyText.text = "strPenaltyReason".localized()
            if arrHistory.count > 0 {
                self.lblPenaltiyText.text = "strPenaltyReason".localized() + (self.arrHistory.first?.strPenaltyReason ?? "")
            }
        }
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func actionViewTicket(_ sender: Any) {
        self.dismiss(animated:true) {
            self.completionBlockViewTicket?(true)
//            let vc = UIStoryboard.ViewTicketVC()
//          //  if let nav = APPDELEGATE.topViewController?.children.last as? UINavigationController {
//                vc.objPayment = self.objPayment
//                vc.arrHistory = self.arrHistory
//            self.navigationController?.pushViewController(vc, animated:false)
           // }
        }
    }
    
    @IBAction func actionCancel(_ sender: Any) {
        self.dismiss(animated: true) {
            self.completionBlockCancel?(true)
        }
    }


}
