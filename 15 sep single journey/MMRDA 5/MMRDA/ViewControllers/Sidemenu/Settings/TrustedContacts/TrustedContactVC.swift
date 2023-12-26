//
//  TrustedContactsVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 02/09/22.
import UIKit
import ContactsUI


typealias tapToTrustedConatcs = () ->()

class TrustedContactVC: BaseVC {
    @IBOutlet weak var btnAdd: UIButton!
    var contactStore = CNContactStore()
    var isPresent:Bool = false
    var arrContact = [SOSContact](){
        didSet {
            if arrContact.count > 0 {
                self.sosTableView.isHidden = false
                self.lblNoDataFound.isHidden = true
            }else{
                self.sosTableView.isHidden = true
                self.lblNoDataFound.isHidden = false
                
            }
        }
    }
    var isFromSettings:Bool = false
    var conactsData:tapToTrustedConatcs?
    @IBOutlet weak var lblNoDataFound: UILabel!
    @IBOutlet weak var sosTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnAdd.cornerRadius = self.btnAdd.frame.size.height/2
        self.btnAdd.clipsToBounds = true
        self.btnAdd.layer.masksToBounds = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let completeDetail = self.conactsData {
            completeDetail()
        }else{
            
        }
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        intiialize()
       // self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "appNavColor"), for:.default)
        //self.view.backgroundColor = ThemeManager.currentTheme().backgroundColor
    }
    @IBAction func open_Contact_Picker(_ sender: Any) {
        self.requestAccess { (success : Bool) in
                if success == true {
                    if self.arrContact.count < 10 {
                    DispatchQueue.main.async {
                        let contactPicker = CNContactPickerViewController()
                        contactPicker.delegate = self
                        contactPicker.displayedPropertyKeys =
                            [CNContactGivenNameKey
                                , CNContactPhoneNumbersKey]
                        self.present(contactPicker, animated: true, completion: nil)
                    }
                    
                    }else{
                        DispatchQueue.main.async {
                            self.showAlertViewWithMessage("APPTITLE".LocalizedString, message: "max_trusted_contacts".LocalizedString)
                        }
                    }
                
                }
          }
    }
}

extension TrustedContactVC : CNContactPickerDelegate, SOSContactDelegate {

