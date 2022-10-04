//
//  NotificationVC.swift
//  MMRDA
//
//  Created by Kirti Chavda on 13/09/22.
//

import UIKit

class NotificationVC: BaseVC {

    @IBOutlet weak var viewHistory: UIView!
    @IBOutlet weak var viewRecent: UIView!
    @IBOutlet weak var segmentHistory: UIButton!
    @IBOutlet weak var segementRecent: UIButton!
    @IBOutlet weak var tblView: UITableView!
    
    private var objViewModel = NotificationViewModel()
    
    var arrNotification = [NotificationModel](){
        didSet{
            tblView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"notifications".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        
        self.navigationItem.title = "notifications".localized()
        self.setBackButton()
        self.setRightHomeButton()
        objViewModel.delegate = self
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
        segementRecent.sendActions(for: .touchUpInside)
        objViewModel.updateNotificationList()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionSegmentChange(_ sender: UIButton) {
        
        var param = [String:Any]()
        param ["UserID"] = Helper.shared.objloginData?.intUserID
        param["intFlag"] = 0
        if sender == segmentHistory { // historu
            viewHistory.backgroundColor = Colors.APP_Theme_color.value
            viewRecent.backgroundColor = UIColor.lightGray
            segmentHistory.setTitleColor(Colors.APP_Theme_color.value, for:.normal)
            segementRecent.setTitleColor(UIColor.black, for:.normal)
            param ["intFlag"] = 0
          
           
            
            
        }else { // recent
            viewRecent.backgroundColor = Colors.APP_Theme_color.value
            viewHistory.backgroundColor = UIColor.lightGray
            segementRecent.setTitleColor(Colors.APP_Theme_color.value, for:.normal)
            segmentHistory.setTitleColor(UIColor.black, for:.normal)
       
            param ["intFlag"] = 10
            
        }
        
        objViewModel.getNotificationList(param:param)
        
    }
   

}
extension NotificationVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNotification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"CellNotification") as? CellNotification else  { return UITableViewCell() }
        
        let objData = arrNotification[indexPath.row]
        cell.lblTitle.text = objData.strNotification
        cell.lblTitle.numberOfLines = 0
        cell.lblDate.text = objData.date
        cell.lblTime.text = objData.time
       
//        cell.completionBlock = {
//            DispatchQueue.main.async {
//                self.tblView.beginUpdates()
//                self.tblView.endUpdates()
//            }
//        }
//        cell.cellConfig(objdata: objData, indexpath: indexPath)
//        cell.completionBlockData = { indexPath  in
//            let vc = UIStoryboard.GenerateQRcodeVC()
//            vc.objTicket = self.arrTicketList[indexPath.row]
//            self.navigationController?.pushViewController(vc, animated:true)
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    
}
extension NotificationVC:ViewcontrollerSendBackDelegate {
    func getInformatioBack<T>(_ handleData: inout T) {
        if let data = handleData as? [NotificationModel] {
            arrNotification = data
        }
        
       
    }
}
class CellNotification: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
}
