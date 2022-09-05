//
//  EditLoginDetailsVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 05/09/22.
//

import UIKit

class EditLoginDetailsVC: UIViewController {
    
    @IBOutlet weak var txtEmailOrMobile: UITextField!
    @IBOutlet weak var btnMobileNumber: UIButton!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var viewMobile: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var popupView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 6
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        actionSegmentChnage(btnEmail)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionSegmentChnage(_ sender: UIButton) {
        if sender.tag == 101 {
            btnEmail.titleLabel?.textColor = UIColor.white
            btnEmail.backgroundColor = Colors.APP_Theme_color.value
            btnMobileNumber.setTitleColor(Colors.APP_Theme_color.value, for: .normal)
            btnMobileNumber.backgroundColor = UIColor.white
            txtEmailOrMobile.placeholder = "email".LocalizedString
            lblTitle.text = "email".LocalizedString
            
        }else{
            btnMobileNumber.setTitleColor( UIColor.white, for: .normal)
            btnMobileNumber.backgroundColor = Colors.APP_Theme_color.value
            btnEmail.titleLabel?.textColor = Colors.APP_Theme_color.value
            btnEmail.backgroundColor = UIColor.white
            txtEmailOrMobile.placeholder = "lbl_mobile_number".LocalizedString
            lblTitle.text = "lbl_mobile_number".LocalizedString
            
            
            
        }
        
    }
    
    
    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func actionSave(_ sender: Any) {
        self.dismiss(animated: true)
        
    }
}
