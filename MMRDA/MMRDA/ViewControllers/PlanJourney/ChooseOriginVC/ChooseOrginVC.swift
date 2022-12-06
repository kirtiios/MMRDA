//
//  ChooseOrginVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 01/09/22.
//

import UIKit
import DropDown

class ChooseOrginVC: BaseVC {
    
    @IBOutlet weak var textSearch: UITextField!
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var lblNoFav: UILabel!
    @IBOutlet weak var lblNoFavRecent: UILabel!
    @IBOutlet weak var tableview: UITableView!
    var isSearchActive  = false
    private var searchTimer: Timer?
    lazy var dropDown = DropDown()
    private var  objViewModel = JourneyPlannerModelView()
    var arrPreditction = [Predictions]() {
        didSet {
            self.showDropDownData()
        }
    }
    var arrRecentData = [RecentPlaneStation]()
        
    var completionBlock:((planeStation)->Void)?
    var arrfavList = [favouriteList]() {
        didSet {
            self.collectionview.reloadData()
        }
    }
    var objParent:JourneySearchVC?
    var arrSearchDsiplayData = [attractionSearchDisplay]() {
        didSet {
            if let objdata = arrSearchDsiplayData.first {
                let obj = planeStation(locationname: objdata.strAddressName ?? "", latitude: objdata.decPlaceLat ??  0, longitude: objdata.decPlaceLong ?? 0)
                self.completionBlock?(obj)
                self.navigationController?.popViewController(animated: true)
            }

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.callBarButtonForHome(isloggedIn:true,leftBarLabelName:"choose_origin".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        textSearch.addTarget(self, action: #selector(textChanged(_:)), for:.editingChanged)
        self.tableview.register(UINib(nibName: "cellRecentSearch", bundle: nil), forCellReuseIdentifier: "cellRecentSearch")
        objViewModel.delegate = self
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
        objViewModel.getFavouriteList()
        LocationManager.sharedInstance.getCurrentLocation { success, location in
            if success {
                
            }
        }
    }
    func showDropDownData(){
        dropDown.anchorView = textSearch
       
        let array = arrPreditction.compactMap({ objList in
            return objList.description
        })
        dropDown.dataSource = array
        if array.count < 1 && textSearch.text?.count ?? 0 > 0 {
            dropDown.dataSource = ["locationotfound".localized()]
        }
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            cell.optionLabel.numberOfLines = 0
        }
        dropDown.bottomOffset = CGPoint(x: 0, y:textSearch?.frame.height ?? 0)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            textSearch.text = item
            if item  == "locationotfound".localized() {
                textSearch.text = ""
                return
            }
            
            if LocationManager.sharedInstance.currentLocation.coordinate.latitude == 0 {
                return
            }
            let obj = arrPreditction[index]
            var param = [String:Any]()
            param["strPlaceId"] = obj.place_id
            param["placeTypeId"] = 10
            param["strPlaceName"] = obj.description?.components(separatedBy:",").first
            param["strAddressName"] = obj.description
            param["decCurrentLat"] =  LocationManager.sharedInstance.currentLocation.coordinate.latitude
            param["decCurrentLong"] =  LocationManager.sharedInstance.currentLocation.coordinate.longitude
            self.objViewModel.getAttractionClickedData(param: param)
            isSearchActive = true
           // self.tableview.reloadData()
            textSearch.resignFirstResponder()
        }
        dropDown.show()
    }
    @objc func textChanged(_ textField: UITextField){
        if let searchTimer = searchTimer {
            searchTimer.invalidate()
        }
        isSearchActive = false
        searchTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(gotoApiSearch(_:)), userInfo:nil, repeats: false)
        if textSearch.text?.trim().isEmpty ?? false {
            isSearchActive = false
            //self.tableview.reloadData()
        }
    }
    @objc func gotoApiSearch(_ textField: UITextField) {
        
        if textSearch.text?.count ?? 0 >= 3 {
            var param = [String:Any]()
              param["PlaceTypeId"] = 10
            param["strPlaceName"] =  textSearch.text
            self.objViewModel.getAttractionSearch(param: param)
        }
        
    }
    
    @IBAction func actionSelectFromMap(_ sender: Any) {
        let vc = UIStoryboard.SelectFromMapVc()
        vc?.isFromJourneyPlanner = true
        vc?.completion = {
            self.objViewModel.getFavouriteList()
        }
        vc?.completionBlock = { obj in
            self.completionBlock?(obj)
            self.navigationController?.popViewController(animated: true)
        }
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}


extension ChooseOrginVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRecentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellRecentSearch", for: indexPath) as! cellRecentSearch
        let objdata = arrRecentData[indexPath.row]
        cell.lblFromStation.text = objdata.from_locationname
        cell.lblToStation.text = objdata.to_locationname
        lblNoFavRecent.isHidden = true
        if arrRecentData.count < 1 {
            lblNoFavRecent.isHidden = false
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell : FavouriteHeaderCell = tableView.dequeueReusableCell(withIdentifier: "FavouriteHeaderCell") as! FavouriteHeaderCell
        cell.tag = section
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.lblHeaderName.text = "recentsearch".LocalizedString
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let objData = arrRecentData[indexPath.row]
        
        objParent?.objFrom = planeStation(locationname: objData.from_locationname, latitude: objData.from_latitude, longitude:objData.from_longitude)
        objParent?.objTo = planeStation(locationname:objData.to_locationname, latitude: objData.to_latitude, longitude:objData.to_longitude)
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    
}
extension ChooseOrginVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        lblNoFav.isHidden = true
        if self.arrfavList.count < 1 {
            lblNoFav.isHidden = false
        }
        return self.arrfavList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"FavouriteCellCollectionViewCell", for:indexPath) as! FavouriteCellCollectionViewCell
        let objdata = arrfavList[indexPath.row]
        cell.lblFavouritesName.text = arrfavList[indexPath.row].strlabel ?? " "
        
        if objdata.strlabel?.lowercased() == "home".LocalizedString.lowercased() {
            cell.btnPlaceImage .setImage(UIImage(named:"home"), for: .normal)
        }
        else  if objdata.strlabel?.lowercased() == "work".LocalizedString.lowercased() {
            cell.btnPlaceImage .setImage(UIImage(named:"Work"), for: .normal)
        }
        else  if objdata.strlabel?.lowercased() == "airport".LocalizedString.lowercased() {
            cell.btnPlaceImage .setImage(UIImage(named:"Airport"), for: .normal)
        }
        else {
            cell.btnPlaceImage .setImage(UIImage(named:"addFavList"), for: .normal)
        }
        
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:UIScreen.main.bounds.size.width/4.5, height:collectionView.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let objdata = arrfavList[indexPath.row]
        let obj = planeStation(locationname: objdata.strAddress ?? "", latitude: objdata.decLocationLat ??  0, longitude: objdata.decLocationLong ?? 0)
        self.completionBlock?(obj)
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
extension ChooseOrginVC:ViewcontrollerSendBackDelegate {
    func getInformatioBack<T>(_ handleData: inout T) {
        if let data = handleData as? [favouriteList] {
            arrfavList = data.filter({ obj in
                return obj.intFavouriteTypeID == typeOfFav.Location.rawValue
            })
          
        }
        if let data = handleData as? [Predictions] {
            arrPreditction = data
        }
        if let data = handleData as? [attractionSearchDisplay] {
            arrSearchDsiplayData = data
        }
    }
}
