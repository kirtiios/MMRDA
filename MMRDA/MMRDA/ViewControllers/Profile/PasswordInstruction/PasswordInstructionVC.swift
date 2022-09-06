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
        
        let getsure = UITapGestureRecognizer(target: self, action: #selector(btnCloseCliced(gesture:)))
        self.view.addGestureRecognizer(getsure)
        
       // share_my_loc

        // Do any additional setup after loading the view.
    
    
       
        // Do any additional setup after loading the view.
    }
    @objc func btnCloseCliced(gesture:UITapGestureRecognizer){
        self .dismiss(animated: true, completion: nil)
    }

    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated:true)
    }
   

}
