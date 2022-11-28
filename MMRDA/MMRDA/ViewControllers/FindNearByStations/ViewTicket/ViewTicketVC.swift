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
    var arrHistory = [myTicketList]()
    var strPaymentStatus = String()
    var selectedIndexQR = -1
    var selectedViewTicket = -1
    @objc func btnActionGoHome(){
        
        for controller in (self.navigationController?.viewControllers ?? [UIViewController]()) as Array {
            if controller.isKind(of: RoueDetailVC.self) {
                self.navigationController?.popToViewController(controller, animated: true)
                break
            }
            if controller.isKind(of: PlanjourneyRouetDetailsVC.self) {
                self.navigationController?.popToViewController(controller, animated: true)
                break
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "lbl_view_ticket".localized()
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
        tblView.reloadData()
        
        if self.arrHistory.count > 0 {
            let obj = self.arrHistory.first
            self.lblDate.text = obj?.transactionDate
            self.lblAmount.text = "Rs.\(obj?.totaL_FARE ?? 0)"
            self.lblRefID.text = "\(obj?.strTicketRefrenceNo ?? "")"
            self.lblRouteName.text = obj?.routeName
        }
//       if  let view = tblView.superview?.superview as? UIView {
//            view.hideContentOnScreenCapture()
//        }
       

        // Do any additional setup after loading the view.
    }
}


extension ViewTicketVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrHistory.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tblView.dequeueReusableCell(withIdentifier:"ViewTicketCell") as! ViewTicketCell
        let objhistory = arrHistory[indexPath.row]
        cell.objHistroy = objhistory
        cell.lblFromStatioName.text = objhistory.from_Station
        cell.lblToStatioName.text = objhistory.to_Station
        cell.btnQRCode.tag = indexPath.row
        cell.btnViewDetail.tag = indexPath.row
      //  cell.btnPenality.tag = indexPath.row
        cell.viewQRCode.isHidden = true
       // cell.viewQRCode.layer.sublayers?.removeAll()
        cell.viewTicketDetails.isHidden = true
        if selectedIndexQR == indexPath.row {
            cell.viewQRCode.isHidden = false
            cell.lblTicketQRNotFound.isHidden = true
            if let strQRCode = objhistory.convertedQR,strQRCode.isEmpty == false {
                if let img = Helper.shared.generateQRCode(from: strQRCode) {
                    cell.imgQRCode.image =  img
                }
            }else {
                cell.lblTicketQRNotFound.isHidden = false
                cell.lblTicketQRNotFound.text = "qr_not_found".localized()
            }
           
        }
        if selectedViewTicket == indexPath.row {
            cell.viewTicketDetails.isHidden = false
        }
        
        
       
        cell.completionBlockQR = { index in
            
            print("Index clicked")
            self.selectedViewTicket = -1
            if index == self.selectedIndexQR {
                self.selectedIndexQR = -1
            }else {
                self.selectedIndexQR =  index
            }
            DispatchQueue.main.async {
                self.tblView.beginUpdates()
                self.tblView.endUpdates()
                self.tblView.reloadData()
            }
        }
        cell.completionBlockTicket = { index in
            self.selectedIndexQR = -1
            if index == self.selectedViewTicket {
                self.selectedViewTicket = -1
            }else {
                self.selectedViewTicket =  index
            }
            DispatchQueue.main.async {
                self.tblView.beginUpdates()
                self.tblView.endUpdates()
                self.tblView.reloadData()
            }
        }
        cell.completionHideAll = { index in
            if self.selectedIndexQR == index {
                self.selectedIndexQR = -1
            }
            if self.selectedViewTicket == index {
                self.selectedViewTicket = -1
            }
            DispatchQueue.main.async {
                self.tblView.beginUpdates()
                self.tblView.endUpdates()
                self.tblView.reloadData()
            }
        }
        cell.completionQRHelpClicked =  { index in
            let firstPresented = AlertViewVC(nibName:"AlertViewVC", bundle: nil)
            firstPresented.strMessage = "strPenalityMessage".LocalizedString
            firstPresented.cancelButtonTitle = "cancel".localized()
            firstPresented.isHideImage = true
            firstPresented.okButtonTitle = "ok".LocalizedString
            firstPresented.completionOK = {
                let vc = UIStoryboard.PaymentVC()
                vc?.objTicket = self.arrHistory[index]
                vc?.fromType  = .QRCodeGenerator
                self.navigationController?.pushViewController(vc!, animated:true)

            }
            firstPresented.modalTransitionStyle = .crossDissolve
            firstPresented.modalPresentationStyle = .overCurrentContext
            self.present(firstPresented, animated: true, completion: nil)
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
