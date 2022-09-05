//
//  EditProfileVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 02/09/22.
//

import UIKit

class EditProfileVC: BaseVC {

    @IBOutlet weak var btnImgProfile: UIButton!
    @IBOutlet weak var btnOther: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var txtFullName: UITextField!
    
    @IBOutlet weak var btnEditPersonalDetails: UIButton!
    @IBOutlet weak var txtEmailID: UITextField!
    
    @IBOutlet weak var btnChnagePassword: UIButton!
    @IBOutlet weak var txtMobileNumber: UITextField!
    
    @IBOutlet weak var btnEditLoginDetails: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"profile".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func actionEditLoginDetails(_ sender: Any) {
        let root = UIWindow.key?.rootViewController!
        let firstPresented = UIStoryboard.EditLoginDetailsVC()!
        firstPresented.modalTransitionStyle = .crossDissolve
        firstPresented.modalPresentationStyle = .overCurrentContext
        root?.present(firstPresented, animated: false, completion: nil)
        
    }
    @IBAction func actionEditPersonalDetails(_ sender: Any) {
        let root = UIWindow.key?.rootViewController!
        let firstPresented = UIStoryboard.EditPersonalDetailsVC()!
        firstPresented.modalTransitionStyle = .crossDissolve
        firstPresented.modalPresentationStyle = .overCurrentContext
        root?.present(firstPresented, animated: false, completion: nil)
    }
    
    @IBAction func actionGenderChange(_ sender: Any) {
       
    }
    
    
     @IBAction func actionChangePassword(_ sender: Any) {
         let root = UIWindow.key?.rootViewController!
         let firstPresented = UIStoryboard.ChnagePasswordVC()!
         firstPresented.modalTransitionStyle = .crossDissolve
         firstPresented.modalPresentationStyle = .overCurrentContext
         root?.present(firstPresented, animated: false, completion: nil)
     }
     
}
