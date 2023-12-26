//
//  MpinpopupVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 07/11/22.
//

import UIKit

class PenaltyHelp: UIViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
        let getsure = UITapGestureRecognizer(target: self, action: #selector(btnCloseCliced(gesture:)))
        self.view.addGestureRecognizer(getsure)
        // Do any additional setup after loading the view.
    }

    
    @objc func btnCloseCliced(gesture:UITapGestureRecognizer){
        self .dismiss(animated: true, completion: nil)
    }

}
