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
    
    @IBOutlet weak var btnLoadMore: UIButton!
    
    var currentTransPortID = 0
    var arrTicketList = [myTicketList](){
        didSet {
            self.tblView.reloadData()
            if arrTicketList.last?.intTotalCount == arrTicketList.count || arrTicketList.count == 0 {
                btnLoadMore.superview?.isHidden = true
            }else {
                btnLoadMore.superview?.isHidden = false
            }
        }
    }
    var currentPage = 1
    
    private var objViewModel = TicketModelView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"mytickets".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        objViewModel.delegate = self
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
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
            self.currentTransPortID = id
            self.segmentHistory.sendActions(for: .touchUpInside)
        }
        firstPresented.currenIndex = self.currentTransPortID
        firstPresented.modalTransitionStyle = .crossDissolve
        firstPresented.modalPresentationStyle = .overCurrentContext
        root?.present(firstPresented, animated: false, completion: nil)
    }
    
    
    
    @IBAction func actionSegmentChange(_ sender: UIButton) {
        
        var param = [String:Any]()
        param ["UserID"] = Helper.shared.objloginData?.intUserID
        param["intTransportMode"] = currentTransPortID
        param ["intFlag"] = 0
        if sender == segmentHistory { // historu
            viewHistory.backgroundColor = Colors.APP_Theme_color.value
            viewRecent.backgroundColor = UIColor.lightGray
            segmentHistory.setTitleColor(Colors.APP_Theme_color.value, for:.normal)
            segementRecent.setTitleColor(UIColor.black, for:.normal)
            lblTop.superview?.isHidden = false
            lblTop.text = "ticket_history_hint1".LocalizedString
            currentPage = 1
            param ["intPageNo"] = currentPage
            param ["intPageSize"] = 10
            btnLoadMore.superview?.isHidden = true
            
        }else if  sender == segementRecent {
            viewRecent.backgroundColor = Colors.APP_Theme_color.value
            viewHistory.backgroundColor = UIColor.lightGray
            segementRecent.setTitleColor(Colors.APP_Theme_color.value, for:.normal)
            segmentHistory.setTitleColor(UIColor.black, for:.normal)
            lblTop.text = "ticket_history_hint".LocalizedString
            currentPage = 1
            lblTop.superview?.isHidden = true
            param ["intFlag"] = 10
            param ["intPageNo"] = currentPage
            param ["intPageSize"] = 1000
            btnLoadMore.superview?.isHidden = true
            
        }else {
            currentPage = currentPage + 1
            param ["intPageNo"] = currentPage
            param ["intPageSize"] = 10
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
       
        cell.completionBlock = {
            DispatchQueue.main.async {
                self.tblView.beginUpdates()
                self.tblView.endUpdates()
            }
        }
        cell.cellConfig(objdata: objData, indexpath: indexPath)
        cell.completionBlockData = { indexPath  in
            let vc = UIStoryboard.GenerateQRcodeVC()
            vc.objTicket = self.arrTicketList[indexPath.row]
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
            if currentPage == 1 {
                arrTicketList.removeAll()
            }
            arrTicketList.append(contentsOf: data)
           // arrTicketList = data
        }
        
       
    }
}
