//
//  FeedBackReviewVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 31/08/22.
//

import UIKit
import SDWebImage

enum TransportMode:Int {
    case Metro = 1
    case Bus = 2
}

class FeedBackReviewVC: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnMetro: UIButton!
    @IBOutlet weak var btnBus: UIButton!
    
    var objViewModel = FeedBackViewModel()
    
    var arrReviewList = [reviewListModel]() {
        didSet{
            tblView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     
        objViewModel.delegate = self
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
        self.actionTransportMediaChange(btnMetro)
        btnMetro.setImage(UIImage(named: "metroSelected"), for:.selected)
        btnMetro.setImage(UIImage(named: "metroUnselected"), for:.normal)
        btnBus.setImage(UIImage(named: "busUnselected"), for:.normal)
        btnBus.setImage(UIImage(named: "busSelected"), for:.selected)
        
        
        NotificationCenter.default.addObserver(forName: Notification.FeedbackUpdated, object: nil, queue: .main) { notification in
            self.btnMetro.sendActions(for: .touchUpInside)
        }
      
        // Do any additional setup after loading the view.
    }
    
    
    
    

    @IBAction func actionTransportMediaChange(_ sender: UIButton) {
        if sender == btnMetro {
            btnMetro.isSelected = true
            btnBus.isSelected = false
           
        }else if sender == btnBus {
            btnMetro.isSelected = false
            btnBus.isSelected = true
        }
        objViewModel.getReviewList(mode: btnMetro.isSelected ? TransportMode.Metro.rawValue :TransportMode.Bus.rawValue)
    }
   
    
    

}
extension FeedBackReviewVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrReviewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"ReviewCell") as? ReviewCell else  { return UITableViewCell() }
        
        let objdata = arrReviewList[indexPath.row]
        cell.lblUserName.text = objdata.strFullName ?? "Anonymous User"
        cell.lblUserComment.text = objdata.strDescription
        cell.lblFeedBackTime.text = objdata.dteFeedback?.getReviewDate()
        cell.imgUserProfile.contentMode = .scaleAspectFill
        
        cell.imgUserProfile.layer.cornerRadius = cell.imgUserProfile.layer.frame.size.height / 2
        cell.imgUserProfile.layer.masksToBounds = true
        
        if let strURl = URL(string:(objdata.strProfileURL ?? "").addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? "") {
            cell.imgUserProfile.sd_setImage(with: strURl, placeholderImage: UIImage(named: "Profile"), context:nil)
        }else {
            cell.imgUserProfile.image = UIImage(named: "Profile")
        }
        
        cell.ratingView.value = CGFloat((objdata.strRating as NSString?)?.integerValue ?? 0)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.RoueDetailVC()
        self.navigationController?.pushViewController(vc!, animated:true)
        
    }
    
    
}
extension FeedBackReviewVC:ViewcontrollerSendBackDelegate {
    func getInformatioBack<T>(_ handleData: inout T) {
        if let data = handleData as? [reviewListModel] {
           arrReviewList = data
        }
        
       
    }
}
