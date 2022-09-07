//
//  CityGuideVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 07/09/22.
//

import UIKit

class CityGuideVC: BaseVC {

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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
