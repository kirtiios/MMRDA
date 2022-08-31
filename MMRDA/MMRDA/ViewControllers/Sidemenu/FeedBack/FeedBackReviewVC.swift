//
//  FeedBackReviewVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 31/08/22.
//

import UIKit

class FeedBackReviewVC: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnMetro: UIButton!
    @IBOutlet weak var btnBus: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.actionTransportMediaChange(btnMetro)
        // Do any additional setup after loading the view.
    }
    
    
    
    

    @IBAction func actionTransportMediaChange(_ sender: UIButton) {
        if sender.tag == 101 {
            btnMetro.setImage(UIImage(named: "metroSelected"), for:.normal)
            btnBus.setImage(UIImage(named: "busUnselected"), for:.normal)
        }else if sender.tag == 102 {
            btnMetro.setImage(UIImage(named: "metroUnselected"), for:.normal)
          
            btnBus.setImage(UIImage(named: "busSelected"), for:.normal)
        }
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
extension FeedBackReviewVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"ReviewCell") as? ReviewCell else  { return UITableViewCell() }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.RoueDetailVC()
        self.navigationController?.pushViewController(vc!, animated:true)
        
    }
    
    
}
