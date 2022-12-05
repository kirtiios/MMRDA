//
//  GrivanceDashBoardVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 01/09/22.
//

import UIKit

class GrivanceDashBoardVC: BaseVC {

    @IBOutlet weak var submitGrivanceView: UIView!
    @IBOutlet weak var listingGrivance: UIView!
    @IBOutlet weak var viewSubmitGrivance: UIView!
    @IBOutlet weak var viewMyGrivance: UIView!
    @IBOutlet weak var segmentSubmitGrivance: UIButton!
    @IBOutlet weak var segmentMygrivance: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"grievance".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        
        
        self.setBackButton()
        self.setRightHomeButton()
        self.navigationItem.title = "grievance".localized()
        
        NotificationCenter.default.addObserver(forName: Notification.GrivanceUpdated, object: nil, queue: .main) { notification in
            self.segmentMygrivance.sendActions(for: .touchUpInside)
        }
        
        
        actionSegmentChnaged(segmentMygrivance)

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func actionSegmentChnaged(_ sender: UIButton) {
        if sender.tag == 101 { // Schedule
            viewMyGrivance.backgroundColor = Colors.APP_Theme_color.value
            viewSubmitGrivance.backgroundColor = UIColor.lightGray
            listingGrivance.isHidden = false
            submitGrivanceView.isHidden = true
            segmentMygrivance.setTitleColor(Colors.APP_Theme_color.value, for: .normal)
            segmentSubmitGrivance.setTitleColor(Colors.blackColor.value, for: .normal)
            
        }else { // Running
            viewSubmitGrivance.backgroundColor = Colors.APP_Theme_color.value
            viewMyGrivance.backgroundColor = UIColor.lightGray
            listingGrivance.isHidden = true
            submitGrivanceView.isHidden = false
            
            segmentMygrivance.setTitleColor(Colors.blackColor.value, for: .normal)
            segmentSubmitGrivance.setTitleColor(Colors.APP_Theme_color.value, for: .normal)
            
        }
    }
    
    

   

}
