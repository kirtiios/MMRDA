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
    
    var objFareReponse:FareCalResponseModel?{
        didSet {
            lblFareCharge.superview?.isHidden = false
            lblFareCharge.text = "₹\(objFareReponse?.baseFare ?? 0)"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        lblFareCharge.superview?.isHidden  = true
       // self.navigationController?.navigationBar.backgroundColor = UIColor(patternImage:(UIImage(named:"MainBG")?.resize(withSize:CGSize(width:self.view.frame.size.width, height:44)))!)
        
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
        objViewModel.getFareCalcualtet()
        
    }
    @IBAction func btnActionBuyClicked(_ sender: UIButton) {
    }

   

}
extension FareCalVC:UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        let objtationList = UIStoryboard.FareStationsListVC()
        objtationList.objBindSelection = { obj in
            if textField == self.textFrom {
                
                textField.text = obj?.sationname
                self.objViewModel.objFromFareStation = obj
            }
            
            if textField == self.textTo {
                textField.text = obj?.sationname
                self.objViewModel.objTOFareStation = obj
            }
            
        }
        self.navigationController?.pushViewController(objtationList, animated: true)
        
        return false
    }
}
extension FareCalVC:ViewcontrollerSendBackDelegate {
    func getInformatioBack<T>(_ handleData: inout T) {
        if let data = handleData as? [FareCalResponseModel] {
            objFareReponse = data.first
        }
    }
}
