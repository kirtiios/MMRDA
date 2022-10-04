//
//  ConatctUSVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 07/09/22.
//

import UIKit

class ConatctUSVC: BaseVC {

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"lbl_contact_us".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
            let filterButton2 = self.barButton2(imageName:"Home", selector: #selector(mpoveToHome))
            self.navigationItem.rightBarButtonItems = [filterButton2]
        
        // Do any additional setup after loading the view.
        }
    
    @objc func mpoveToHome() {
        self.navigationController?.popToRootViewController(animated:true)
        
    }
    @IBAction func actionDirections(_ sender: UIButton) {
       // navigateToMaps("19.0170", "72.8304");
    }
    
}
