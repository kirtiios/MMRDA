//
//  SingupVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 17/08/22.
//

import UIKit
import ACFloatingTextfield_Swift

class SingupVC: UIViewController {

    @IBOutlet weak var lblLinkResgiter: UILabel!
    @IBOutlet weak var lblLInkTermsCondition: UILabel!
    @IBOutlet weak var btnTickMark: UIButton!
    
    @IBOutlet weak var textFullName: ACFloatingTextfield!
    @IBOutlet weak var textMobileNumber: ACFloatingTextfield!
    @IBOutlet weak var textEmail: ACFloatingTextfield!
    
    var objSignUPViewModel = SignupViewModel()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        LocationManager.sharedInstance.getCurrentLocation { success, location in
        }
        
    }
    @IBAction func actionGetOTP(_ sender: UIButton) {
        
        
        objSignUPViewModel.strEmail = textEmail.text ?? ""
        objSignUPViewModel.strMobile = textMobileNumber.text ?? ""
        objSignUPViewModel.strFullName = textFullName.text ?? ""
        objSignUPViewModel.isAcceptCondition = btnTickMark.isSelected
        
        objSignUPViewModel.submitSignUP()
        objSignUPViewModel.bindViewModelToController =  { dict  in 
            
            let vc = UIStoryboard.OTPVerifyVC()
            vc?.isVerifyOTPFor = OTPVerify.Register
            vc?.param = dict
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
       
        
        
    }
    @IBAction func actionTickMark(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
}


extension SingupVC {
    private func initialize() {
        self.navigationController?.navigationBar.isHidden = false
        self.callBarButtonForHome(leftBarLabelName: "", isHomeScreen:false,isDisplaySOS:false)
        lblLinkResgiter.attributedText = "alreadyhaveanaccount".LocalizedString.getAttributedStrijng(titleString:"alreadyhaveanaccount".LocalizedString, subString: "login".LocalizedString, subStringColor:Colors.APP_Theme_color.value)
        
        lblLinkResgiter.isUserInteractionEnabled = true
        lblLinkResgiter.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
        
        lblLInkTermsCondition.isUserInteractionEnabled = true
        lblLInkTermsCondition.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(linkAgreement(gesture:))))
    
        textMobileNumber.delegate = self
        
//        textFullName.text = "645556"
//        textEmail.text = "mobile.amnex@gmil.com"
//        textMobileNumber.text = "7486093344"
        
        objSignUPViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
    }
    
    @objc func tapLabel(gesture: UITapGestureRecognizer) {
        let termsRange = (lblLinkResgiter.text! as NSString).range(of: "login".LocalizedString)
       
        
        if gesture.didTapAttributedTextInLabel(label: lblLinkResgiter, inRange: termsRange) {
            self.navigationController?.popViewController(animated: true)
            
        }
        
    
    }
    @objc func linkAgreement(gesture: UITapGestureRecognizer) {
        let objwebview = WebviewVC(nibName: "WebviewVC", bundle: nil)
        objwebview.titleString = SettingmenuItem.Terms.rawValue.localized()
        objwebview.url = URL(string:"https://www.mmmocl.co.in/terms-conditions-for-qr-ticket.html")
        self.navigationController?.pushViewController(objwebview, animated: true)
    
    }
}
extension SingupVC:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == textMobileNumber {
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
         
        }else {
            return true
        }
    }
}
