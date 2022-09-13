//
//  OTPVerify.swift
//  MMRDA
//
//  Created by Sandip Patel on 17/08/22.
//

import Foundation

//
//  LoginVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 17/08/22.
//

import UIKit

class OTPVerifyVC: UIViewController {
    
    @IBOutlet weak var lblResendOTP: UILabel!
    @IBOutlet weak var lblMobileOREmail: UILabel!
    @IBOutlet weak var lblTimer: UILabel!
    
    var strOTP = String()
    var isVerifyOTPFor:OTPVerify?
    var param:[String:Any]?
    var count:Double = 0  // 60sec if you want
    var resendTimer = Timer()
    @IBOutlet weak var txtOTPView: OTPView!
    var objsetPasswordViewModel = setPasswordViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtOTPView.initializeOTPUI()
        self.txtOTPView.delegate = self
        self.navigationController?.navigationBar.isHidden = false
        self.callBarButtonForHome(leftBarLabelName: "", isHomeScreen:false,isDisplaySOS:false)
      
        self.setcolor(color:Colors.lighGrayColor.value)
        lblResendOTP.isUserInteractionEnabled = true
        lblResendOTP.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
        
        if isVerifyOTPFor?.rawValue == OTPVerify.Register.rawValue {
            let str = (param?["strEmailID"] as? String  ?? "") + "\n" + (param?["strPhoneNo"] as? String  ?? "")
            lblMobileOREmail.text = str
        }
        if isVerifyOTPFor?.rawValue == OTPVerify.ForgotPassword.rawValue || isVerifyOTPFor?.rawValue == OTPVerify.ForgotMPIN.rawValue{
            
            if let strMobile = param?["strPhoneNo"] as? String  , strMobile.isEmpty == false {
                lblMobileOREmail.text = strMobile
            }else {
                lblMobileOREmail.text = param?["strEmailID"] as? String  ?? ""
            }
          
        }
        self.startTimer()
        objsetPasswordViewModel.dict = param ?? [String:Any]()
        objsetPasswordViewModel.bindViewModelToController = { sucess in
            
            if sucess {
                
                
                if self.isVerifyOTPFor?.rawValue == OTPVerify.ForgotMPIN.rawValue {
                    let vc = UIStoryboard.ResetMPINVC()
                    vc?.param = self.param ?? [String:Any]()
                    self.navigationController?.pushViewController(vc!, animated:true)
                }else if self.isVerifyOTPFor?.rawValue == OTPVerify.ForgotPassword.rawValue {
                    let vc = UIStoryboard.ResetPasswordVC()
                    vc?.params = self.param ?? [String:Any]()
                    self.navigationController?.pushViewController(vc!, animated:true)
                }else if self.isVerifyOTPFor?.rawValue == OTPVerify.Register.rawValue {
                    let vc = UIStoryboard.setPasswordVC()
                    vc?.param = self.param ?? [String:Any]()
                    self.navigationController?.pushViewController(vc!, animated:true)
                    
                }
                
              
            }else {
                self.startTimer()
            }
            
        }
        objsetPasswordViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
        
        
        
    }
    func setcolor(color:UIColor){
        lblResendOTP.attributedText = "tv_don_t_receive_otp".LocalizedString.getAttributedStrijng(titleString:"tv_don_t_receive_otp".LocalizedString, subString: "resend_code_instruction".LocalizedString, subStringColor:color)
    }
    @IBAction func actionVerifyOTp(_ sender: Any) {
        
        if isVerifyOTPFor?.rawValue == OTPVerify.ForgotPassword.rawValue || isVerifyOTPFor?.rawValue == OTPVerify.ForgotMPIN.rawValue {
            if strOTP.count == 4 {
                objsetPasswordViewModel.strOtpNumber = strOTP
                objsetPasswordViewModel.verifyOTP()
            }
        }else if isVerifyOTPFor?.rawValue == OTPVerify.Register.rawValue {
            
            if strOTP.count == 4 {
                objsetPasswordViewModel.strOtpNumber = strOTP
                objsetPasswordViewModel.verifyOTP()
            }
            
        }
        
    }
    @objc func tapLabel(gesture: UITapGestureRecognizer) {
        let termsRange = (lblResendOTP.text! as NSString).range(of: "resend_code_instruction".LocalizedString)
       
        
        if gesture.didTapAttributedTextInLabel(label: lblResendOTP, inRange: termsRange) {
            
            if resendTimer.isValid == false {
                txtOTPView.clearOTP()
                objsetPasswordViewModel.resendOTP()
            }
            
        }
        
        

    }
    func startTimer(){
        count = 300
        resendTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    @objc func update() {
        if(count > 0) {
            count = count - 1
            print(count)
            lblTimer.text = count.asString(style: .positional)
            self.setcolor(color:Colors.lighGrayColor.value)
        }
        else {
            resendTimer.invalidate()
            lblTimer.text = "00:00"
            self.setcolor(color:Colors.APP_Theme_color.value)
           
          
            // if you want to reset the time make count = 60 and resendTime.fire()
        }
    }
    
}

extension OTPVerifyVC:OTPViewDelegate {
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
extension Double {
  func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute, .second, .nanosecond]
    formatter.unitsStyle = style
    return formatter.string(from: self) ?? ""
  }
}
