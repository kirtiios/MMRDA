//
//  ConatctUSVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 07/09/22.
//

import UIKit

class ContactUSVC: BaseVC {

    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"lbl_contact_us".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        let filterButton2 = self.barButton2(imageName:"Home", selector: #selector(mpoveToHome))
        self.navigationItem.rightBarButtonItems = [filterButton2]
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapEmail))
        lblEmail.isUserInteractionEnabled = true
        lblEmail.addGestureRecognizer(tap)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(tapMobile))
        lblMobile.isUserInteractionEnabled = true
        lblMobile.addGestureRecognizer(tap1)
        
        // Do any additional setup after loading the view.
    }
    @objc func tapEmail(sender:UITapGestureRecognizer) {
        if let lbl = sender.view as? UILabel {
            if let url = URL(string: "mailto:\(lbl.text ?? "")") {
                UIApplication.shared.open(url)
            }
        }

        print("tap working")
    }
    @objc func tapMobile(sender:UITapGestureRecognizer) {

        if let lbl = sender.view as? UILabel {
            let number = lbl.text?.replace(" ", replacementString: "")
            if let url = URL(string: "tel://\(number ?? "")"),
               UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                // add error message here
            }
        }
    }
    @objc func mpoveToHome() {
        self.navigationController?.popToRootViewController(animated:true)
        
    }
    @IBAction func actionDirections(_ sender: UIButton) {
       // navigateToMaps("19.0170", "72.8304");
    }
    
}
