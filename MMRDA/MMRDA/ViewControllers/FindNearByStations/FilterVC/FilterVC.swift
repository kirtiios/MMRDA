//
//  FilterVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 25/08/22.
//

import UIKit
import DropDown

class FilterVC: UIViewController {

    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var viewDatePicker: UIView!
    @IBOutlet weak var datepicker: UIDatePicker!
    @IBOutlet weak var btnTime: UIButton!
    var completion:((Int)->Void)?
    var arrTimeList  = [filterTimeModelList]()
    let dropDown = DropDown()
    var timeID:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 6
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        datepicker.addTarget(self, action: #selector(handleDatePickerTap), for: .editingDidBegin)
        
        
        ApiRequest.shared.requestPostMethod(strurl: apiName.GetTimeSlotListFilter, params: [:], showProgress: true) { sucess, data, error in
            
            do {
                let obj = try JSONDecoder().decode(AbstractResponseModel<filterTimeModelList>.self, from: data)
                if obj.issuccess ?? false {
                    self.arrTimeList = obj.data ?? [filterTimeModelList]()
                    if self.arrTimeList.count>0 {
                        
                        if self.timeID ?? 0 > 0 {
                            let object = self.arrTimeList.first { obj1 in
                                return obj1.value == self.timeID
                            }
                            if let objData = object {
                                self.btnTime.setTitle(objData.viewValue, for:.normal)
                                self.timeID = objData.value
                            }
                        }
                        else {
                            self.btnTime.setTitle("strSelectDepart".LocalizedString, for: .normal)
                          //  self.btnTime.setTitle(self.arrTimeList.first?.viewValue, for:.normal)
                            self.timeID = self.arrTimeList.first?.value
                        }
                    }
                    
                }else {
                    if let message = obj.message {
                        self.showAlertViewWithMessage("", message: message)
                    }
                }
                
            }catch {
                print(error)
            }
            
        }
        
        
    }
    @objc func handleDatePickerTap() {
        datepicker.resignFirstResponder()
    }
    @IBAction func actionSelectTime(_ sender: UIButton) {
        
        let arrStringTimeSlot = arrTimeList.compactMap({
            return $0.viewValue
        })
        dropDown.dataSource  = arrStringTimeSlot
        dropDown.anchorView = sender
        dropDown.direction = .top
        dropDown.topOffset = CGPoint(x: 0, y: -(sender.frame.size.height)) //6
        dropDown.show() //7
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
            guard let _ = self else { return }
            self?.btnTime.setTitle(item, for:.normal)
            self?.timeID = self?.arrTimeList[index].value
           // self?.intNotifyDurationID = self?.arrNotifyList[index].intNotifyDurationID
        }
        
//        UIView.animate(
//            withDuration:0.3,
//            delay: 0,
//            options:.curveEaseIn,
//            animations: { [weak self] in
//                self?.viewDatePicker.isHidden = false
//            },
//            completion: nil)
    }
    
    @IBAction func actionDone(_ sender: Any) {
        UIView.animate(
            withDuration:0.3,
            delay: 0,
            options: .curveEaseIn,
            animations: { [weak self] in
                self?.btnTime .setTitle(self?.datepicker.date.toString(withFormat: "hh:mm a"), for: .normal)
                self?.viewDatePicker.isHidden = true
            },
            completion: nil)
    }
    
    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated:true)
    }
    
    
    @IBAction func actionCancel(_ sender: Any) {
        self.completion?(0)
        self.dismiss(animated:true)
    }
    
    
    
     @IBAction func actionApplyFilter(_ sender: Any) {
         if self.btnTime.currentTitle == "strSelectDepart".LocalizedString{
             self.showAlertViewWithMessage("APPTITLE".LocalizedString, message:"strDepartMessage".LocalizedString)
         }else{
             
             let time = self.datepicker.date.toString(withFormat: "HH:mm")
             
             self.completion?(timeID ?? 0)
             
             self.dismiss(animated:true)
         }
         
     }
    
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
