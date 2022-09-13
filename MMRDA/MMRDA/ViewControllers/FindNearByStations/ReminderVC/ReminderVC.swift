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
    private var objViewModel = ReminderModelView()
    @IBOutlet weak var btnTime: UIButton!
    var obj:ArrStationData?
    let dropDown = DropDown()
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 6
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        lblStopName.text = obj?.strStationName
        
        objViewModel.delegate = self
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
        
        
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
  

}
extension ReminderVC:ViewcontrollerSendBackDelegate {
    func getInformatioBack<T>(_ handleData: inout T) {
        if let data = handleData as? [StationListModel] {
              //  arrStationList = data
        }
        
    }
}
