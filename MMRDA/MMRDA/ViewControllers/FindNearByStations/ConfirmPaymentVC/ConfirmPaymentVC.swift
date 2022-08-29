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
    @IBOutlet weak var popupView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 6
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        // Do any additional setup after loading the view.
    }
    

    @IBAction func actionViewTicket(_ sender: Any) {
        
    }
    
    @IBAction func actionCancel(_ sender: Any) {
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
