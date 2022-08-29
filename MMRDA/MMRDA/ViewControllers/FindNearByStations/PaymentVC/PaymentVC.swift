//
//  PaymentVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 26/08/22.
//

import UIKit

class PaymentVC: BaseVC {
    
    @IBOutlet weak var btnTotalAmount: UIButton!
    @IBOutlet weak var btnDistance: UIButton!
    @IBOutlet weak var btnChild: UIButton!
    @IBOutlet weak var btnSeniorcitizen: UIButton!
    @IBOutlet weak var btndifferentlyEnabled: UIButton!
    @IBOutlet weak var btnAddult: UIButton!
    @IBOutlet weak var btnNoOfPassengers: UIButton!
    @IBOutlet weak var btnToStation: UIButton!
    @IBOutlet weak var btnFromStation: UIButton!
    @IBOutlet weak var tblPayment: UITableView!
    @IBOutlet weak var constTblViewHeight: NSLayoutConstraint!
    @IBOutlet weak var constTblPaymentHeight: NSLayoutConstraint!
    @IBOutlet weak var tblview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"payment".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func actionOpenFromStationList(_ sender: Any) {
        
    }
    
    
    @IBAction func actionOpenToStationList(_ sender: Any) {
    }
    
    @IBAction func actionOpenNoOfpassengersList(_ sender: Any) {
        
    }
    
    @IBAction func actionOpenAdultCategory(_ sender: Any) {
    }
    
    @IBAction func actionOpenChildCategory(_ sender: Any) {
    }
    
    
    @IBAction func actionOpenHandicapCategory(_ sender: Any) {
    }
    
    @IBAction func actionOpenSeniorCitizenCategory(_ sender: Any) {
        
    }
    
    
    @IBAction func actionViewFareOptionsList(_ sender: Any) {
        
    }
    
    @IBAction func actionCancel(_ sender: Any) {
        
    }
    
    @IBAction func actionPayNow(_ sender: Any) {
        let root = UIWindow.key?.rootViewController!
        if let firstPresented = UIStoryboard.ConfirmPaymentVC() {
            firstPresented.modalTransitionStyle = .crossDissolve
            firstPresented.modalPresentationStyle = .overCurrentContext
            root?.present(firstPresented, animated: false, completion: nil)
        }
        
        
        
    }
    
}



extension PaymentVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 101 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier:"PaymentOptionsCell") as? PaymentOptionsCell else  { return UITableViewCell() }
        
            DispatchQueue.main.async {
                self.constTblViewHeight.constant = tableView.contentSize.height
                self.tblview.layoutIfNeeded()
            }
            
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier:"PaymentAmountDetailCell") as? PaymentAmountDetailCell else  { return UITableViewCell() }
        
            DispatchQueue.main.async {
                self.constTblPaymentHeight.constant = tableView.contentSize.height
                self.tblPayment.layoutIfNeeded()
            }
            
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
}
