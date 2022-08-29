//
//  JourneySerarchVC.swift
//  MMRDA
//
//  Created by Kirti Chavda on 24/08/22.
//

import UIKit

class JourneySearchVC: BaseVC {

    @IBOutlet weak var btnSwitch: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnTo: UIButton!
    @IBOutlet weak var btnFrom: UIButton!
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.callBarButtonForHome(isloggedIn:true,leftBarLabelName:"Plan_Journey".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
       self.tableview.register(UINib(nibName: "cellRecentSearch", bundle: nil), forCellReuseIdentifier: "cellRecentSearch")
        self.tableview.rowHeight = UITableView.automaticDimension
        self.tableview.estimatedRowHeight = 50
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnActionClicked(_ sender: UIButton) {
    }
    

}

extension JourneySearchVC:UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "recentsearch".LocalizedString
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellRecentSearch", for: indexPath) as! cellRecentSearch
        cell.lblTitle.text = "Dahisar Police Station to Varsova"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc =  UIStoryboard.JourneyPlannerStationListingVC()
        self.navigationController?.pushViewController(vc, animated:true)
    }
}
