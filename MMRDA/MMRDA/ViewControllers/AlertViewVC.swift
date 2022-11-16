//
//  AlertViewVC.swift
//  MMRDA
//
//  Created by Kirti Chavda on 14/09/22.
//

import UIKit

class AlertViewVC: UIViewController {
    
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnOK: UIButton!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var imgTop: UIImageView!
    
    var completionOK:(()->Void)?
    
    
    var strMessage = ""
    var okButtonTitle:String?
    var img = UIImage()
    var isHideCancel = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()
        lblMessage.text = strMessage
        imgTop.image = img
        
        let getsure = UITapGestureRecognizer(target: self, action: #selector(btnCloseCliced(gesture:)))
        self.view.addGestureRecognizer(getsure)
        if isHideCancel {
            btnCancel.isHidden = true
        }
        
        if let strtitle = okButtonTitle  {
            btnOK .setTitle(strtitle, for: .normal)
        }else {
            btnOK .setTitle("yes".localized(), for: .normal)
        }
        
        // share_my_loc
        
        // Do any additional setup after loading the view.
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnActionCancelClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnActionOKClicked(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.completionOK?()
        }
       
    }
    @objc func btnCloseCliced(gesture:UITapGestureRecognizer){
        self .dismiss(animated: true, completion: nil)
    }
    
    
}
