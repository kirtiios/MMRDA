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
    
    var objTicket:myTicketList?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"generate_qr".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        
        lblAmount.text = "\(objTicket?.totaL_FARE ?? 0) Rs"
        imgQRCode.isHidden = true
        lblFromStatioName.text =  objTicket?.from_Station
        lblToStationName.text =  objTicket?.to_Station
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
         let strbase64 = objTicket?.ticketQR ?? ""
        
     
        
        var data = Data(base64Encoded: strbase64, options:[])!
        let str = String(decoding: data, as: UTF8.self)


        
        imgQRCode.image = Helper.shared.generateQRCode(from: str)
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
        imgQRCode.isHidden = false
        
    }
    
   
}
extension String {

    func base64Encoded() -> String? {
        data(using: .utf8)?.base64EncodedString()
    }

    func base64Decoded() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
