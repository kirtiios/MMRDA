//
//  SaveLocationVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 30/08/22.
//

import UIKit

class SaveLocationVC: UIViewController {

    @IBOutlet weak var txtLabelName: UITextField!
    @IBOutlet weak var txtLocatioName: UITextField!
    @IBOutlet weak var popupView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 6
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func actionSave(_ sender: Any) {
        
    }
    
    
    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated:true)
        
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
