//
//  ChatVC.swift
//  MMRDA
//
//  Created by Kirti Chavda on 29/08/22.
//

import UIKit

class ChatVC: BaseVC {

   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
     
        self.setBackButton()
        self.setRightHomeButton()
        self.navigationItem.title = sidemenuItem.chatwithus.rawValue.LocalizedString
      
       
        //self.navigationController?.navigationBar.isTranslucent = false
    }
    @IBAction func btnActionStartClicked(_ sender: UIButton) {
        let objwebview = WebviewVC(nibName: "WebviewVC", bundle: nil)
        objwebview.objfromType = sidemenuItem.chatwithus
        objwebview.url = URL(string:"https://mmrdawebdev.amnex.com/#/commuter/mobile-view-chat-bot-with-image")
        self.navigationController?.pushViewController(objwebview, animated: true)
    }

   

}
