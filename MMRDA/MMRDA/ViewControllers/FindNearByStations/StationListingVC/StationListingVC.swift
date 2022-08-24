//
//  StationListingVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 22/08/22.
//

import UIKit

class StationListingVC: BaseVC {
    
    @IBOutlet weak var segmentViewRunning: UIView!
    @IBOutlet weak var segmentViewScheDule: UIView!
    @IBOutlet weak var lblNoDataFound: UILabel!
    @IBOutlet weak var segmentRunning: UIButton!
    @IBOutlet weak var sgementSchedule: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        initalize()
        // Do any additional setup after loading the view.
    }
    
    
    // MARK:  Action SEGMENT CHANGE
    @IBAction func actionSegmentChange(_ sender:UIButton) {
        if sender.tag == 101 { // Schedule
            segmentViewScheDule.backgroundColor = Colors.APP_Theme_color.value
            segmentViewRunning.backgroundColor = UIColor.lightGray
            sgementSchedule.setTitleColor(Colors.APP_Theme_color.value, for:.normal)
            segmentRunning.backgroundColor = UIColor.white
            segmentRunning.setTitleColor(UIColor.gray, for:.normal)
            
        }else { // Running
            segmentViewRunning.backgroundColor = Colors.APP_Theme_color.value
            segmentViewScheDule.backgroundColor = UIColor.lightGray
            segmentRunning.setTitleColor(Colors.APP_Theme_color.value, for:.normal)
            segmentRunning.backgroundColor = UIColor.white
            sgementSchedule.setTitleColor(UIColor.gray, for:.normal)
        }
        
        
    }
    
    
    @IBAction func actionbAroundTheStop(_ sender: Any) {
        
    }
    
    @IBAction func actionFavourites(_ sender: Any) {
        
    }
}


extension StationListingVC {
    private func initalize() {
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"Dahisar East", isHomeScreen:false,isDisplaySOS: false)
        self.actionSegmentChange(sgementSchedule)
        let filterButton = self.barButton2(imageName:"filter", selector: #selector(filterAction))
        self.navigationItem.rightBarButtonItems = [filterButton]
        
    }
    
    @objc func filterAction() {
        
    }
}


extension StationListingVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"StationListCell") as? StationListCell else  { return UITableViewCell() }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.RoueDetailVC()
        self.navigationController?.pushViewController(vc!, animated:true)
        
    }
    
    
}
