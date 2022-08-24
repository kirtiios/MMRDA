//
//  FareCalVC.swift
//  MMRDA
//
//  Created by Kirti Chavda on 24/08/22.
//

import UIKit
import ACFloatingTextfield_Swift

class FareCalVC: UIViewController {

    @IBOutlet weak var lblFareCharge: UILabel!
    @IBOutlet weak var textTo: ACFloatingTextfield!
    @IBOutlet weak var textFrom: ACFloatingTextfield!
    private var  objViewModel = FareCalViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        lblFareCharge.superview?.isHidden  = true
        self.navigationController?.navigationBar.backgroundColor = UIColor(patternImage:(UIImage(named:"MainBG")?.resize(withSize:CGSize(width:self.view.frame.size.width, height:44)))!)
        
        self.view.backgroundColor = UIColor.appBackground
        
        objViewModel.delegate = self
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
       

        // Do any additional setup after loading the view.
    }
    @IBAction func btnActionFareClicked(_ sender: UIButton) {
        
        
        
        var param = [String:Any]()
        param["intUserID"] = Helper.shared.objloginData?.intUserID
        param["deviceType"] = "IOS"
        param["intTicketCode"] = 118
        param["intQty"] = 1
        param["intSourceStationID"] = Helper.shared.getAndsaveDeviceIDToKeychain()
        param["intDestinationStationID"] = Helper.shared.objloginData?.strAccessToken
      
        objViewModel.getFareCalcualtet(param: param)
        
        
    }
    @IBAction func btnActionBuyClicked(_ sender: UIButton) {
    }

   

}
extension FareCalVC:UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        let objtationList = UIStoryboard.FareStationsListVC()
        self.navigationController?.pushViewController(objtationList, animated: true)
        
        return false
    }
}
extension FareCalVC:ViewcontrollerSendBackDelegate {
    func getInformatioBack<T>(_ handleData: inout T) {
        if let data = handleData as? [FareStationListModel] {
           // arrStationList = data
        }
    }
}
