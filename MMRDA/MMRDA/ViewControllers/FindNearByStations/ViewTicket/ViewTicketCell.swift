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
    
    var completionBlock:c2V?
    
    var objHistroy:ViewTicketModel? {
        didSet {
            lblSourceValue.text = objHistroy?.from_Station
            lblDestinationValue.text = objHistroy?.to_Station
            lblAmount.text =  "Rs.\(objHistroy?.totaL_FARE ?? 0)"
            lblExpireAtValue.text = objHistroy?.dtExpiryDate
            lblTicketQuantityValue.text = "\(objHistroy?.ticketQty ?? 0)"
            lblTransactionNumberValue.text = objHistroy?.strTicketRefrenceNo
            lblRouteNo.text = objHistroy?.routeNo
            lblPurchaseAtValue.text = objHistroy?.transactionDate
            lblServiceTypeValue.text = objHistroy?.busType
            lblTicketTypeValue.text = objHistroy?.ticketCategory
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func actionViewDetails(_ sender: Any) {
        viewTicketDetails.isHidden = false
        viewQRCode.isHidden = true
        self.contentView.layoutIfNeeded()
        guard let cb = completionBlock else {return}
            cb()
    }
    
    @IBAction func actionViewQRcode(_ sender: Any) {
        viewTicketDetails.isHidden = true
        viewQRCode.isHidden = false
        self.contentView.layoutIfNeeded()
        if let strQRCode = objHistroy?.ticketQR {
            if let img = Helper.shared.generateQRCode(from: strQRCode) {
                imgQRCode.image =  img
            }
        }else {
            lblTicketQRNotFound.isHidden = true
            lblTicketQRNotFound.text = "qr_not_found".localized()
        }
        
        guard let cb = completionBlock else {return}
            cb()
      
    }
    @IBAction func actopnHideShowQRCode(_ sender: Any) {
        viewQRCode.isHidden = true
        self.contentView.layoutIfNeeded()
        guard let cb = completionBlock else {return}
            cb()
        
    }
    @IBAction func actionHideShowTicketDetails(_ sender: Any) {
        viewTicketDetails.isHidden = true
        self.contentView.layoutIfNeeded()
        guard let cb = completionBlock else {return}
            cb()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
