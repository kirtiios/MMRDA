//
//  GenerateQRcodeVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 05/09/22.
//

import UIKit

class GenerateQRcodeVC: BaseVC {

    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblNotes: UILabel!
    @IBOutlet weak var imgQRCode: UIImageView!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblToStationName: UILabel!
    @IBOutlet weak var lblFromStatioName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"generate_qr".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        // Do any additional setup after loading the view.
    }
    @IBAction func actionInstructionsvC(_ sender: Any)
    {
        let root = UIWindow.key?.rootViewController!
        if let firstPresented = UIStoryboard.PasswordInstructionVC() {
            firstPresented.message = "ticket_qr_gen_page".LocalizedString
            firstPresented.titleName = "txtTitleInstructions".LocalizedString
            firstPresented.modalTransitionStyle = .crossDissolve
            firstPresented.modalPresentationStyle = .overCurrentContext
            root?.present(firstPresented, animated: false, completion: nil)
        }
    }
    @IBAction func actionGenerateQRCode(_ sender: Any) {
    }
}
