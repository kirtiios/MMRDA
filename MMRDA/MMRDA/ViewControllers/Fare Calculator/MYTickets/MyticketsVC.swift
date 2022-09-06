//
//  MYTicketsVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 31/08/22.
//

import UIKit

class MyticketsVC: BaseVC {
    
    @IBOutlet weak var viewHistory: UIView!
    @IBOutlet weak var viewRecent: UIView!
    @IBOutlet weak var segmentHistory: UIButton!
    @IBOutlet weak var segementRecent: UIButton!
    @IBOutlet weak var tblView: UITableView!
    
  //  var intTransportMode
    @IBOutlet weak var lblTop: UILabel!
    
    var arrTicketList = [myTicketList](){
        didSet {
            self.tblView.reloadData()
        }
    }
    
    private var objViewModel = TicketModelView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"mytickets".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        let filterButton = self.barButton2(imageName:"filter", selector: #selector(filterAction))
        let filterButton2 = self.barButton2(imageName:"Home", selector: #selector(mpoveToHome))
        self.navigationItem.rightBarButtonItems = [filterButton,filterButton2]
        self.actionSegmentChange(segementRecent)
        
    }
    @objc func mpoveToHome() {
        self.navigationController?.popToRootViewController(animated:true)
        
    }
    @objc func filterAction() {
        let root = UIWindow.key?.rootViewController!
        let firstPresented = UIStoryboard.FilterTransportTypeVC()
        firstPresented.completion = {id in
            
        }
        firstPresented.modalTransitionStyle = .crossDissolve
        firstPresented.modalPresentationStyle = .overCurrentContext
        root?.present(firstPresented, animated: false, completion: nil)
    }
    
    
    
    @IBAction func actionSegmentChange(_ sender: UIButton) {
        
        var param = [String:Any]()
        param ["UserID"] = Helper.shared.objloginData?.intUserID
        param["intTransportMode"] = 0
        if sender.tag == 102 { // historu
            viewHistory.backgroundColor = Colors.APP_Theme_color.value
            viewRecent.backgroundColor = UIColor.lightGray
            segmentHistory.setTitleColor(Colors.APP_Theme_color.value, for:.normal)
            segementRecent.setTitleColor(UIColor.black, for:.normal)
            param ["intFlag"] = 10
            
            lblTop.text = "ticket_history_hint1".LocalizedString
           
            
            
        }else { // recent
            viewRecent.backgroundColor = Colors.APP_Theme_color.value
            viewHistory.backgroundColor = UIColor.lightGray
            segementRecent.setTitleColor(Colors.APP_Theme_color.value, for:.normal)
            segmentHistory.setTitleColor(UIColor.black, for:.normal)
            lblTop.text = "ticket_history_hint".LocalizedString
            param ["intFlag"] = 0
            
        }
        
        objViewModel.getMyTicketList(param: param)
        
    }
    
}



extension MyticketsVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTicketList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"TicketDetailCell") as? TicketDetailCell else  { return UITableViewCell() }
        
        let objData = arrTicketList[indexPath.row]
        cell.lblTransctionDate.text = objData.transactionDate
        cell.lblTransctionID.text = "\(objData.intMOTransactionID ?? 0)"
        cell.lbltotalAmount.text = "\(objData.totaL_FARE ?? 0) INR"
        cell.completionBlock = {
            DispatchQueue.main.async {
                self.tblView.beginUpdates()
                self.tblView.endUpdates()
            }
        }
        
        cell.completionBlockData = {
            let vc = UIStoryboard.GenerateQRcodeVC()
            self.navigationController?.pushViewController(vc, animated:true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    
}
extension MyticketsVC:ViewcontrollerSendBackDelegate {
    func getInformatioBack<T>(_ handleData: inout T) {
        if let data = handleData as? [myTicketList] {
            arrTicketList = data
        }
        
       
    }
}
