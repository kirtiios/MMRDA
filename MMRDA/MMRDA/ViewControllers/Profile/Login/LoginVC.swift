//
//  LoginVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 17/08/22.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var mpinContainerView: UIView!
    @IBOutlet weak var SegmentUserID: UIButton!
    @IBOutlet weak var userIDView: UIStackView!
    @IBOutlet weak var SegmentMPIN: UIButton!
    @IBOutlet weak var mpinView: UIStackView!
    @IBOutlet weak var userIDContainerView: UIView!
    
    @IBOutlet weak var lblLoginLink: UILabel!
    @IBOutlet weak var lblRegisterLink: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    
    
    @IBAction func actionSegmentChnage(_ sender: UIButton) {
        if sender.tag == 101 {
            userIDView.isHidden = true
            mpinView.isHidden = false
            mpinContainerView.backgroundColor = Colors.APP_Theme_color.value
            userIDContainerView.backgroundColor = UIColor.lightGray
            SegmentMPIN.setTitleColor(Colors.APP_Theme_color.value, for:.normal)
            SegmentMPIN.backgroundColor = UIColor.white
            SegmentUserID.setTitleColor(UIColor.gray, for:.normal)
        }else{
            userIDView.isHidden = false
            mpinView.isHidden = true
            userIDContainerView.backgroundColor = Colors.APP_Theme_color.value
            mpinContainerView.backgroundColor = UIColor.lightGray
            SegmentUserID.setTitleColor(Colors.APP_Theme_color.value, for:.normal)
            SegmentUserID.backgroundColor = UIColor.white
            SegmentMPIN.setTitleColor(UIColor.gray, for:.normal)
        }
        
        
    }
    
    @IBAction func actionLogin(_ sender: Any) {
        self.showAlertViewWithMessageCancelAndActionHandler("APPTITLE".LocalizedString, message:"tv_are_you_want_to_set_mpin".LocalizedString) {
            let root = UIWindow.key?.rootViewController!
            if let firstPresented = UIStoryboard.SetupMPINVC() {
                firstPresented.modalTransitionStyle = .crossDissolve
                firstPresented.modalPresentationStyle = .overCurrentContext
                root?.present(firstPresented, animated: false, completion: nil)
            }
        }
        
    }
    
    
    // MARK:Open SingupPage
    
    @IBAction func actionpenRegisterVC(_ sender: Any) {
        let vc = UIStoryboard.SignUpVC()
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    
    @IBAction func actionForgotPIN(_ sender: Any) {
        let vc = UIStoryboard.ForgotMobilePINVC()
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func actionForgotPassword(_ sender: Any) {
        let vc = UIStoryboard.ForgotPasswordVC()
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    /*
     
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension LoginVC {
    private func initialize() {
        self.actionSegmentChnage(SegmentMPIN)
        lblRegisterLink.attributedText =  "donthaveaccount".LocalizedString.getAttributedStrijng(titleString: "donthaveaccount".LocalizedString, subString:"signup".LocalizedString, subStringColor: Colors.APP_Theme_color.value)
        lblLoginLink.attributedText =  "donthaveaccount".LocalizedString.getAttributedStrijng(titleString: "donthaveaccount".LocalizedString, subString:"signup".LocalizedString, subStringColor: Colors.APP_Theme_color.value)
    }
}
