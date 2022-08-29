//
//  JourneyPlannerStationListing.swift
//  MMRDA
//
//  Created by Sandip Patel on 29/08/22.
//

import UIKit

class JourneyPlannerStationListing: BaseVC {
    
    
    @IBOutlet weak var lblDataNotFound: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callBarButtonForHome(isloggedIn:true,leftBarLabelName:"Dahisar Police Station to Varsova", isHomeScreen:false,isDisplaySOS: false)
        // Do any additional setup after loading the view.
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


extension JourneyPlannerStationListing :UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"JourneyplannerStationCell") as? JourneyplannerStationCell else  { return UITableViewCell() }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.RoueDetailVC()
        self.navigationController?.pushViewController(vc!, animated:true)
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let collectionWidth = collectionView.bounds.width
//        return CGSize(width: collectionWidth/5, height: collectionWidth/2)
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
