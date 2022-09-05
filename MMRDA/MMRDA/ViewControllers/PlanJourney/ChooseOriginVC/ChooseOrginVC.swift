//
//  ChooseOrginVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 01/09/22.
//

import UIKit

class ChooseOrginVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.callBarButtonForHome(isloggedIn:true,leftBarLabelName:"choose_origin".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
    }
}


extension ChooseOrginVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"StationListCell") as? StationListCell else  { return UITableViewCell() }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.RoueDetailVC()
        self.navigationController?.pushViewController(vc!, animated:true)
        
    }
    
    
}
