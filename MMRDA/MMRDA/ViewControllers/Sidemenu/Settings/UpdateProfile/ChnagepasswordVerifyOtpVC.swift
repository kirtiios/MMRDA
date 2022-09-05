//
//  ChnagepasswordVerifyOtpVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 05/09/22.
//

import UIKit

class ChnagepasswordVerifyOtpVC: UIViewController {

    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var lblResendOTP: UILabel!
    @IBOutlet weak var lblTitleMobile: UILabel!
    
    @IBOutlet weak var otpView: OTPView!
    
    
    var strOTP:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 6
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.otpView.initializeOTPUI()
        self.otpView.delegate = self
        self.setcolor(color:Colors.lighGrayColor.value)
        lblTitleMobile.text = "\("txtOTPsentDesciption".LocalizedString) \(Helper.shared.objloginData?.strMobileNo ?? "")/\(Helper.shared.objloginData?.strEmailID ?? "")"
        
    }
    

    
    func setcolor(color:UIColor){
        lblResendOTP.attributedText = "tv_don_t_receive_otp".LocalizedString.getAttributedStrijng(titleString:"tv_don_t_receive_otp".LocalizedString, subString: "resend_code_instruction".LocalizedString, subStringColor:color)
    }
    
    @IBAction func actionVerify(_ sender: Any) {
         self.dismiss(animated:true)
     }
     
    
    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated:true)
    }
    
}
extension ChnagepasswordVerifyOtpVC:OTPViewDelegate {
    func shouldBecomeFirstResponderForOTP(otpFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otpString: String) {
        strOTP = otpString
    }
    
    func hasEnteredAllOTP(hasEntered: Bool) -> Bool {
        return true
    }
}
