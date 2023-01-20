//
//  GenerateQRcodeVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 05/09/22.
//

import UIKit

class GenerateQRcodeVC: BaseVC {

    @IBOutlet weak var btnhelp: UIButton!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblNotes: UILabel!
    @IBOutlet weak var imgQRCode: UIImageView!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblToStationName: UILabel!
    @IBOutlet weak var lblFromStatioName: UILabel!
    
    @IBAction func btnActionHelpClicked(_ sender: UIButton) {
        
        
       
//        let obj = QRHelpVC(nibName: "QRHelpVC", bundle: nil)
//        self.navigationController?.pushViewController(obj, animated: true)
        
        let firstPresented = AlertViewVC(nibName:"AlertViewVC", bundle: nil)
        firstPresented.strMessage = "strPenalityMessage".LocalizedString
        firstPresented.isHideImage = true
        firstPresented.okButtonTitle = "ok".LocalizedString
        firstPresented.cancelButtonTitle = "cancel".localized()
        firstPresented.completionOK = {
            let vc = UIStoryboard.PaymentVC()
            vc?.objTicket = self.objTicket
            vc?.fromType  = .QRCodeGenerator
            self.navigationController?.pushViewController(vc!, animated:true)
        }
        firstPresented.modalTransitionStyle = .crossDissolve
        firstPresented.modalPresentationStyle = .overCurrentContext
        self.present(firstPresented, animated: true, completion: nil)
        
        
    }
    var objTicket:myTicketList?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"generate_qr".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        
        btnhelp.isHidden = true
        
        lblAmount.text = "\(objTicket?.totaL_FARE ?? 0) Rs"
        imgQRCode.superview?.isHidden = true
        lblFromStatioName.text =  objTicket?.from_Station
        lblToStationName.text =  objTicket?.to_Station
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
         let strbase64 = objTicket?.convertedQR ?? ""
        imgQRCode.image = Helper.shared.generateQRCode(from: strbase64)
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: imgQRCode.frame.height)
        imgQRCode.superview?.preventScreenshot(frame: frame)
    }
    
    @IBAction func actionInstructionsvC(_ sender: Any) {
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
        imgQRCode.superview?.isHidden = false
        
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
