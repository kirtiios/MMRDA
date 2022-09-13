//
//  FilterVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 25/08/22.
//

import UIKit

class FilterVC: UIViewController {

    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var viewDatePicker: UIView!
    @IBOutlet weak var datepicker: UIDatePicker!
    @IBOutlet weak var btnTime: UIButton!
    var completion:((String)->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 6
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        datepicker.addTarget(self, action: #selector(handleDatePickerTap), for: .editingDidBegin)
        
        
    }
    @objc func handleDatePickerTap() {
        datepicker.resignFirstResponder()
    }
    @IBAction func actionSelectTime(_ sender: Any) {
        UIView.animate(
            withDuration:0.3,
            delay: 0,
            options:.curveEaseIn,
            animations: { [weak self] in
                self?.viewDatePicker.isHidden = false
            },
            completion: nil)
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
        self.dismiss(animated:true)
    }
    
    
    
     @IBAction func actionApplyFilter(_ sender: Any) {
         
         
         let time = self.datepicker.date.toString(withFormat: "HH:mm")
         
         self.completion?(time)
         
         self.dismiss(animated:true)
         
     }
    
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
