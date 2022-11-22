//
//  ViewTicketCell.swift
//  MMRDA
//
//  Created by Sandip Patel on 29/08/22.
//

import UIKit

class ViewTicketCell: UITableViewCell {
    
    @IBOutlet weak var lblTicketQuantityValue: UILabel!
    @IBOutlet weak var lblTransactionNumberValue: UILabel!
    @IBOutlet weak var lblTicketTypeValue: UILabel!
    @IBOutlet weak var lblServiceTypeValue: UILabel!
    @IBOutlet weak var lblExpireAtValue: UILabel!
    @IBOutlet weak var lblPurchaseAtValue: UILabel!
    @IBOutlet weak var lblDestinationValue: UILabel!
    @IBOutlet weak var lblSourceValue: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblRouteNo: UILabel!
    @IBOutlet weak var imgQRCode: UIImageView!
    @IBOutlet weak var lblFromStatioName: UILabel!
    @IBOutlet weak var viewTicketDetails: UIStackView!
    @IBOutlet weak var viewQRCode: UIView!
    @IBOutlet weak var lblTicketQRNotFound: UILabel!
    @IBOutlet weak var lblToStatioName: UILabel!
    @IBOutlet weak var lblMumbaiMetroNumber: UILabel!
    
    @IBOutlet weak var lblTicketStatus: UILabel!
    @IBOutlet weak var btnViewDetail: UIButton!
    @IBOutlet weak var btnQRCode: UIButton!
    
    @IBOutlet weak var btnPenality: UIButton!
    @IBOutlet weak var lblPaymentStatus: UILabel!
    @IBOutlet weak var lblPaymentRefnumber: UILabel!
    
    @IBOutlet weak var lblPenalityText: UILabel!
    var completionBlockQR:((_ index:Int) ->Void)?
    var completionBlockTicket:((_ index:Int) ->Void)?
    var completionHideAll:((_ index:Int) ->Void)?
    var completionQRHelpClicked:((_ index:Int) ->Void)?
    
    var objHistroy:myTicketList? {
        didSet {
            lblSourceValue.text = objHistroy?.from_Station
            lblDestinationValue.text = objHistroy?.to_Station
            lblAmount.text =  "Rs.\(objHistroy?.totaL_FARE ?? 0)"
            lblExpireAtValue.text = objHistroy?.dtExpiryDate
            lblTicketQuantityValue.text = "\(objHistroy?.ticketQty ?? 0)"
            lblTransactionNumberValue.text = objHistroy?.strDMTicketRefrenceNo
            lblRouteNo.text = objHistroy?.routeNo
            lblPurchaseAtValue.text = objHistroy?.transaction_Date
            lblServiceTypeValue.text = objHistroy?.busType
            lblTicketTypeValue.text = objHistroy?.strTicketType
            lblMumbaiMetroNumber.text = objHistroy?.strTicketRefrenceNo
            
            lblPaymentStatus.text = objHistroy?.strStatus
            lblPaymentRefnumber.text = objHistroy?.strPaymentRefNo
            
            lblTicketStatus.text = "lbl_ticket_details".localized() + " (" + (objHistroy?.strPaymentStatus ?? "") + ")"
            
//            7    EXPIRED
//           //        6    REFUNDED
//           //        5    REFUND INITIATED
//           //        4    NOT BOOKED
//           //        3    CONFIRMED
//           //        2    PENDING
//           //        1    FAILED
           
            if objHistroy?.intStatusID == 2 {
                lblExpireAtValue.text = "NA"
            }
            else if objHistroy?.intStatusID == 1 {
                lblExpireAtValue.text = "NA"
                btnQRCode.superview?.isHidden = true
            }
            viewQRCode.hideContentOnScreenCapture()
//            if objHistroy?.strPaymentStatus?.uppercased() == "PENDING" {
//                lblExpireAtValue.text = "NA"
//            }
//            else if objHistroy?.strPaymentStatus?.uppercased() == "FAILED" {
//                lblExpireAtValue.text = "NA"
//            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        btnPenality.isHidden = true
        // Initialization code
    }
//    func cellConfig(objHistory:ViewTicketModel,indexpath:IndexPath) {
//        lblSourceValue.text = objHistroy?.from_Station
//        lblDestinationValue.text = objHistroy?.to_Station
//        lblAmount.text =  "Rs.\(objHistroy?.totaL_FARE ?? 0)"
//        lblExpireAtValue.text = objHistroy?.dtExpiryDate
//        lblTicketQuantityValue.text = "\(objHistroy?.ticketQty ?? 0)"
//        lblTransactionNumberValue.text = objHistroy?.strTicketRefrenceNo
//        lblRouteNo.text = objHistroy?.routeNo
//        lblPurchaseAtValue.text = objHistroy?.transactionDate
//        lblServiceTypeValue.text = objHistroy?.busType
//        lblTicketTypeValue.text = objHistroy?.ticketCategory
//    }
    @IBAction func actionViewDetails(_ sender: UIButton) {
//        viewTicketDetails.isHidden = false
//        viewQRCode.isHidden = true
//        self.contentView.layoutIfNeeded()
        guard let cb = completionBlockTicket else {return}
            cb(sender.tag)
    }
    
    @IBAction func actionViewQRcode(_ sender: UIButton) {

        
        guard let cb = completionBlockQR else {return}
        cb(sender.tag)
      
    }
    @IBAction func actopnHideShowQRCode(_ sender: UIButton) {
//        viewQRCode.isHidden = true
//        self.contentView.layoutIfNeeded()
        guard let cb = completionHideAll else {return}
            cb(sender.tag)
        
    }
    @IBAction func btnActionQRhelpClicked(_ sender: UIButton) {

        guard let cb = completionQRHelpClicked else {return}
            cb(sender.tag)
        
    }
    @IBAction func actionHideShowTicketDetails(_ sender: UIButton) {
//        viewTicketDetails.isHidden = true
//        self.contentView.layoutIfNeeded()
        guard let cb = completionHideAll else {return}
            cb(sender.tag)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
