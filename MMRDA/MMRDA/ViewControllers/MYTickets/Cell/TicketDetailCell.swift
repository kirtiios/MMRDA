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
        
        lblTicketAmount.text = "\(objdata.totaL_FARE ?? 0) Rs"
        
        if objdata.strPaymentStatus?.uppercased() == "PENDING" {
            lblTicketStatus.textColor = UIColor(hexString: "dba800")
        }
        else if objdata.strPaymentStatus?.uppercased() == "FAILED" {
            lblTicketStatus.textColor = UIColor.red
        }
        else {
            lblTicketStatus.textColor = UIColor.greenColor
        }
        
        
        lblTicketStatus.text = objdata.strPaymentStatus
        
        lblRouteValue.text = objdata.routeNo ?? "NA"
        
        lblSourceValue.text = objdata.from_Station
        lblDestinationValue.text = objdata.to_Station
        lblPurchaseAtValue.text = objdata.transaction_Date
        lblExpireAtValue.text = objdata.dtExpiryDate
        
        lblServiceTypeValue.text = objdata.busType
        lblTicketTypeValue.text = objdata.strPassengerType
        
        lblTransactionNumberValue.text = objdata.strTicketRefrenceNo
        lblTicketQuantityValue.text = "\(objdata.ticketQty ?? 0)"
        btnQRCode.superview?.isHidden = false
        
        if let strQR = objdata.ticketQR ,strQR.isEmpty == false {
            btnQRCode.superview?.isHidden = false
        }else {
            btnQRCode.superview?.isHidden = true
        }
       
        
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
