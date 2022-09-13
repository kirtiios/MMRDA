//
//  WebviewVC.swift
//  MMRDA
//
//  Created by Kirti Chavda on 29/08/22.
//

import UIKit
import WebKit
import SVProgressHUD

class WebviewVC: BaseVC {

    @IBOutlet weak var webview: WKWebView!
    
    var objfromType:sidemenuItem?
    var url:URL?
    var titleString:String?
    override func viewDidLoad() {
        
        
        super.viewDidLoad()

      //  if objfromType == .faretable || objfromType == .networkmap ||  objfromType == .timetable ||   objfromType == .timetable  {
            self.setBackButton()
            self.setRightHomeButton()
        if titleString != nil {
            self.navigationItem.title = titleString
        }else{
            self.navigationItem.title = objfromType?.rawValue.LocalizedString
        }
            
      //  }
       
        if let url = url {
            webview.load(URLRequest(url: url))
        }
        webview.navigationDelegate = self
        // Do any additional setup after loading the view.
    }


  

}
extension WebviewVC:WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation:
                 WKNavigation!) {
        SVProgressHUD .dismiss()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation
                 navigation: WKNavigation!) {
        SVProgressHUD .show()
    }
    
    func webView(_ webView: WKWebView, didFail navigation:
                 WKNavigation!, withError error: Error) {
        SVProgressHUD .dismiss()
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        SVProgressHUD .dismiss()
        print("errror",error.localizedDescription)
    }
}
