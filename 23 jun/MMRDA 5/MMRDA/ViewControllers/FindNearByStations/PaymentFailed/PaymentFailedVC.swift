//
//  PaymentFailedVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 29/08/22.
//

import UIKit

class PaymentFailedVC: UIViewController {

    @IBOutlet weak var lblTitlePaymentFailed: UILabel!
    @IBOutlet weak var lblTitleDescription: UILabel!
    @IBOutlet weak var btnclose: UIButton!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var lblTransactionID: UILabel!
    @IBOutlet weak var lblTransactionDateandTime: UILabel!
    @IBOutlet weak var lblTransactionReferenceNo:UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 6
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated:true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
