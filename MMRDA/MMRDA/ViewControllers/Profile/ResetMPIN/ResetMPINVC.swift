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
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        self.navigationController?.navigationBar.isHidden = false
        self.callBarButtonForHome(leftBarLabelName: "", isHomeScreen:false,isDisplaySOS:false)
        objsetPasswordViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
        objsetPasswordViewModel.dict = param
        objsetPasswordViewModel.bindViewModelToController =  {sucess  in
            let firstPresented = UIStoryboard.SuccessRegisterVC()
            firstPresented?.isVerifyOTPFor = .ForgotMPIN
            self.navigationController?.pushViewController(firstPresented!, animated: true)
        }
        textPIN.delegate = self
        textConfirmPin.delegate = self
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
