//
//  MyRewards.swift
//  MMRDA
//
//  Created by Sandip Patel on 30/08/22.
//

import UIKit

class MyRewardsVC: BaseVC {

    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var segmentEarned: UIButton!
    @IBOutlet weak var viewReddemed: UIView!
    @IBOutlet weak var viewEarned: UIView!
    @IBOutlet weak var lblAmountValue: UILabel!
    @IBOutlet weak var lblPointsValue: UILabel!
    
    @IBOutlet weak var tableview: UITableView!
    
    var arrRewardTransctionList = [rewardTransctionModel](){
        didSet {
            self.tableview.reloadData()
        }
    }
    var objreward:rewardDetailModel?{
        didSet {
            lblPointsValue.text = "\(objreward?.intAvailableRewardPoint ?? 0)"
            lblTotalAmount.text = "\(objreward?.intAvailableRewardPoint ?? 0)"
            lblAmountValue.text = "\(objreward?.intRewardRs ?? 0)"
        }
    }
    
    private var  objViewModel = RewardModelView()
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"lbl_rewards_link".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        self.setBackButton()
        self.navigationItem.title = "lbl_rewards_link".LocalizedString
        self.setRightHomeButton()
      
        
        objViewModel.delegate = self
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
        objViewModel.getrewardDetail()
        segmentEarned.sendActions(for: .touchUpInside)
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func actionReddemNow(_ sender: Any) {
        let vc = UIStoryboard.RewardsLinkVC()
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    

    @IBAction func actionSegmentChnaged(_ sender: UIButton) {
        
        if sender.tag == 101 { // Schedule
            viewEarned.backgroundColor = Colors.APP_Theme_color.value
            viewReddemed.backgroundColor = UIColor.lightGray
            objViewModel.getrewardTranasctionList(type: 1)
            
        }else { // Running
            viewReddemed.backgroundColor = Colors.APP_Theme_color.value
            viewEarned.backgroundColor = UIColor.lightGray
            objViewModel.getrewardTranasctionList(type: 2)
        }
    }
}


extension MyRewardsVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRewardTransctionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"MyRewardsCell") as? MyRewardsCell else  { return UITableViewCell() }
        
//        "transactionid" = "Transaction ID:";
//        "tv_earned" = "You earned";
        let objdata = arrRewardTransctionList[indexPath.row]
        cell.lblPoints.text = "+\(objdata.intRewardPoint ?? 0)"
        cell.lblEarnedPoints.text = "tv_earned".LocalizedString + " \(objdata.intRewardPoint ?? 0)" +  "tv_points".LocalizedString
        cell.lbltransactionDetail.text = "transactionid".LocalizedString + " \(objdata.strTransactionRefNo ?? "")" + " , " + "tv_inr".LocalizedString + "\(objdata.intRewardAmount ?? 0)"
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
}
    
    
}
extension MyRewardsVC:ViewcontrollerSendBackDelegate {
    func getInformatioBack<T>(_ handleData: inout T) {
        if let data = handleData as? [rewardTransctionModel] {
            arrRewardTransctionList = data
        }
        if let data = handleData as? [rewardDetailModel] {
            objreward = data.first
        }
       
    }
}
