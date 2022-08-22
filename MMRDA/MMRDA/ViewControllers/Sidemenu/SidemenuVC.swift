//
//  SidemenuVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 22/08/22.
//

import UIKit

class SidemenuVC: UIViewController {
    
    var arrMenus = [Menu]()

    override func viewDidLoad() {
        super.viewDidLoad()
        arrMenus = [Menu(name: "Fare Table", imageName:"FareTable"),
                    Menu(name: "Time Table", imageName:"FareTable"),
                    Menu(name: "Network Map", imageName:"FareTable"),
                    Menu(name: "Near By Attraction", imageName:"FareTable"),
                    Menu(name: "City Guide", imageName:"FareTable"),
                    Menu(name: "My Rewards", imageName:"FareTable"),
                    Menu(name: "My Favourite", imageName:"FareTable"),
                    Menu(name: "Share My Location", imageName:"FareTable"),
                    Menu(name: "Chat with us", imageName:"FareTable"),
                    Menu(name: "Contact us", imageName:"FareTable"),
                    Menu(name: "FeedBack", imageName:"FareTable"),
                    Menu(name: "Helpdesk/Grievance Redressal", imageName:"FareTable"),
                    Menu(name: "Settings", imageName:"FareTable"),
                    Menu(name: "Helpline", imageName:"FareTable"),
                    Menu(name: "Logout", imageName:"FareTable"),
        ]
    }
}

// MARK: Tabelview delegate,datasource
extension SidemenuVC :UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as? MenuCell else { return UITableViewCell() }
        //cell.imgMenu.image = UIImage(named: arrMenus[indexPath.row].imageName ?? "")
        cell.lblMenuName.text = arrMenus[indexPath.row].name
        return cell
        }
    }
