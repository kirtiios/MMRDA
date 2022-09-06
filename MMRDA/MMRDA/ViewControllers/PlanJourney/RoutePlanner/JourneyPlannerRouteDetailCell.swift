//
//  JourneyPlannerRouteDetailCell.swift
//  MMRDA
//
//  Created by Sandip Patel on 06/09/22.
//

import UIKit

class JourneyPlannerRouteDetailCell: UITableViewCell {
    
    var completionBlockData:c2B?
    var isShowTable: ((_ isHidden: Bool) -> ())?
    
    var statioName = [String](){
        didSet{
            self.reloadData()
        }
    }
    @IBOutlet weak var consttblviewHeight: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tblView.delegate = self
        tblView.dataSource = self
        
    }

    
    func reloadData() {
        self.tblView.reloadData()
        self.tblView.layoutIfNeeded()
        self.contentView.setNeedsLayout()
        if let cb = completionBlockData {
            cb()
        }

    }
    
    @IBAction func actionShowHideRoutes(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
           tblView.isHidden = false
            consttblviewHeight.constant = tblView.contentSize.height
            self.reloadData()
        }else{
            tblView.isHidden = true
            consttblviewHeight.constant = 0
            self.reloadData()
            
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension JourneyPlannerRouteDetailCell :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statioName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"JourneyPlannerShowRoutesCell") as? JourneyPlannerShowRoutesCell else  { return UITableViewCell() }
            cell.lblFromStatioName.text = statioName[indexPath.row]
            if tblView.isHidden == true {
                consttblviewHeight.constant = 0
            }else{
                consttblviewHeight.constant = tblView.contentSize.height
            }
            self.tblView.layoutIfNeeded()
            self.contentView.layoutSubviews()
            if let cb = completionBlockData {
                cb()
            }
            return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = UIStoryboard.RoueDetailVC()
//        self.navigationController?.pushViewController(vc!, animated:true)
        
    }
    
    
}
