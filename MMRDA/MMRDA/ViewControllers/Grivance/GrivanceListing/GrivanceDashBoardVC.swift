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
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"grievance".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        
        actionSegmentChnaged(segmentMygrivance)

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func actionSegmentChnaged(_ sender: UIButton) {
        if sender.tag == 101 { // Schedule
            viewMyGrivance.backgroundColor = Colors.APP_Theme_color.value
            viewSubmitGrivance.backgroundColor = UIColor.lightGray
            listingGrivance.isHidden = false
            submitGrivanceView.isHidden = true
            
        }else { // Running
            viewSubmitGrivance.backgroundColor = Colors.APP_Theme_color.value
            viewMyGrivance.backgroundColor = UIColor.lightGray
            listingGrivance.isHidden = true
            submitGrivanceView.isHidden = false
            
        }
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
