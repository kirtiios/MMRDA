//
//  WebviewVC.swift
//  MMRDA
//
//  Created by Kirti Chavda on 29/08/22.
//

import UIKit
import WebKit

class WebviewVC: BaseVC {

    @IBOutlet weak var webview: WKWebView!
    
    var objfromType:sidemenuItem?
    var url:URL?
    override func viewDidLoad() {
        super.viewDidLoad()

      //  if objfromType == .faretable || objfromType == .networkmap ||  objfromType == .timetable ||   objfromType == .timetable  {
            self.setBackButton()
            self.setRightHomeButton()
            self.navigationItem.title = objfromType?.rawValue.LocalizedString
      //  }
       
        if let url = url {
            webview.load(URLRequest(url: url))
        }
        // Do any additional setup after loading the view.
    }


  

}
