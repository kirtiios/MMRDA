//
//  ChnagePasswordVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 02/09/22.
//

import UIKit

class ChnagePasswordVC: UIViewController {

    @IBOutlet weak var popupView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 6
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
     @IBAction func actionChnage(_ sender: Any) {
         self.dismiss(animated: true)
     }
     

    
   

}
