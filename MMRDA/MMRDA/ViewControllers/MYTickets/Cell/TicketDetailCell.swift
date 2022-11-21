//
//  TicketDetailCell.swift
//  MMRDA
//
//  Created by Sandip Patel on 31/08/22.
//

import UIKit

typealias c2B = () ->()

class TicketDetailCell: UITableViewCell {
    
    @IBOutlet weak var lblTicketStatus: UILabel!
    @IBOutlet weak var lblTicketAmount: UILabel!
   // @IBOutlet weak var lblticketNo: UILabel!
    @IBOutlet weak var btnSideArrow: UIButton!
    @IBOutlet weak var ticketDetailCell: UIStackView!
    
    @IBOutlet weak var imgArrow: UIImageView!
    
    @IBOutlet weak var lblRouteValue: UILabel!
    //@IBOutlet weak var lblRouteNo: UILabel!
   
   // @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lbltotalAmount: UILabel!
    
    @IBOutlet weak var lblTransctionDate: UILabel!
    
    @IBOutlet weak var lblTransctionID: UILabel!
    @IBOutlet weak var lblTicketQuantityValue: UILabel!
    @IBOutlet weak var lblTransactionNumberValue: UILabel!
    @IBOutlet weak var lblTicketTypeValue: UILabel!
    @IBOutlet weak var lblServiceTypeValue: UILabel!
    @IBOutlet weak var lblExpireAtValue: UILabel!
    @IBOutlet weak var lblPurchaseAtValue: UILabel!
    @IBOutlet weak var lblDestinationValue: UILabel!
    @IBOutlet weak var lblSourceValue: UILabel!
  //  @IBOutlet weak var lblAmount: UILabel!
    
    @IBOutlet weak var lblTicketRefNumber: UILabel!
    @IBOutlet weak var lblMumbaiMetroNumber: UILabel!
    @IBOutlet weak var lblPenaltyReason: UILabel!
    
    @IBOutlet weak var lblPaymentStatus: UILabel!
    @IBOutlet weak var lblPaymentRefnumber: UILabel!
    
    @IBOutlet weak var btnHelp: UIButton!

    @IBOutlet weak var btnQRCode: UIButton!
    
    var completionBlock:c2V?
    var completionBlockData:((IndexPath)->Void)?
    
    var indexPath:IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func actionhideShowTicketDetails(_ sender: UIButton) {
        sender.isHighlighted = false
        sender.isSelected  = !sender.isSelected
        
        if sender.isSelected == true {
            ticketDetailCell.isHidden = false
            imgArrow.transform = CGAffineTransform(rotationAngle: .pi / 2)
          //  sender.setImage(UIImage(named:"dropup"), for: .normal)
           // sender.backgroundColor = .white
        }else{
            ticketDetailCell.isHidden = true
            imgArrow.transform = CGAffineTransform.identity
            //sender.setImage(UIImage(named:"sideArrow"), for: .normal)
           // sender.backgroundColor = .white
        }
        guard let cb = completionBlock else {return}
            cb()
        
    }
    func cellConfig(objdata:myTicketList,indexpath:IndexPath){
        
        indexPath = indexpath
        lblTransctionDate.text = objdata.transactionDate
        lblTransctionID.text = "\(objdata.from_Abbreviation ?? "") - \(objdata.to_Abbreviation ?? "")"
        lbltotalAmount.text = "\(objdata.totaL_FARE ?? 0) INR"
        lblExpireAtValue.text = objdata.dtExpiryDate
        lblTicketAmount.text = "\(objdata.totaL_FARE ?? 0) Rs"
        let qrcode = objdata.convertedQR ?? ""
        btnQRCode.superview?.isHidden = false
        
        lblPaymentStatus.text = objdata.strStatus
        lblPaymentRefnumber.text = objdata.strPaymentRefNo
        
//        if let strQR = objdata.convertedQR ,strQR.isEmpty == false {
//            btnQRCode.superview?.isHidden = false
//        }else {
//            btnQRCode.superview?.isHidden = true
//        }
        
        if objdata.intStatusID == 4  || objdata.intStatusID == 7 || qrcode.isEmpty {
            btnQRCode.superview?.isHidden = true
        }
        
        lblTicketStatus.textColor = UIColor(hexString:objdata.strColorCode ?? "")
//        if objdata.strPaymentStatus?.uppercased() == "PENDING" {
//            lblExpireAtValue.text = "NA"
//        }
//        else if objdata.strPaymentStatus?.uppercased() == "FAILED" {
//            lblExpireAtValue.text = "NA"
//        }
//        7    EXPIRED
//        6    REFUNDED
//        5    REFUND INITIATED
//        4    NOT BOOKED
//        3    CONFIRMED
//        2    PENDING
//        1    FAILED
        if objdata.intStatusID == 2 {
            lblExpireAtValue.text = "NA"
        }
        else if objdata.intStatusID == 1 {
            lblExpireAtValue.text = "NA"
            
        }
        
    
        lblTicketStatus.text = objdata.strPaymentStatus
        lblRouteValue.text = objdata.routeNo ?? "NA"
        lblSourceValue.text = objdata.from_Station
        lblDestinationValue.text = objdata.to_Station
        lblPurchaseAtValue.text = objdata.transaction_Date
       
        
        lblServiceTypeValue.text = objdata.busType
        lblTicketTypeValue.text = objdata.strTicketType
        
        lblTicketRefNumber.text = objdata.strDMTicketRefrenceNo
        lblMumbaiMetroNumber.text = objdata.strTicketRefrenceNo
        lblPenaltyReason.text = "Over travel"
        lblTicketQuantityValue.text = "\(objdata.ticketQty ?? 0)"
        btnQRCode.superview?.isHidden = false
        
        
       
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

    @IBAction func actionShowQR(_ sender: Any) {
        guard let cb = completionBlockData else {return}
        cb(indexPath!)
        
    }
}
