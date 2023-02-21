//
//  ReminderVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 26/08/22.
//

import UIKit
import DropDown

class ReminderVC: UIViewController {

    @IBOutlet weak var btnTimeDropDown: UIButton!
    @IBOutlet weak var popupView: UIView!
    
    @IBOutlet weak var lblnotAvailable: UILabel!
    @IBOutlet weak var lblStopName: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    
    private var objViewModel = ReminderModelView()
    @IBOutlet weak var btnSave: UIButton!
    
    
    var intNotifyDurationID:Any?
    var indexpath:IndexPath?
    var routeid:Any?
    var tripID:Any?
    var completionNotifyDone:((IndexPath?) ->(Void))?
    var completionNotifyRemove:((IndexPath?) ->(Void))?
    var inputErrorMessage: Observable<String?> = Observable(nil)
    
    
    var arrNotifyList = [alarmNotifyList](){
        didSet{
            if arrNotifyList.count == 0 {
                btnTimeDropDown.isHidden = true
                lblnotAvailable.textColor = UIColor.red
                lblnotAvailable.text = "no_slots_available".localized()
                lblnotAvailable.textAlignment = .center
                btnSave.isHidden = true
            }else {
                self.btnTimeDropDown.setTitle("\(arrNotifyList.first?.intNotifyDuration ?? 0) Min", for:.normal)
                self.intNotifyDurationID = self.arrNotifyList.first?.intNotifyDurationID
                
                self.CheckNewApi()
                
            }
        }
    }
    
    var obj:Any?
    let dropDown = DropDown()
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 6
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
       
        
        objViewModel.delegate = self
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
        var param =  [String:Any]()
        param["intUserID"] = Helper.shared.objloginData?.intUserID
        
       
        if let objnew  = obj as? ArrStationData {
            lblStopName.text =  "stopname".localized() + " : " + (objnew.strStationName ?? "")
            param["tmScheduleTime"] =  objnew.strETA?.components(separatedBy:" ").last ?? 0
            
        }
        else if let objnew  = obj as? TransitPaths {
            lblStopName.text =  "stopname".localized() + " : " + (objnew.fromStationName ?? "")
            param["tmScheduleTime"] =  objnew.etaNode1?.components(separatedBy:" ").last ?? 0
        }
        
        objViewModel.getNearByNotification(param: param)
        
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func actionCancel(_ sender: Any) {
        self.dismiss(animated:true)
        
    }
    
    @IBAction func actionSave(_ sender: Any) {
        
        if arrNotifyList.count < 1 {
            return
        }
        
        var param =  [String:Any]()
        param["intUserID"] = Helper.shared.objloginData?.intUserID
        param["intTripID"] = tripID
//        intType=1 nearby bus stop
//        intType =2 plan journey

        param["intRouteID"] =  routeid
        param["intDurationID"] =  intNotifyDurationID
      
        if let objnew  = obj as? ArrStationData {
            param["intStationID"] =  objnew.intStationID
            param["tmScheduleTime"] =  objnew.strETA?.components(separatedBy:" ").last ?? 0
            param["intType"] =  1
        }
        else if let objnew  = obj as? TransitPaths {
            param["intStationID"] =  objnew.fromStationId
            param["tmScheduleTime"] =  objnew.etaNode1?.components(separatedBy:" ").last ?? 0
            param["intType"] =  2
        }

        if btnSave.titleLabel?.text == "lbl_save".LocalizedString{
              objViewModel.saveNotifyAlarm(param: param) { sucess in
                  self.dismiss(animated: true) {
                      self.completionNotifyDone?(self.indexpath)
                  }
              }
        }else if btnSave.titleLabel?.text == "remove".LocalizedString.capitalized{
            objViewModel.RemoveNotify(param: param) { Success in
                self.dismiss(animated: true) {
                    self.completionNotifyRemove?(self.indexpath)
                }
            }
        }
//        if title change {
//            RemoveNotify
//        }
        
        
       
    }
    
    @IBAction func actonOpenTimePicker(_ sender: UIButton) {
      
        let arrStringTimeSlot = arrNotifyList.map({
            return "\($0.intNotifyDuration ?? 0) min"
        })
        dropDown.dataSource  = arrStringTimeSlot
        dropDown.anchorView = sender
        dropDown.direction = .bottom
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
        dropDown.show() //7
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
            guard let _ = self else { return }
            self?.btnTimeDropDown.setTitle(item, for:.normal)
            self?.intNotifyDurationID = self?.arrNotifyList[index].intNotifyDurationID
            self?.CheckNewApi()
       
        }
        
    }
    func CheckNewApi(){
        var param =  [String:Any]()
        if let objnew  = obj as? ArrStationData {
            param["intStationID"] =  objnew.intStationID
            param["tmScheduleTime"] =  objnew.strETA?.components(separatedBy:" ").last ?? 0
            param["intType"] =  1
        }
        else if let objnew  = obj as? TransitPaths {
            param["intStationID"] =  objnew.fromStationId
            param["intStationID"] =  objnew.fromStationId
            param["tmScheduleTime"] =  objnew.etaNode1?.components(separatedBy:" ").last ?? 0
            param["intType"] =  2
        }
        param["intUserID"] = Helper.shared.objloginData?.intUserID
        param["intTripID"] = tripID
        param["intRouteID"] =  routeid
        param["intDurationID"] =  intNotifyDurationID
        objViewModel.CheckSavedNotify(param: param)
        self.objViewModel.bindDirectionDataData = { responseDict in
            print(responseDict)
            if let jsonData = try? JSONSerialization.data(withJSONObject: responseDict, options: []),
                   let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
                   let dataArray = json["data"] as? [[String: Any]],
                   let resultValue = dataArray.first?["result"] as? Int {
                    print("Result value: \(resultValue)")
                if resultValue == 2{
                    self.btnSave.setTitle("lbl_save".LocalizedString, for: .normal)
                }else if resultValue == 1 {
                    self.btnSave.setTitle("remove".LocalizedString.capitalized, for: .normal)
                }
            }
        }
    }
  

}
extension ReminderVC:ViewcontrollerSendBackDelegate {
    func getInformatioBack<T>(_ handleData: inout T) {
        if let data = handleData as? [alarmNotifyList] {
            arrNotifyList = data
        }
        
    }
}
