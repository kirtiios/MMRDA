//
//  FareStationsListVC.swift
//  MMRDA
//
//  Created by Kirti Chavda on 24/08/22.
//

import UIKit
import Combine

class FareStationsListVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    private var  objViewModel = FareStationListViewModel()
    
    var objBindSelection:((_ obj:FareStationListModel?)->Void)?
    
    var arrStationList = [FareStationListModel](){
        didSet {
            self.tableview.reloadData()
        }
    }
    var arrSearchStationList = [FareStationListModel](){
        didSet {
            self.tableview.reloadData()
        }
    }
    @Published var isSearch = Bool()
    private var cancelBag: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.placeholder = "search".LocalizedString
        self.searchBar.delegate = self
        self.tableview.register(UINib(nibName:"cellFareStation", bundle: nil), forCellReuseIdentifier: "cellFareStation")
        self.tableview.rowHeight = UITableView.automaticDimension
        self.tableview.estimatedRowHeight = 50
        objViewModel.delegate = self
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
        var param = [String:Any]()
        param["userId"] = Helper.shared.objloginData?.intUserID
        param["deviceType"] = "IOS"
        param["deviceId"] = Helper.shared.getAndsaveDeviceIDToKeychain()
        param["authToken"] = Helper.shared.objloginData?.strAccessToken
        param["stationName"] = ""
        objViewModel.getStationList(param: param)
        
    
        $isSearch.sink { [weak self] search in
            self?.tableview.reloadData()
            }.store(in: &cancelBag)

        
    }
    

   

}
extension FareStationsListVC:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        isSearch = true
        arrSearchStationList = arrStationList.filter({ objView in
            return objView.sationname?.lowercased().contains(searchText.lowercased()) ?? false
        })
        
      
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearch = false
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
    }
    
    
}
extension FareStationsListVC:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearch ? arrSearchStationList.count : arrStationList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellFareStation", for: indexPath) as! cellFareStation
        cell.lblTitle.text =  isSearch ? arrSearchStationList[indexPath.row].sationname : arrStationList[indexPath.row].sationname
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objStation = isSearch ? arrSearchStationList[indexPath.row] : arrStationList[indexPath.row]
        objBindSelection?(objStation)
        self.navigationController?.popViewController(animated: true)
    }
}
extension FareStationsListVC:ViewcontrollerSendBackDelegate {
    func getInformatioBack<T>(_ handleData: inout T) {
        if let data = handleData as? [FareStationListModel] {
            arrStationList = data
        }
    }
}