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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"lbl_rewards_link".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        self.actionSegmentChnaged(segmentEarned!)
        
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
//            sgementSchedule.setTitleColor(Colors.APP_Theme_color.value, for:.normal)
//            segmentRunning.backgroundColor = UIColor.white
//            segmentRunning.setTitleColor(UIColor.gray, for:.normal)
            
        }else { // Running
            viewReddemed.backgroundColor = Colors.APP_Theme_color.value
            viewEarned.backgroundColor = UIColor.lightGray
//            segmentRunning.setTitleColor(Colors.APP_Theme_color.value, for:.normal)
//            segmentRunning.backgroundColor = UIColor.white
//            sgementSchedule.setTitleColor(UIColor.gray, for:.normal)
        }
    }
}


extension MyRewardsVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"MyRewardsCell") as? MyRewardsCell else  { return UITableViewCell() }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
}
    
    
}
