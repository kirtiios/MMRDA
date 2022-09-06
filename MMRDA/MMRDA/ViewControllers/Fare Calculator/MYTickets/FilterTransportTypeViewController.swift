//
//  FilterTransportTypeViewController.swift
//  MMRDA
//
//  Created by Sandip Patel on 31/08/22.
//

import UIKit
import DropDown

class FilterTransportTypeViewController: UIViewController {
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var btnTrasportType: UIButton!
    
    var completion:((_ id:Int)->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 6
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionDropDwonopen(_ sender: UIButton) {
        
        let dropDown = DropDown()
        // The view to which the drop down will appear on
        dropDown.anchorView = sender // UIView or UIBarButtonItem

        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = ["tv_select_transportatiomn".LocalizedString, "metro".LocalizedString, "bus".LocalizedString,"tv_taxi".LocalizedString]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
        }
        dropDown.show()
    }
    
    
    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated:true)
        
    }
    
    @IBAction func actionApply(_ sender: Any) {
        
        if btnTrasportType.titleLabel?.text == "tv_select_transportatiomn".LocalizedString {
            self.showAlertViewWithMessage("", message: "tv_select_transport_validation".LocalizedString)
        }
        else {
            self.completion?(0)
        }
        self.dismiss(animated:true)
    }
    
    @IBAction func actionCancel(_ sender: Any) {
        self.dismiss(animated:true)
    }
    
}
