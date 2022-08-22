//
//  SidemenuVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 22/08/22.
//

import UIKit

class SidemenuVC: UIViewController {
    
    @IBOutlet weak var tblSideMenu: UITableView!
    
    
   
    var arrMenus = [Menu]()
    override func viewDidLoad() {
        super.viewDidLoad()
        arrMenus = [Menu(name: "lbl_fare_table".LocalizedString, imageName:"FareTable"),
                    Menu(name: "lbl_time_table".LocalizedString, imageName:"FareTable"),
                    Menu(name: "tv_network_map".LocalizedString, imageName:"FareTable"),
                    Menu(name: "near_by_attraction".LocalizedString, imageName:"FareTable"),
                    Menu(name: "city_guide".LocalizedString, imageName:"FareTable"),
                    Menu(name: "lbl_my_rewards".LocalizedString, imageName:"FareTable"),
                    Menu(name: "myfavourites".LocalizedString, imageName:"FareTable"),
                    Menu(name: "sharemylocation".LocalizedString, imageName:"FareTable"),
                    Menu(name: "tv_chat_with_us".LocalizedString, imageName:"FareTable"),
                    Menu(name: "lbl_contact_us".LocalizedString, imageName:"FareTable"),
                    Menu(name: "feedback".LocalizedString, imageName:"FareTable"),
                    Menu(name: "lbl_heldesk".LocalizedString, imageName:"FareTable"),
                    Menu(name: "settings".LocalizedString, imageName:"FareTable"),
                    Menu(name: "helpline".LocalizedString, imageName:"FareTable"),
                    Menu(name: "signout".LocalizedString, imageName:"FareTable"),
        ]
        tblSideMenu.tableHeaderView =
        UIView(frame:
                  CGRect(x: 0, y: 0,
                         width: tblSideMenu.frame.width,
                         height: CGFloat.leastNormalMagnitude))
    }
}

// MARK: Tabelview delegate,datasource
extension SidemenuVC :UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenus.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserProfileCell") as? UserProfileCell else { return UITableViewCell() }
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as? MenuCell else { return UITableViewCell() }
            //cell.imgMenu.image = UIImage(named: arrMenus[indexPath.row].imageName ?? "")
            cell.lblMenuName.text = arrMenus[indexPath.row - 1].name
            return cell
        }
       
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
