//
//  SetupMPINVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 18/08/22.
//

import UIKit

class SetupMPINVC: UIViewController {

    @IBOutlet weak var popupview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupview.layer.cornerRadius = 6
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func actionSubmitMPIN(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
     @IBAction func actionCancel(_ sender: Any) {
         self.dismiss(animated:true)
     }
    
    
   

}
