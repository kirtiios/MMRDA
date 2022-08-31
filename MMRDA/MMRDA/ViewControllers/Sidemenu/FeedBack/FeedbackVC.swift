//
//  FeedbackVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 31/08/22.
//

import UIKit

class FeedbackVC: UIViewController {
    
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var buttonBus: UIButton!
    @IBOutlet weak var buttonMetro: UIButton!
    @IBOutlet weak var ratingView: StarRatingView!
    @IBOutlet weak var btnCategory: UIButton!
    @IBOutlet weak var lblChraCount: UILabel!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var txtRoute: UITextField!
    @IBOutlet weak var btnDateTime: UIButton!
    @IBOutlet weak var txtDescription: UITextView!
    let datePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.actionTransportMediaChnage(buttonMetro)
        setDatePicker()
        // Do any additional setup after loading the view.
    }
    
    
    func setDatePicker() {
        //Format Date
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        datePicker.maximumDate = Date()
        datePicker.minimumDate = Calendar.current.date(byAdding: .month, value: -1, to: Date())
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        } else {
            // Fallback on earlier versions
        }
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        txtDate.inputAccessoryView = toolbar
        txtDate.inputView = datePicker
        txtDate.text = ""
    }
    
    
    // SET UP DATE PICKER
    @objc func doneDatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        txtDate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    
    @IBAction func actionUploadDocument(_ sender: Any) {
        
    }
    @IBAction func actionSelectDateTime(_ sender: Any) {
        
    }
    
    @IBAction func actionTransportMediaChnage(_ sender: UIButton) {
        if sender.tag == 101 {
            buttonMetro.setImage(UIImage(named: "metroSelected"), for:.normal)
            buttonBus.setImage(UIImage(named: "busUnselected"), for:.normal)
        }else if sender.tag == 102 {
            buttonMetro.setImage(UIImage(named: "metroUnselected"), for:.normal)
          
            buttonBus.setImage(UIImage(named: "busSelected"), for:.normal)
        }
    }
    

    @IBAction func actionSelectCategory(_ sender: Any) {
        
    }
    
    @IBAction func actionSubmit(_ sender: Any) {
        
        
    }
   

}
