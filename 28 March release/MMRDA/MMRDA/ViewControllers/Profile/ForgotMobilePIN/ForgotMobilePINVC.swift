//
//  ForgotMobilePINVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 17/08/22.
//

import UIKit
import ACFloatingTextfield_Swift
import CountryPickerView

class ForgotMobilePINVC: UIViewController {

    @IBOutlet weak var textMobileEmail: ACFloatingTextfield!
    var objsetPasswordViewModel = setPasswordViewModel()
    @IBOutlet weak var countryView: CountryPickerView!
    @IBOutlet weak var lblerror: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.callBarButtonForHome(leftBarLabelName: "", isHomeScreen:false,isDisplaySOS:false)
        self.initialize()
       
        
        // Do any additional setup after loading the view.
    }
    
    func initialize(){
        self.setRightBackButton()
        lblerror.textColor = UIColor(hexString: "#FF0000")
        self.navigationItem.leftBarButtonItems = nil
        textMobileEmail.delegate = self
        objsetPasswordViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                  
                    self?.lblerror.text = message
                }
            }
        }
        //objsetPasswordViewModel.dict = param
        objsetPasswordViewModel.bindViewModelToForgotController =  { param,message  in
            if message.count > 0 {
                
                self.showAlertViewWithMessageAndActionHandler(message, message: "") {
                    let vc = UIStoryboard.OTPVerifyVC()
                    vc?.param = param
                    vc?.isVerifyOTPFor = OTPVerify.ForgotMPIN
                    self.navigationController?.pushViewController(vc!, animated:true)
                }
            }
            
        }
        countryView.dataSource = self
        countryView.setCountryByCode("IN")
        countryView.showCountryNameInView = false
        countryView.showCountryCodeInView = false
        countryView.isHidden = true
    }
    
     @IBAction func actionMoveGetOTp(_ sender: Any) {
         
         objsetPasswordViewModel.strMobilOReEmail = textMobileEmail.text ?? ""
         objsetPasswordViewModel.isMpin = true
         objsetPasswordViewModel.forgotSendOTP()
         
       
     }
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
extension ForgotMobilePINVC:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let maxLength = 10
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        if (newString as String).isNumeric {
            countryView.isHidden = false
            textField.placeholder = "lbl_mobile_number".localized()
            return newString.length <= maxLength
        }else {
            textField.placeholder = "tv_enter_email_mobile".localized()
            countryView.isHidden = true
        }
        return true
    }
    
}
extension ForgotMobilePINVC: CountryPickerViewDataSource {
    func preferredCountries(in countryPickerView: CountryPickerView) -> [Country] {
        return ["IN"].compactMap { countryPickerView.getCountryByCode($0) }
    }
    
    func sectionTitleForPreferredCountries(in countryPickerView: CountryPickerView) -> String? {
        return "Select a Country"
    }
    
    func showOnlyPreferredSection(in countryPickerView: CountryPickerView) -> Bool {
        return true
    }
    
    func navigationTitle(in countryPickerView: CountryPickerView) -> String? {
        return ""
    }
        
    func searchBarPosition(in countryPickerView: CountryPickerView) -> SearchBarPosition {
        return .tableViewHeader
    }
    
    func showPhoneCodeInList(in countryPickerView: CountryPickerView) -> Bool {
        return true
    }
    
    func showCountryCodeInList(in countryPickerView: CountryPickerView) -> Bool {
       return false
    }
}
