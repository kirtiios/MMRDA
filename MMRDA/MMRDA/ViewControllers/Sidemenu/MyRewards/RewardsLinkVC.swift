//
//  RewadsLinkVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 30/08/22.
//

import UIKit

class RewardsLinkVC: BaseVC {

    @IBOutlet weak var tblView: UITableView!

    var arrLinks = ["lbl_buy_ticket".LocalizedString,
                    "lbl_purchase_pass".LocalizedString,
                    "lbl_smart_card_top_up".LocalizedString.LocalizedString,
                    "lbl_passrecharge".LocalizedString]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"lbl_rewards_link".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        self.tblView.register(UINib(nibName: "cellHelpLine", bundle: nil), forCellReuseIdentifier: "cellHelpLine")
        // Do any additional setup after loading the view.
    }
}




extension RewardsLinkVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrLinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellHelpLine") as? cellHelpLine else { return UITableViewCell() }
        //cell.imgMenu.image = UIImage(named: arrMenus[indexPath.row].imageName ?? "")
        cell.lblName.text = arrLinks[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
