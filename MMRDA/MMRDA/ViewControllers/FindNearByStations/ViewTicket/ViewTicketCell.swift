//
//  ViewTicketCell.swift
//  MMRDA
//
//  Created by Sandip Patel on 29/08/22.
//

import UIKit

class ViewTicketCell: UITableViewCell {
    
    @IBOutlet weak var viewTicketDetails: UIStackView!
    @IBOutlet weak var viewQRCode: UIView!
    
    var completionBlock:c2V?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func actionViewDetails(_ sender: Any) {
        viewTicketDetails.isHidden = false
        viewQRCode.isHidden = true
        guard let cb = completionBlock else {return}
            cb()
    }
    
    @IBAction func actionViewQRcode(_ sender: Any) {
        viewTicketDetails.isHidden = true
        viewQRCode.isHidden = false
        guard let cb = completionBlock else {return}
            cb()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
