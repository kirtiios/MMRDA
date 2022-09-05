//
//  GrivinaceSubmitVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 01/09/22.
//

import UIKit
import ACFloatingTextfield_Swift

class GrivinaceSubmitVC: UIViewController {

    @IBOutlet weak var btnUploadFile: UIButton!
    @IBOutlet weak var txtProblemDescription: ACFloatingTextfield!
    @IBOutlet weak var txtIncidentTime: ACFloatingTextfield!
    @IBOutlet weak var btnBus: UIButton!
    @IBOutlet weak var btnSubcategory: UIButton!
    @IBOutlet weak var btnCategory: UIButton!
  
    @IBOutlet weak var btnRoute: UIButton!
    @IBOutlet weak var btnVehcile: UIButton!
    @IBOutlet weak var btnMetro: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func actionTransportMediaChnage(_ sender: UIButton) {
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

    
    @IBAction func actionIncidentTime(_ sender: Any) {
    }
    @IBAction func actionSelectRoute(_ sender: Any) {
        
    }
    @IBAction func actionSelectVehcile(_ sender: Any) {
    }
    @IBAction func acrionSubCategory(_ sender: Any) {
        
    }
    @IBAction func actionSelectCategory(_ sender: Any) {
        
    }
    @IBAction func actionUploadFile(_ sender: Any) {
    }
    @IBAction func actionSubmit(_ sender: Any) {
    }
}
