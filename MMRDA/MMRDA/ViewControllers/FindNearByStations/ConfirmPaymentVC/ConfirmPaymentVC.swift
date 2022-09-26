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
    var objPayment:PaymentModel?
    var paymentStatus = Bool()
    @IBOutlet weak var popupView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 6
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        lblToStation.text = objPayment?.to_Station
        lblFromStation.text = objPayment?.from_Station
        lblAmount.text = "Rs.\(objPayment?.totaL_FARE ?? 0)"
        lblConfirmDay.text = objPayment?.strPaymentStatus
        
        if paymentStatus == false {
            lblConfirmDay.textColor = UIColor.red
        }
        
        

        // Do any additional setup after loading the view.
    }
    

    @IBAction func actionViewTicket(_ sender: Any) {
        self.dismiss(animated:true) {
            let vc = UIStoryboard.ViewTicketVC()
            if let nav = APPDELEGATE.topViewController?.children.last as? UINavigationController {
                vc.objPayment = self.objPayment
                nav.pushViewController(vc, animated:true)
            }
        }
    }
    
    @IBAction func actionCancel(_ sender: Any) {
        self.dismiss(animated:true)
    }


}
