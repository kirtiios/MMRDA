//
//  SetupMPINVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 18/08/22.
//

import UIKit
import ACFloatingTextfield_Swift

class SetupMPINVC: UIViewController {

    @IBOutlet weak var popupview: UIView!
    @IBOutlet weak var textPIN: ACFloatingTextfield!
    @IBOutlet weak var textConfirmPin: ACFloatingTextfield!
    var objsetPasswordViewModel = setPasswordViewModel()
    var param = [String:Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        popupview.layer.cornerRadius = 6
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        objsetPasswordViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
        objsetPasswordViewModel.dict = param
        objsetPasswordViewModel.bindViewModelToController =  {sucess  in
            DispatchQueue.main.async {
                self.dismiss(animated:true)
            }
           
        }
        
        textPIN.delegate = self
        textPIN.keyboardType = .numberPad
        textConfirmPin.delegate = self
        textConfirmPin.keyboardType = .numberPad
    }
    

    @IBAction func actionSubmitMPIN(_ sender: Any) {
        
        
        objsetPasswordViewModel.strPassword = textPIN.text ?? ""
        objsetPasswordViewModel.strConfirm = textConfirmPin.text ?? ""
        
        objsetPasswordViewModel.setMPIN()
        
//        self.dismiss(animated:true)
//        guard let objHome = UIStoryboard.DashboardVC() else { return }
//        APPDELEGATE.openViewController(Controller: objHome)
        
       // self.navigationController?.popToRootViewController(animated: true)
    }
    
     @IBAction func actionCancel(_ sender: Any) {
         self.dismiss(animated:true)
     }
    
    
   

}
extension SetupMPINVC:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        let maxLength = 4
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        
        return newString.count <= maxLength
    }
}
