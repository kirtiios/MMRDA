//
//  SingupVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 17/08/22.
//

import UIKit

import ACFloatingTextfield_Swift
import CountryPickerView

class SignupVC: UIViewController {

    @IBOutlet weak var lblLinkResgiter: UILabel!
    @IBOutlet weak var lblLInkTermsCondition: UILabel!
    @IBOutlet weak var btnTickMark: UIButton!
    @IBOutlet weak var textFullName: ACFloatingTextfield!
    @IBOutlet weak var textMobileNumber: ACFloatingTextfield!
    @IBOutlet weak var textEmail: ACFloatingTextfield!
    @IBOutlet weak var lblerror: UILabel!
    var objSignUPViewModel = SignupViewModel()
    @IBOutlet weak var countryView: CountryPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        LocationManager.sharedInstance.getCurrentLocation { success, location in
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = true
    }
    @IBAction func actionGetOTP(_ sender: UIButton) {
        
        
        objSignUPViewModel.strEmail = textEmail.text ?? ""
        objSignUPViewModel.strMobile = textMobileNumber.text ?? ""
        objSignUPViewModel.strFullName = textFullName.text ?? ""
        objSignUPViewModel.isAcceptCondition = btnTickMark.isSelected
        objSignUPViewModel.submitSignUP()
        objSignUPViewModel.bindViewModelToController =  { dict,message  in
            
            if message.count > 0 {
                self.showAlertViewWithMessageAndActionHandler(message, message: "") {
                    let vc = UIStoryboard.OTPVerifyVC()
                    vc?.isVerifyOTPFor = OTPVerify.Register
                    vc?.param = dict
                    self.navigationController?.pushViewController(vc!, animated: true)
                }
                
            }
           
        }
        
       
        
        
    }
    @IBAction func actionTickMark(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
}


extension SignupVC {
    private func initialize() {
        self.callBarButtonForHome(leftBarLabelName: "", isHomeScreen:false,isDisplaySOS:false)
        lblerror.textColor = UIColor(hexString: "#FF0000")
        
        
        
        self.setRightBackButton()
        self.navigationItem.leftBarButtonItems = nil
        lblLinkResgiter.attributedText = "alreadyhaveanaccount".LocalizedString.getAttributedStrijng(titleString:"alreadyhaveanaccount".LocalizedString, subString: "login".LocalizedString, subStringColor:Colors.APP_Theme_color.value)
        
        lblLinkResgiter.isUserInteractionEnabled = true
        lblLinkResgiter.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
        
        
        
        
        let localizedText = "tv_terms_conditions".LocalizedString
        let attributedString = NSMutableAttributedString(string: localizedText)

        // Apply underline to the words "Terms & Condition"
        let range = (localizedText as NSString).range(of: "termsconditions".LocalizedString)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        attributedString.addAttribute(.underlineColor, value: Colors.APP_Theme_color.value, range: range)

        // Set the attributed text to the label
        lblLInkTermsCondition.attributedText = attributedString
        lblLInkTermsCondition.numberOfLines = 1 // Set number of lines to 1
        lblLInkTermsCondition.textAlignment = .left
        
        
        
        
        lblLInkTermsCondition.isUserInteractionEnabled = true
        lblLInkTermsCondition.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(linkAgreement(gesture:))))
    
        textMobileNumber.delegate = self
        countryView.dataSource = self
        countryView.setCountryByCode("IN")
        countryView.showCountryNameInView = false
        countryView.showCountryCodeInView = false
        
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = UIColor.white
//        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
//        appearance.shadowImage = UIImage()
//        appearance.shadowColor = UIColor.clear
//        UINavigationBar.appearance().standardAppearance = appearance
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
//
//        if #available(iOS 15.0, *) {
//            UITableView.appearance().sectionHeaderTopPadding = 0
//        }
        
        
//        textFullName.text = "645556"
//        textEmail.text = "mobile.amnex@gmil.com"
//        textMobileNumber.text = "7486093344"
        
        objSignUPViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.lblerror.text = message
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
extension SignupVC:UITextFieldDelegate {
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
extension SignupVC: CountryPickerViewDataSource {
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
