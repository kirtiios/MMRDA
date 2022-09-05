//
//  PasswordInstructionVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 18/08/22.
//

import UIKit

class PasswordInstructionVC: UIViewController {
    
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    var message:String?
    var titleName:String?

    @IBOutlet weak var popupview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        popupview.layer.cornerRadius = 6
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        lblMessage.text = message
        lblTitle.text = titleName
       
        // Do any additional setup after loading the view.
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
