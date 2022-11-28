//
//  MyFavouritesVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 30/08/22.
//

import UIKit


enum typeOfFav:Int {
    case Location = 1
    case Station = 2
    case Route = 3
    case JourneyPlanner = 4
}

enum sectionName:Int {
    case Location = 0
    case Station = 1
    case Route = 2
    case JourneyPlanner = 3
    
}

//public static final int FavTypeLocation = 1;
//public static final int FavTypeStation = 2;
//public static final int FavTypeRoutes = 3;
///*1    Location -- GOOGLE
//2    Places -- db STATION
//3    Routes -- db routes*/


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
    
    var arrLocationfavList = [favouriteList]() {
        didSet {
            self.tableview.reloadData()
        }
    }
    
    var arrStationfavList = [favouriteList]() {
        didSet {
            self.tableview.reloadData()
        }
    }
    var arrRoutefavList = [favouriteList]() {
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
        vc?.completion = {
            self.objViewModel.getFavouriteList()
        }
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}
extension MyFavouritesVC : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == sectionName.Location.rawValue,arrLocationfavList.count > 0 {
            return 40
        }else if section == sectionName.Station.rawValue,arrStationfavList.count > 0  {
            return 40
        }else  if section == sectionName.Route.rawValue,arrRoutefavList.count > 0  {
            return 40
        }
        
        return 0.05
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell : FavouriteHeaderCell = tableView.dequeueReusableCell(withIdentifier: "FavouriteHeaderCell") as! FavouriteHeaderCell
        cell.tag = section
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        if section == sectionName.Location.rawValue {
           cell.lblErromSg.text = ""
           cell.lblHeaderName.text = "lbl_favourite_places".LocalizedString
        }else if section == sectionName.Station.rawValue {
            cell.lblErromSg.text = ""
            cell.lblHeaderName.text = "lbl_favourite_station".LocalizedString
        }else {
            cell.lblErromSg.text = ""
            cell.lblHeaderName.text = "lbl_favourite_route".LocalizedString
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == sectionName.Location.rawValue  {
            return  arrLocationfavList.count
        }
        else  if section == sectionName.Station.rawValue {
            return  arrStationfavList.count
        }else {
            return  arrRoutefavList.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier:"favouriteOtherPlacesCell") as! FavouriteOtherPlacesCell
        if indexPath.section == sectionName.Route.rawValue {
            cell = tableView.dequeueReusableCell(withIdentifier:"route") as! FavouriteOtherPlacesCell
        }
        cell.selectedBackgroundView = UIView()
        cell.selectionStyle = .default
        cell.superview?.tag = indexPath.section
        cell.tag = indexPath.row
        cell.backgroundColor = .clear
        
        let objdata:favouriteList?
        if indexPath.section == sectionName.Location.rawValue  {
            objdata =  arrLocationfavList[indexPath.row]
            cell.lblFavouriteName.isHidden = false
            if objdata?.strlabel?.trim().lowercased() == "home".LocalizedString.lowercased() {
                cell.imgIcon.image = UIImage(named:"home")
                cell.lblFavouriteName.text = objdata?.strlabel?.capitalized
            }
            else  if objdata?.strlabel?.trim().lowercased() == "work".LocalizedString.lowercased() {
                cell.imgIcon.image = UIImage(named:"Work")
                cell.lblFavouriteName.text = objdata?.strlabel?.capitalized
                
            }
            else  if objdata?.strlabel?.trim().lowercased() == "airport".LocalizedString.lowercased() {
                cell.imgIcon.image = UIImage(named:"Airport")
                cell.lblFavouriteName.text = objdata?.strlabel?.capitalized
                
            }
            else {
                cell.imgIcon.image = UIImage(named:"Other")
                cell.lblFavouriteName.text = objdata?.strlabel
            }
            cell.lblTitleName.text = objdata?.strAddress
        }
        else  if indexPath.section == sectionName.Station.rawValue {
            objdata = arrStationfavList[indexPath.row]
            cell.lblFavouriteName.isHidden = true
            cell.lblTitleName.text = objdata?.strStationName
            cell.imgIcon.image = UIImage(named:"routeWithout")
            
        }
        else  if indexPath.section == sectionName.JourneyPlanner.rawValue {
            objdata = arrRoutefavList[indexPath.row]
            let name = objdata?.strLocationLatLong?.components(separatedBy: "To")
            cell.lblFromStation.text = (name?.first ?? "")
            cell.lblToStation.text = (name?.last ?? "")
            
        }
        else {
            
            objdata = arrRoutefavList[indexPath.row]
            var name = [String]()
            if objdata?.intFavouriteTypeID == typeOfFav.JourneyPlanner.rawValue {
                name = objdata?.strLocationLatLong?.components(separatedBy: "To") ?? [String]()
            }else {
                name = objdata?.strRouteName?.components(separatedBy: "To") ?? [String]()
            }
          
            cell.lblFromStation.text = (name.first ?? "")
            cell.lblToStation.text = (name.last ?? "")
          
        }
       
        
      
     
        cell.indexptah = indexPath
        cell.favouriteDeleteAction = { indexPaths in
            
            if let indexPath = indexPaths {
                var message = "tv_remove_place".LocalizedString
                if indexPaths?.section == sectionName.Route.rawValue {
                    message = "tv_remove_routes".LocalizedString
                }else if indexPaths?.section == sectionName.Station.rawValue {
                    message = "tv_remove_station".LocalizedString
                }
                let firstPresented = AlertViewVC(nibName:"AlertViewVC", bundle: nil)
                firstPresented.strMessage = message
                firstPresented.img = UIImage(named: "removeAlert")!
                firstPresented.okButtonTitle = "ok".LocalizedString
                firstPresented.completionOK = {
                    
                    let objdata:favouriteList?
                    if indexPath.section == sectionName.Location.rawValue {
                        objdata =  self.arrLocationfavList[indexPath.row]
                    }
                    else  if indexPath.section == sectionName.Station.rawValue {
                        objdata = self.arrStationfavList[indexPath.row]
                    }else {
                        objdata = self.arrRoutefavList[indexPath.row]
                    }
                    self.objViewModel.deleteFavourite(favid: objdata?.intFavouriteID ?? 0)
                    self.objViewModel.favouriteDeleted = { favid in
                        
                        if indexPath.section == sectionName.Location.rawValue {
                            self.arrLocationfavList.remove(at: indexPath.row)
                        }
                        else  if indexPath.section == sectionName.Station.rawValue {
                            self.arrStationfavList.remove(at: indexPath.row)
                        }else {
                            self.arrRoutefavList.remove(at: indexPath.row)
                        }
                        self.tableview.reloadData()
                    }
                }
              
                firstPresented.modalTransitionStyle = .crossDissolve
                firstPresented.modalPresentationStyle = .overCurrentContext
                APPDELEGATE.topViewController!.present(firstPresented, animated: true, completion: nil)
                
//                self.showAlertViewWithMessageCancelAndActionHandler("", message: "tv_remove_place".LocalizedString) {
//
//                    let objdata:favouriteList?
//                    if indexPath.section == sectionName.Location.rawValue {
//                        objdata =  self.arrLocationfavList[indexPath.row]
//                    }
//                    else  if indexPath.section == sectionName.Station.rawValue {
//                        objdata = self.arrStationfavList[indexPath.row]
//                    }else {
//                        objdata = self.arrRoutefavList[indexPath.row]
//                    }
//
//                    self.objViewModel.deleteFavourite(favid: objdata?.intFavouriteID ?? 0)
//                    self.objViewModel.favouriteDeleted = { favid in
//
//                        if indexPath.section == sectionName.Location.rawValue {
//                            self.arrLocationfavList.remove(at: indexPath.row)
//                        }
//                        else  if indexPath.section == sectionName.Station.rawValue {
//                            self.arrStationfavList.remove(at: indexPath.row)
//                        }else {
//                            self.arrRoutefavList.remove(at: indexPath.row)
//                        }
//
//                        self.tableview.reloadData()
//                    }
//                }
            }
        }
        
        

        
//        if indexPath.section == 0 {
//            cell.btnDelete.isHidden = false
//        }
//        if indexPath.section == 1 {
//
//            cell.btnDelete.isHidden = false
//
//        }
//        if indexPath.section == 2 {
//            cell.btnDelete.isHidden = false
//        }
        return cell
        
        
        
        
    }

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
}

extension MyFavouritesVC:ViewcontrollerSendBackDelegate {
    func getInformatioBack<T>(_ handleData: inout T) {
        if let data = handleData as? [favouriteList] {
            
            arrLocationfavList = data.filter({ obj in
                return obj.intFavouriteTypeID == typeOfFav.Location.rawValue
            })
            arrRoutefavList = data.filter({ obj in
                return obj.intFavouriteTypeID == typeOfFav.Route.rawValue || obj.intFavouriteTypeID == typeOfFav.JourneyPlanner.rawValue
            })
            arrStationfavList = data.filter({ obj in
                return obj.intFavouriteTypeID == typeOfFav.Station.rawValue
            })
            
           
        }
       
    }
}
