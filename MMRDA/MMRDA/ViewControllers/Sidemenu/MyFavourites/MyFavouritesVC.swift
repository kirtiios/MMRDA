//
//  MyFavouritesVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 30/08/22.
//

import UIKit

class MyFavouritesVC: BaseVC {
    
    @IBOutlet weak var addPlaceView: UIView!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var lblFavourite: UITableView!
    
    @IBOutlet weak var lblFavouroiteNameValue: UITextField!
    @IBOutlet weak var lblStation: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"myfavourites".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnAddaction(_ sender: Any) {
        let vc = UIStoryboard.SelectFromMapVc()
        self.navigationController?.pushViewController(vc!, animated: true)
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
extension MyFavouritesVC : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell : FavouriteHeaderCell = tableView.dequeueReusableCell(withIdentifier: "FavouriteHeaderCell") as! FavouriteHeaderCell
        cell.tag = section
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        if section == 0 {
           cell.lblErromSg.text = ""
           cell.lblHeaderName.text = "lbl_favourite_places".LocalizedString
        }else if section == 1 {
            cell.lblErromSg.text = ""
            cell.lblHeaderName.text = "lbl_favourite_route".LocalizedString
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier:"favouriteOtherPlacesCell") as! FavouriteOtherPlacesCell
            cell.selectedBackgroundView = UIView()
            cell.selectionStyle = .default
            cell.superview?.tag = indexPath.section
            cell.tag = indexPath.row
            cell.backgroundColor = .clear
            
            if indexPath.section == 0 {
                cell.btnDelete.isHidden = false
            }
            if indexPath.section == 1 {
                
                cell.btnDelete.isHidden = false
                
            }
            if indexPath.section == 2 {
                cell.btnDelete.isHidden = false
            }
            return cell
        
        
    
    
}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
}

