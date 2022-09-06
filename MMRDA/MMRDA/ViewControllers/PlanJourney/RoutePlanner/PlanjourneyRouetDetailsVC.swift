//
//  PlanjourneyRouetDetailsVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 06/09/22.
//

import UIKit

class PlanjourneyRouetDetailsVC: BaseVC {

    
    var arrRoutes = [String]() {
        didSet {
            
        }
    }
    @IBOutlet weak var constTblViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.constTblViewHeight?.constant = self.tblView.contentSize.height
    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension PlanjourneyRouetDetailsVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier:"RouteDetailHeaderCell") as? RouteDetailHeaderCell else  { return UITableViewCell() }
                DispatchQueue.main.async {
                    self.tblView.layoutIfNeeded()
                }
            
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier:"JourneyPlannerRouteDetailCell") as? JourneyPlannerRouteDetailCell else  { return UITableViewCell() }
            cell.statioName = ["Abc","def","GhI"] 
            self.constTblViewHeight.constant = tableView.contentSize.height
            cell.completionBlockData = {
                DispatchQueue.main.async {
                    self.constTblViewHeight.constant = self.tblView.contentSize.height
                    self.tblView.layoutIfNeeded()
                    self.tblView.beginUpdates()
                    self.tblView.endUpdates()
                   }
            }
            cell.isShowTable = { isShow in
                self.constTblViewHeight.constant = self.tblView.contentSize.height
                self.tblView.layoutIfNeeded()
                self.tblView.beginUpdates()
                self.tblView.endUpdates()
            }
            tblView.layoutIfNeeded()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = UIStoryboard.RoueDetailVC()
//        self.navigationController?.pushViewController(vc!, animated:true)
        
    }
    
    
}
