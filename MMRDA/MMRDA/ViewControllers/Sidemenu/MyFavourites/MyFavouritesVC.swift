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
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var lblFavouroiteNameValue: UITextField!
    @IBOutlet weak var lblStation: UILabel!
    private var  objViewModel = FavouriteModelView()
    
    
    var arrfavList = [favouriteList]() {
        didSet {
            self.tableview.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        self.setBackButton()
        self.navigationItem.title = "myfavourites".LocalizedString
        self.setRightHomeButton()
        
        objViewModel.delegate = self
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
        objViewModel.getFavouriteList()
        
    }
    
    
    @IBAction func btnAddaction(_ sender: Any) {
        let vc = UIStoryboard.SelectFromMapVc()
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}
extension MyFavouritesVC : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
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
        return  arrfavList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"favouriteOtherPlacesCell") as! FavouriteOtherPlacesCell
        cell.selectedBackgroundView = UIView()
        cell.selectionStyle = .default
        cell.superview?.tag = indexPath.section
        cell.tag = indexPath.row
        cell.backgroundColor = .clear
        
        let objdata = arrfavList[indexPath.row]
        
        cell.lblFavouriteName.text = objdata.strlabel
        cell.lblTitleName.text = objdata.strAddress
        
        cell.favouriteDeleteAction = { indexPath in
            
            if let indexPath = indexPath {
                self.showAlertViewWithMessageCancelAndActionHandler("", message: "tv_remove_place".LocalizedString) {
                    self.objViewModel.deleteFavourite(favid: self.arrfavList[indexPath.row].intFavouriteID ?? 0)
                    self.objViewModel.favouriteDeleted = {favid in
                        self.arrfavList.remove(at: indexPath.row)
                        self.tableview.reloadData()
                    }
                }
            }
        }
        
        

        
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

extension MyFavouritesVC:ViewcontrollerSendBackDelegate {
    func getInformatioBack<T>(_ handleData: inout T) {
        if let data = handleData as? [favouriteList] {
            arrfavList = data
        }
        if let data = handleData as? [Predictions] {
           // arrPreditction = data
        }
        if let data = handleData as? [attractionSearchDisplay] {
           // arrSearchDsiplayData = data
        }
    }
}
