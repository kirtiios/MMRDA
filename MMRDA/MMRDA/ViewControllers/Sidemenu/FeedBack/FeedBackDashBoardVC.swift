//
//  FeedBackDashBoardVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 31/08/22.
//

import UIKit

class FeedBackDashBoardVC: BaseVC {
    
    @IBOutlet weak var segmentFeedBack: UIButton!
    @IBOutlet weak var viewFeedBack: UIView!
    @IBOutlet weak var segmentReview: UIButton!
    @IBOutlet weak var feedBackContainerView: UIView!
    @IBOutlet weak var reviewContainerView: UIView!
    @IBOutlet weak var viewReview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"feedback".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        actionSegmentChange(segmentFeedBack)
        
       
        NotificationCenter.default.addObserver(forName: Notification.FeedbackUpdated, object: nil, queue: .main) { notification in
            self.segmentReview.sendActions(for: .touchUpInside)
        }

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func actionSegmentChange(_ sender: UIButton) {
        if sender.tag == 101 { // Schedule
            viewFeedBack.backgroundColor = Colors.APP_Theme_color.value
            viewReview.backgroundColor = UIColor.lightGray
            segmentFeedBack.setTitleColor(Colors.APP_Theme_color.value, for:.normal)
            segmentReview.setTitleColor(UIColor.gray, for:.normal)
            feedBackContainerView.isHidden = false
            reviewContainerView.isHidden = true
            
        }else { // Running
            viewReview.backgroundColor = Colors.APP_Theme_color.value
            viewFeedBack.backgroundColor = UIColor.lightGray
            segmentReview.setTitleColor(Colors.APP_Theme_color.value, for:.normal)
            segmentFeedBack.setTitleColor(UIColor.gray, for:.normal)
            feedBackContainerView.isHidden = true
            reviewContainerView.isHidden = false
        }
    }
    
    
}
