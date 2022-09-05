//
//  EditPersonalDetails.swift
//  MMRDA
//
//  Created by Sandip Patel on 02/09/22.
//

import UIKit

class EditPersonalDetails: UIViewController {
    
    @IBOutlet weak var btnImgProfile: UIButton!
    @IBOutlet weak var btnOther: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var txtFullName: UITextField!
   @IBOutlet weak var popupView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 6
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        // Do any additional setup after loading the view.
    }
    

    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated:true)
    }
    
    
    @IBAction func actionEditProfile(_ sender: Any) {
    }
    
    @IBAction func actionGenderChange(_ sender: Any) {
        
    }
    
    @IBAction func actionSaveDetails(_ sender: Any) {
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
