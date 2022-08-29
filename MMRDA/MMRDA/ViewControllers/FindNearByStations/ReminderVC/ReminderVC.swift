//
//  ReminderVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 26/08/22.
//

import UIKit
import DropDown

class ReminderVC: UIViewController {

    @IBOutlet weak var popupView: UIView!
    
    @IBOutlet weak var lblStopName: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var btnTime: UIButton!
    let dropDown = DropDown()
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 6
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func actionCancel(_ sender: Any) {
        self.dismiss(animated:true)
        
    }
    
    @IBAction func actionSave(_ sender: Any) {
        self.dismiss(animated:true)
    }
    
    @IBAction func actonOpenTimePicker(_ sender: UIButton) {
        let arrTimeSlot = Array(1...30)
        let arrStringTimeSlot = arrTimeSlot.map({
            return "\($0) min"
        })
        dropDown.dataSource  = arrStringTimeSlot
        dropDown.anchorView = sender
        dropDown.direction = .bottom
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
        dropDown.show() //7
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
            guard let _ = self else { return }
            let selectedTimeSlot = arrStringTimeSlot.filter({$0 == item}).first
            self?.btnTime.setTitle(selectedTimeSlot, for:.normal)
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
