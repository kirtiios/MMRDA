//
//  FilterTransportTypeViewController.swift
//  MMRDA
//
//  Created by Sandip Patel on 31/08/22.
//

import UIKit

class FilterTransportTypeViewController: UIViewController {
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var btnTrasportType: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 6
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionDropDwonopen(_ sender: Any) {
        
    }
    
    
    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated:true)
        
    }
    
    @IBAction func actionApply(_ sender: Any) {
        self.dismiss(animated:true)
    }
    
    @IBAction func actionCancel(_ sender: Any) {
        self.dismiss(animated:true)
    }
    
}
