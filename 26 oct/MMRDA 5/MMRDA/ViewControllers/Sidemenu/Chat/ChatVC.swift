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
       // objwebview.url = URL(string:"https://mmrdawebdev.amnex.com/#/commuter/mobile-view-chat-bot-with-image")
      //  objwebview.url = URL(string: "https://mmrdawebbeta.amnex.com/#/commuter/mobile-view-chat-bot-with-image")
        objwebview.url = URL(string: "https://app.intelliticks.com/widgets/engage/C5gqxGqQqJBJKYaWX_c?ref=&landing=https%3A%2F%2Fmmrdaportal.amnex.com%2F%23%2Fcommuter&v=1&cudId=null")
        self.navigationController?.pushViewController(objwebview, animated: true)
    }

   

}
