//
//  SuccessRegisterVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 18/08/22.
//

import UIKit

class SuccessRegisterVC: UIViewController {

    @IBOutlet weak var popupview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
       
        // Do any additional setup after loading the view.
    }
    

    @IBAction func actionbackToLogin(_ sender: Any) {
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
