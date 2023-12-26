//
//  InformationVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 21/02/23.
//

import UIKit

class InformationVC: UIViewController {
    var compeltion:(()->Void)?
    
    @IBOutlet weak var popupView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated:true)
        
    }
}
