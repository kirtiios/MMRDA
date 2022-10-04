//
//  PaymentWebViewVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 21/09/22.
//

import UIKit
import WebKit
import SVProgressHUD


class PaymentWebViewVC: BaseVC {

    @IBOutlet weak var webview: WKWebView!
    
    var objPayment:PaymentModel?
    var completionBlock:((Bool)->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string:objPayment?.strPaymentURL ?? "") {
            webview.load(URLRequest(url: url))
        }
        webview.navigationDelegate = self
        
        self.setBackButton()
        // Do any additional setup after loading the view.
    }


  

}
extension PaymentWebViewVC:WKNavigationDelegate {
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
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
      //  if(navigationAction.navigationType == .other) {
        if let redirectedUrl = navigationAction.request.url?.absoluteString {
            
            if redirectedUrl == objPayment?.strSURL {
                var param = [String:Any]()
                param["strName"] = Helper.shared.objloginData?.strFullName
                param["strPhoneNo"] = Helper.shared.objloginData?.strMobileNo
                param["strEmailID"] = Helper.shared.objloginData?.strEmailID
                param["bOTPPrefix"] = false
                param["intOTPTypeSR"] = 1
                param["strOTPPrefix"] = nil
                param["strOTPNo"] = objPayment?.strTicketRefrenceNo
                param["intOTPTypeIDSMS"] = 4
                param["intOTPTypeIDEMAIL"] = 18
                param["strFilePath"] = nil
                param["bSendAsAttachment"] = false
                ApiRequest.shared.requestPostMethod(strurl: apiName.SendOTP, params: param, showProgress: true) { sucess, data, error in
                    if sucess {
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.navigationController?.popViewController(animated: true)
                            self.completionBlock?(true)
                        }
                        
                    }
                }
            }
            else if redirectedUrl == objPayment?.strFURL {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.completionBlock?(false)
                }
                
            }
            
            //do what you need with url
            //self.delegate?.openURL(url: redirectedUrl)
            //}
            decisionHandler(.allow)
            
        }
       // decisionHandler(.allow)
    }
}
