//
//  CityGuideVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 07/09/22.
//

import UIKit

class CityGuideVC: BaseVC {
    @IBAction func btnActionDirectionClicked(_ sender: UIButton) {
        
       // "http://maps.google.com/maps?daddr=" + latitude + "," + longitude
       // navigateToMaps("19.0170", "72.8304");
        if let url = URL(string:"http://maps.google.com/maps?daddr=\(19.0170),\(72.8304)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                    print("Open url : \(success)")
                })
            }
        }
        
    }
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
   

}
