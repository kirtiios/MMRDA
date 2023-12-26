//
//  AboutDeveloperVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 02/09/22.
//

import UIKit

class AboutDeveloperVC: BaseVC {
    
    var contentValue:String?
    var titleValue:String = ""
    

    @IBOutlet weak var lblContentName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:titleValue, isHomeScreen:false,isDisplaySOS: false)
        lblContentName.text = contentValue ?? ""
        let Home = self.barButton2(imageName:"Home", selector: #selector(mpoveToHome))
        self.navigationItem.rightBarButtonItems = [Home]
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
