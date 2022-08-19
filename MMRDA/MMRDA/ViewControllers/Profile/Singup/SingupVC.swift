//
//  SingupVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 17/08/22.
//

import UIKit

class SingupVC: UIViewController {

    @IBOutlet weak var lblLinkResgiter: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        
    }
}


extension SingupVC {
    private func initialize() {
        lblLinkResgiter.attributedText = "alreadyhaveanaccount".LocalizedString.getAttributedStrijng(titleString:"alreadyhaveanaccount".LocalizedString, subString: "login".LocalizedString, subStringColor:Colors.APP_Theme_color.value)
    }
}
