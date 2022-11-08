//
//  MpinpopupVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 07/11/22.
//

import UIKit

class MpinpopupVC: UIViewController {

    @IBOutlet weak var btnActionYesClicked: UIButton!
    var completionBlock:((Bool)->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnActionNoClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    @IBAction func btnActionYesClicked(_ sender: UIButton) {
        self.dismiss(animated:true) {
            self.completionBlock?(true)
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
