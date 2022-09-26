//
//  ViewTicketVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 29/08/22.
//

import UIKit

class ViewTicketVC: BaseVC {

    @IBOutlet weak var lblRefID: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblRouteName: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var constTblPaymentHeight: NSLayoutConstraint!
    var objPayment:PaymentModel?
    private var objViewModel = PaymentViewModel()
    var arrHistory:[ViewTicketModel]?{
        didSet {
            tblView.reloadData()
        }
        
    }
    @objc func btnActionGoHome(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "payment".localized()
        let barButton = UIBarButtonItem(image: UIImage(named:"back"), style:.plain, target: self, action: #selector(btnActionGoHome))
        barButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = barButton
       // self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"payment".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
        
        var param = [String:Any]()
        param["UserID"] = Helper.shared.objloginData?.intUserID
        param["strTicketRefrenceNo"] = objPayment?.strTicketRefrenceNo
        param["intFlag"] = 0
        objViewModel.getTicketHistory(param: param) { objarr in
            self.arrHistory = objarr
            
            if self.arrHistory?.count ?? 0 > 0 {
                let obj = self.arrHistory?.first
                self.lblDate.text = obj?.transactionDate
                self.lblAmount.text = "Rs.\(obj?.totaL_FARE ?? 0)"
                self.lblRefID.text = "pass_reference_no".LocalizedString  + "\(obj?.strTicketRefrenceNo ?? "")"
                self.lblRouteName.text = obj?.routeName
            }
        }
        // Do any additional setup after loading the view.
    }
}


extension ViewTicketVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrHistory?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"ViewTicketCell") as? ViewTicketCell else  { return UITableViewCell() }
        let objhistory = arrHistory?[indexPath.row]
        cell.objHistroy = objhistory
        cell.lblFromStatioName.text = objhistory?.from_Station
        cell.lblToStatioName.text = objhistory?.to_Station
        cell.completionBlock = {
            DispatchQueue.main.async {
                self.tblView.beginUpdates()
                self.tblView.endUpdates()
                self.tblView.reloadData()
            }
        }
        DispatchQueue.main.async {
            self.constTblPaymentHeight.constant = tableView.contentSize.height
            self.tblView.layoutIfNeeded()
        }
        return cell
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
