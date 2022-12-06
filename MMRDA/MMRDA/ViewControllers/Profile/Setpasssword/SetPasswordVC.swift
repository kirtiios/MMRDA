//
//  ForgotPasswordVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 17/08/22.
//

import UIKit
import ACFloatingTextfield_Swift

class SetPasswordVC: UIViewController {
    
    @IBOutlet weak var textPassword: ACFloatingTextfield!
    @IBOutlet weak var textConfirmPassword: ACFloatingTextfield!
    var objsetPasswordViewModel = setPasswordViewModel()
    var param = [String:Any]()
    @IBOutlet weak var lblerror: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        lblerror.textColor = UIColor(hexString: "#FF0000")
        self.setBackButton()
//        self.callBarButtonForHome(leftBarLabelName: "", isHomeScreen:false,isDisplaySOS:false)
        objsetPasswordViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                  
                    self?.lblerror.text = message
                }
            }
        }
        let barButton = UIBarButtonItem(image: UIImage(named:"back"), style:.plain, target: self, action: #selector(self.gotoBackRegisterScreen))
        barButton.tintColor = UIColor.black
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = barButton
        
        objsetPasswordViewModel.dict = param
        objsetPasswordViewModel.bindViewModelToController =  {sucess,message  in
            
            UserDefaults.standard.set(false, forKey: userDefaultKey.isMpinEnable.rawValue)
            UserDefaults.standard.synchronize()
            
            let firstPresented = UIStoryboard.SuccessRegisterVC()
            firstPresented?.isVerifyOTPFor = .Register
            self.navigationController?.pushViewController(firstPresented!, animated: true)
        }
       
        // Do any additional setup after loading the view.
    }
    @objc func gotoBackRegisterScreen(){
        self.navigationController?.popToViewController(ofClass:SignupVC.self)
    }
    
   
    
    @IBAction func actionPasswoedinstruction(_ sender: Any) {
        let root = UIWindow.key?.rootViewController!
        if let firstPresented = UIStoryboard.PasswordInstructionVC() {
            firstPresented.message = "password_instructions_text".LocalizedString
            firstPresented.titleName = "password_instructions".LocalizedString
            firstPresented.modalTransitionStyle = .crossDissolve
            firstPresented.modalPresentationStyle = .overCurrentContext
            root?.present(firstPresented, animated: false, completion: nil)
        }
    }
    
    
    @IBAction func actionPasswordChnagesSuccessFully(_ sender: Any) {
        
        
        objsetPasswordViewModel.strPassword = textPassword.text ?? ""
        objsetPasswordViewModel.strConfirm = textConfirmPassword.text ?? ""
        
        objsetPasswordViewModel.submitSignUP()
        
        
        
       
    }
        
        
}



