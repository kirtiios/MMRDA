//
//  ForgotMobilePINVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 17/08/22.
//

import UIKit

class ForgotMobilePINVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.callBarButtonForHome(leftBarLabelName: "", isHomeScreen:false,isDisplaySOS:false)
        // Do any additional setup after loading the view.
    }
    

    
     @IBAction func actionMoveGetOTp(_ sender: Any) {
         let vc = UIStoryboard.OTPVerifyVC()
         vc?.isVerifyOTPFor = OTPVerify.ForgotMPIN
         self.navigationController?.pushViewController(vc!, animated: true)
     }
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