    func intiialize() {
        loadContact()
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"trustedcontacts".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        let Home = self.barButton2(imageName:"ic_add", selector: #selector(mpoveToHome))
        self.navigationItem.rightBarButtonItems = [Home]
    }
    
    
    @objc func mpoveToHome() {
//        self.navigationController?.popToRootViewController(animated:true)
        
        self.requestAccess { (success : Bool) in
                if success == true {
                    if self.arrContact.count < 10 {
                    DispatchQueue.main.async {
                        let contactPicker = CNContactPickerViewController()
                        contactPicker.delegate = self
                        contactPicker.displayedPropertyKeys =
                            [CNContactGivenNameKey
                                , CNContactPhoneNumbersKey]
                        self.present(contactPicker, animated: true, completion: nil)
                    }
                    
                    }else{
                        DispatchQueue.main.async {
                            self.showAlertViewWithMessage("APPTITLE".LocalizedString, message: "max_trusted_contacts".LocalizedString)
                        }
                    }
                
                }
          }

        
    }
    
    @objc func didTapCancelButton(sender: AnyObject){
       
        
    }
    
    @objc func didTapAddButton(sender: AnyObject){
        if self.arrContact.count < 10 {
            self.requestAccess { (success : Bool) in
                    if success == true {
                        DispatchQueue.main.async {
                            let contactPicker = CNContactPickerViewController()
                            contactPicker.delegate = self
                            contactPicker.displayedPropertyKeys =
                                [CNContactGivenNameKey
                                    , CNContactPhoneNumbersKey]
                            self.present(contactPicker, animated: true, completion: nil)
                        }
                        
                    }
                }
        }else{
            DispatchQueue.main.async {
            self.showAlertViewWithMessage("APPTITLE".LocalizedString, message: "max_trusted_contacts".LocalizedString)
            }
        }
        
    }
    
    
    func insert(contact: SOSContact) {
        var contactExists: Bool = false
        for stdnt in arrContact {
            if stdnt.SOSContact_Name == contact.SOSContact_Name && stdnt.SOSContact_Phone == contact.SOSContact_Phone && stdnt.SOSContact_ContactId == contact.SOSContact_ContactId {
                contactExists = true
                break
            }
        }
        
        if !contactExists {
            self.arrContact.append(contact)
            do{
                let contactValues = try  NSKeyedArchiver.archivedData(withRootObject: self.arrContact, requiringSecureCoding: true)
                UserDefaults.standard.set(contactValues, forKey:"contactNo")
                UserDefaults.standard.synchronize()
            }catch (let error){
                print("ERROR IS %@",error)
            }
            
            NotificationCenter.default.post(name: Notification.updateEmergencyContactNumber, object: nil, userInfo: nil)
            self.reloadTable() // Reload Table
        }else {
            self.showAlertViewWithMessage("", message: "contactexist".localized())
        }
    }
    
    func loadContact() {
        do {
            
            if let properyAsData = UserDefaults.standard.object(forKey:"contactNo") as? Data {
                if let placesArray = try (NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(properyAsData) as? [SOSContact] ) {
                    self.arrContact.removeAll()
                    for contact in placesArray {
                        let objContact : SOSContact = SOSContact.init(contactId: contact.SOSContact_ContactId, name: contact.SOSContact_Name, phone: contact.SOSContact_Phone.digits)
                        self.arrContact.append(objContact)
                    }
                    self.reloadTable() // Reload Table
                        
                    
                }
            }else{
                self.arrContact.removeAll()
            }
        }catch (let error){
            print("Failed to convert propert to Data : \(error.localizedDescription)")
            
        }
        
    }
    func reloadTable(){
        self.sosTableView.delegate = self
        self.sosTableView.dataSource = self
        self.sosTableView.reloadData()
    }
    
    func deleteContactTapped(at index: IndexPath) {
        self.showAlertViewWithMessageCancelAndActionHandler("APPTITLE".LocalizedString, message:"txtErrorDeleteContact".LocalizedString, actionHandler: {
            print("button tapped at index:\(index)")
            self.arrContact.remove(at: index.row)
            do{
                let contactValues = try  NSKeyedArchiver.archivedData(withRootObject: self.arrContact, requiringSecureCoding: true)
                UserDefaults.standard.set(contactValues, forKey:"contactNo")
                UserDefaults.standard.synchronize()
            }catch (let error){
                print("ERROR IS %@",error)
            }
            self.reloadTable() // Reload Table
        })
       
    }
    func contactPicker(_ picker: CNContactPickerViewController,
                       didSelect contactProperty: CNContactProperty) {

    }

    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        // You can fetch selected name and number in the following way

        // user phone number
        
        picker.dismiss(animated: true)
        let userPhoneNumbers:[CNLabeledValue<CNPhoneNumber>] = contact.phoneNumbers
        if userPhoneNumbers.count > 0{
                let number = userPhoneNumbers[0].value
                let firstPhoneNumber:CNPhoneNumber = number
                let primaryPhoneNumberStr:String = firstPhoneNumber.stringValue
                print(primaryPhoneNumberStr)
                if contact.phoneNumbers.count > 0 {
                    let objSOS : SOSContact = SOSContact.init(contactId: contact.identifier, name: "\(contact.givenName) \(contact.familyName)", phone: primaryPhoneNumberStr.digits)
                    self.insert(contact: objSOS)
                }
            
        }
    }

    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {

    }
    
    
    func requestAccess(completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            completionHandler(true)
        case .denied:
            showSettingsAlert(completionHandler)
        case .restricted, .notDetermined:
            contactStore.requestAccess(for: .contacts) { granted, error in
                if granted {
                    completionHandler(true)
                } else {
                    DispatchQueue.main.async {
                        self.showSettingsAlert(completionHandler)
                    }
                }
            }
        @unknown default:
            completionHandler(false)
        }
    }
    
    private func showSettingsAlert(_ completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        let alert = UIAlertController(title: nil, message: "This app requires access to Contacts to proceed. Would you like to open settings and grant permission to contacts?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Open Settings", style: .default) { action in
            completionHandler(false)
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(settingsUrl)
                }
            }
//            UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
        })
        alert.addAction(UIAlertAction(title: "cancel".LocalizedString, style: .cancel) { action in
            completionHandler(false)
        })
        present(alert, animated: true)
    }
    
}

extension TrustedContactVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrContact.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"ContactCell") as! ContactCell
        cell.selectedBackgroundView = UIView()
       // cell.contentView.backgroundColor =  ThemeManager.currentTheme().backgroundColor
        if arrContact[indexPath.row].SOSContact_Name.removeWhitespaceInString() == "" {
            cell.lblName.text =  arrContact[indexPath.row].SOSContact_Phone
        }else{
            cell.lblName.text =  arrContact[indexPath.row].SOSContact_Name
        }
       
        cell.tapCallback = {
            self.arrContact.remove(at: indexPath.row)
            do{
                let contactValues = try  NSKeyedArchiver.archivedData(withRootObject: self.arrContact, requiringSecureCoding: true)
                UserDefaults.standard.set(contactValues, forKey:"contactNo")
                UserDefaults.standard.synchronize()
            }catch (let error){
                print("ERROR IS %@",error)
            }
            NotificationCenter.default.post(name: Notification.updateEmergencyContactNumber, object: nil, userInfo: nil)
            self.reloadTable()
//            self.showAlertViewWithMessageCancelAndActionHandler("APPTITLE".LocalizedString, message:"txtErrorDeleteContact".LocalizedString, actionHandler: {
//                 // Reload Table
//            })
          
        }
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
