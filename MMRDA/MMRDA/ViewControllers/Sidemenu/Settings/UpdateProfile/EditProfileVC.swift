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
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var btnEditPersonalDetails: UIButton!
    @IBOutlet weak var txtEmailID: UITextField!
    
    @IBOutlet weak var btnChnagePassword: UIButton!
    @IBOutlet weak var txtMobileNumber: UITextField!
    
    @IBOutlet weak var btnEditLoginDetails: UIButton!
    private var  objViewModel = EditProfileModelView()
    
    var objProfile:EditProfileModel?{
        didSet {
            txtFullName.text = objProfile?.strFullName
            txtEmailID.text = objProfile?.strEmailID
            txtMobileNumber.text = objProfile?.strMobileNo
            btnMale.isSelected = false
            btnFemale.isSelected = false
            btnOther.isSelected = false
            
            if objProfile?.strGender?.trim().isEmpty ?? false == false {
                
                if  objProfile?.strGender?.lowercased() == "male".lowercased() {
                    btnMale.isSelected = true
                }
                else if  objProfile?.strGender?.lowercased() == "female".lowercased() {
                    btnFemale.isSelected = true
                }else {
                    btnOther.isSelected = true
                }
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"profile".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        objViewModel.delegate = self
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
        objViewModel.getProfileDetail()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func actionEditLoginDetails(_ sender: Any) {
        let root = UIWindow.key?.rootViewController!
        let firstPresented = UIStoryboard.EditLoginDetailsVC()!
        firstPresented.objProfile = objProfile
        firstPresented.modalTransitionStyle = .crossDissolve
        firstPresented.modalPresentationStyle = .overCurrentContext
        root?.present(firstPresented, animated: false, completion: nil)
        
    }
    @IBAction func actionEditPersonalDetails(_ sender: Any) {
        let root = UIWindow.key?.rootViewController!
        let firstPresented = UIStoryboard.EditPersonalDetailsVC()!
        firstPresented.objProfile = objProfile
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
extension EditProfileVC:ViewcontrollerSendBackDelegate {
    func getInformatioBack<T>(_ handleData: inout T) {
        if let data = handleData as? [EditProfileModel] {
            objProfile = data.first
        }
//        if let data = handleData as? [rewardDetailModel] {
//            objreward = data.first
//        }
       
    }
}
