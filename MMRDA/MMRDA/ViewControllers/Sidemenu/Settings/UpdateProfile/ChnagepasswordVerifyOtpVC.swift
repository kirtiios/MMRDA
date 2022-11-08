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
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var otpView: OTPView!
    @IBOutlet weak var lblerror: UILabel!
    var param:[String:Any]?
    var objsetPasswordViewModel = setPasswordViewModel()
    var strOTP:String?
    var count:Double = 0  // 60sec if you want
    var resendTimer = Timer()
    var strMobileorEmail = String()
    
    var completionBlock:(() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 6
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        lblerror.textColor = UIColor(hexString: "#FF0000")
        self.otpView.initializeOTPUI()
        self.otpView.delegate = self
        self.setcolor(color:Colors.lighGrayColor.value)
        lblResendOTP.isUserInteractionEnabled = true
        lblResendOTP.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
        lblTitleMobile.text = "\("txtOTPsentDesciption".LocalizedString)" + strMobileorEmail
        objsetPasswordViewModel.dict = param ?? [String:Any]()
        objsetPasswordViewModel.bindViewModelToController = { sucess in
            
            if sucess {
                

                var dict = [String:Any]()
                dict["strMobileNo"] = self.param?["strPhoneNo"]
                dict["intUserID"] = Helper.shared.objloginData?.intUserID
                dict["strEmailID"] = self.param?["strEmailID"]
                
                ApiRequest.shared.requestPostMethod(strurl: apiName.UpdateLoginDetail, params: dict, showProgress: true) { sucess, data, error in
                    if sucess {
                        do {
                            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                                
                                if let issuccess =  json["issuccess"] as? Bool ,issuccess {
                                    
                                    self.showAlertViewWithMessageAndActionHandler("", message: "update_login_details".LocalizedString) {
                                        self.dismiss(animated: true) {
                                            self.completionBlock?()
                                        }
                                    }
                                  
                                  
    
                                }else {
                                    
                                    self.objsetPasswordViewModel.inputErrorMessage.value = json["message"] as? String
                                    
                                }
                            }
                            
                        } catch {
                            print(error)
                            DispatchQueue.main.async {
                               
                            }
                        }
                        
                    }
                    
                    
                }
               // verify Sucess
                
              
            }else {
                self.startTimer()
            }
            
        }
        objsetPasswordViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                   // self?.showAlertViewWithMessage("", message:message)
                    self?.lblerror.text = message
                }
            }
        }
        self.startTimer()
        
    }
    

    
    func setcolor(color:UIColor){
        lblResendOTP.attributedText = "tv_don_t_receive_otp".LocalizedString.getAttributedStrijng(titleString:"tv_don_t_receive_otp".LocalizedString, subString: "resend_code_instruction".LocalizedString, subStringColor:color)
    }
    @objc func tapLabel(gesture: UITapGestureRecognizer) {
        let termsRange = (lblResendOTP.text! as NSString).range(of: "resend_code_instruction".LocalizedString)
        if gesture.didTapAttributedTextInLabel(label: lblResendOTP, inRange: termsRange) {
            
            if resendTimer.isValid == false {
                self.otpView.clearOTP()
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
    
    @IBAction func actionVerify(_ sender: Any) {
        if strOTP?.count == 4 {
            objsetPasswordViewModel.strOtpNumber = strOTP ?? ""
            objsetPasswordViewModel.verifyLoginChangeOTP()
        }
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
