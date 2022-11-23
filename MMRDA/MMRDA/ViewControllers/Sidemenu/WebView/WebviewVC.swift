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
        
        self.setBackButton()
        if titleString != nil {
            self.navigationItem.title = titleString
        }else{
            self.navigationItem.title = objfromType?.rawValue.LocalizedString
        }
        
        if objfromType == .timetable {
            let barButton = UIBarButtonItem(image: UIImage(named:"download"), style:.plain, target: self, action: #selector(download))
            barButton.tintColor = UIColor.white
            self.navigationItem.rightBarButtonItem = barButton
        }else {
            self.setRightHomeButton()
        }
        
        
        //  }
        
        if let url = url {
            webview.load(URLRequest(url: url))
        }
        webview.navigationDelegate = self
        // Do any additional setup after loading the view.
    }
    @objc func download(){
        if let pdf = Bundle.main.url(forResource: "timetable", withExtension: "pdf")  {
            let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [pdf], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
}
extension WebviewVC:WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation:
                 WKNavigation!) {
        SVProgressHUD .dismiss()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation
                 navigation: WKNavigation!) {
        
        print("f",webView.url)
        SVProgressHUD .show()
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("",webView.url,navigationAction.request.url)
        
        if navigationAction.request.url?.absoluteString.contains("find-nearby-station") ?? false {
            let vc = UIStoryboard.FindNearByStopsVC()
            self.navigationController?.pushViewController(vc!, animated:true)
        }
        else if navigationAction.request.url?.absoluteString.contains("plan-journey") ?? false {
            let vc = UIStoryboard.JourneySearchVC()
            self.navigationController?.pushViewController(vc, animated:true)
        }
        else if navigationAction.request.url?.absoluteString.contains("grievance") ?? false {
            let objwebview = UIStoryboard.GrivanceDashBoardVC()
            self.navigationController?.pushViewController(objwebview!, animated: true)
        }else {
            SVProgressHUD .show()
        }
       
       
        decisionHandler(.allow)
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
