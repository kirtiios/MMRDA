//
//  SelectFromMapVc.swift
//  MMRDA
//
//  Created by Sandip Patel on 30/08/22.
//

import UIKit
import GoogleMaps

class SelectFromMapVc: BaseVC {
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var lblLocatioName: UILabel!
    
    @IBOutlet weak var infoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"myfavourites".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionInfo(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            self.setView(view: infoView, hidden:false)
        }else{
            self.setView(view: infoView, hidden:true)
        }
        
    }
    
    @IBAction func actionclose(_ sender: Any) {
        self.setView(view: infoView, hidden:true)
        infoButton.isSelected = false
    }
    @IBAction func actionPinTouch(_ sender: Any) {
        let root = UIWindow.key?.rootViewController!
        if let firstPresented = UIStoryboard.SaveLocationVC() {
            firstPresented.modalTransitionStyle = .crossDissolve
            firstPresented.modalPresentationStyle = .overCurrentContext
            root?.present(firstPresented, animated: false, completion: nil)
        }
        
    }
    
    
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
    }
}
