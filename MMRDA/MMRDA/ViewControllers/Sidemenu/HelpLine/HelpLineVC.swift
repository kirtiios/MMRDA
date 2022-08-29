//
//  HelpLineVC.swift
//  MMRDA
//
//  Created by Kirti Chavda on 29/08/22.
//

import UIKit

enum helpLineItem:String,CaseIterable {
    case controlRoom = "str_controlRoom"
    case ERSS = "str_ERSS"
    case Police = "str_Police"
    case ambulance = "str_Ambulance"
    case fire = "str_Fire"
    
    var number:String? {
        switch(self) {
        case.controlRoom:
            return "18008890808"
        case .ERSS:
            return nil
        case .Police:
            return nil
        case .ambulance:
            return nil
        case .fire:
            return nil
        }
    }
    
    
}

class HelpLineVC: BaseVC {

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackButton()
        self.setRightHomeButton()
        self.navigationItem.title = sidemenuItem.helpline.rawValue.LocalizedString
        self.tableview.register(UINib(nibName: "cellHelpLine", bundle: nil), forCellReuseIdentifier: "cellHelpLine")
        // Do any additional setup after loading the view.
    }


  

}
extension HelpLineVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return helpLineItem.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellHelpLine") as? cellHelpLine else { return UITableViewCell() }
        //cell.imgMenu.image = UIImage(named: arrMenus[indexPath.row].imageName ?? "")
        cell.lblName.text = helpLineItem.allCases[indexPath.row].rawValue.LocalizedString
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let objNew = helpLineItem.allCases[indexPath.row]
        if objNew.number == nil {
            self.showAlertViewWithMessage("", message: "contact_numbers_not_found".LocalizedString)
        }else {
            guard let url = URL(string: "telprompt://\(objNew.number ?? "")"),
                  UIApplication.shared.canOpenURL(url) else {
                      return
                  }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
       
    }
}
