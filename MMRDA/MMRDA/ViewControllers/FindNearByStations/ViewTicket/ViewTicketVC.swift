//
//  ViewTicketVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 29/08/22.
//

import UIKit

class ViewTicketVC: BaseVC {

    @IBOutlet weak var lblRefID: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblRouteName: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var constTblPaymentHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"payment".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        // Do any additional setup after loading the view.
    }
}


extension ViewTicketVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"ViewTicketCell") as? ViewTicketCell else  { return UITableViewCell() }
        cell.completionBlock = {
            DispatchQueue.main.async {
                self.tblView.beginUpdates()
                self.tblView.endUpdates()
                self.tblView.reloadData()
                
            }
        }
            DispatchQueue.main.async {
                self.constTblPaymentHeight.constant = tableView.contentSize.height
                self.tblView.layoutIfNeeded()
            }
         return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
}
