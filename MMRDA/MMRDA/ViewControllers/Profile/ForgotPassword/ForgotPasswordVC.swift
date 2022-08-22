//
//  ForgotPasswordVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 18/08/22.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.callBarButtonForHome(leftBarLabelName: "", isHomeScreen:false,isDisplaySOS:false)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

    @IBAction func actionVerifyOTP(_ sender: Any) {
        let vc = UIStoryboard.OTPVerifyVC()
        vc?.isVerifyOTPFor = OTPVerify.ForgotPassword
        self.navigationController?.pushViewController(vc!, animated:true)
    }
}
