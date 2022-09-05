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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"mytickets".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
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
        firstPresented.modalTransitionStyle = .crossDissolve
        firstPresented.modalPresentationStyle = .overCurrentContext
        root?.present(firstPresented, animated: false, completion: nil)
    }
    
    
    
    @IBAction func actionSegmentChange(_ sender: UIButton) {
        if sender.tag == 102 { // Schedule
            viewHistory.backgroundColor = Colors.APP_Theme_color.value
            viewRecent.backgroundColor = UIColor.lightGray
            segmentHistory.setTitleColor(Colors.APP_Theme_color.value, for:.normal)
            segementRecent.setTitleColor(UIColor.black, for:.normal)
            
            
        }else { // Running
            viewRecent.backgroundColor = Colors.APP_Theme_color.value
            viewHistory.backgroundColor = UIColor.lightGray
            segementRecent.setTitleColor(Colors.APP_Theme_color.value, for:.normal)
            segmentHistory.setTitleColor(UIColor.black, for:.normal)
            
        }
        
    }
    
}



extension MyticketsVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"TicketDetailCell") as? TicketDetailCell else  { return UITableViewCell() }
        cell.completionBlock = {
            DispatchQueue.main.async {
                self.tblView.beginUpdates()
                self.tblView.endUpdates()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    
}
