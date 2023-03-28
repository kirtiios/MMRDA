//
//  ResetMPINVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 18/08/22.
//

import UIKit
import ACFloatingTextfield_Swift

class ResetMPINVC: UIViewController {

    @IBOutlet weak var textPIN: ACFloatingTextfield!
    @IBOutlet weak var textConfirmPin: ACFloatingTextfield!
    var objsetPasswordViewModel = setPasswordViewModel()
    var param = [String:Any]()
    @IBOutlet weak var lblerror: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        lblerror.textColor = UIColor(hexString: "#FF0000")
        self.navigationController?.navigationBar.isHidden = false
        let barButton = UIBarButtonItem(image: UIImage(named:"back"), style:.plain, target: self, action: #selector(self.gotoBackForgotMPinScreen))
        barButton.tintColor = UIColor.black
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = barButton
        objsetPasswordViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.lblerror.text = message
                }
            }
        }
        objsetPasswordViewModel.dict = param
        objsetPasswordViewModel.bindViewModelToController =  {sucess,message  in
            let firstPresented = UIStoryboard.SuccessRegisterVC()
            firstPresented?.isVerifyOTPFor = .ForgotMPIN
            self.navigationController?.pushViewController(firstPresented!, animated: true)
        }
        textPIN.delegate = self
        textConfirmPin.delegate = self
    }
    @objc func gotoBackForgotMPinScreen(){
        self.navigationController?.popToViewController(ofClass:ForgotMobilePINVC.self)
    }
    

    @IBAction func actionResetMobilePin(_ sender: Any) {
        
        objsetPasswordViewModel.strPassword = textPIN.text ?? ""
        objsetPasswordViewModel.strConfirm = textConfirmPin.text ?? ""
        objsetPasswordViewModel.resetMPIN()
        
       
            
    }
   

}
extension ResetMPINVC:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        let maxLength = 4
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        
        return newString.count <= maxLength
    }
}
