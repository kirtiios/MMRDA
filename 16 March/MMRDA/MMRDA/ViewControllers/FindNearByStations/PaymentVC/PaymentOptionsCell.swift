//
//  PaymentOptionsCell.swift
//  MMRDA
//
//  Created by Sandip Patel on 26/08/22.
//

import UIKit

class PaymentOptionsCell: UITableViewCell {

    @IBOutlet weak var lblPaymentDetail: UILabel!
    @IBOutlet weak var lblPaymentTitle: UILabel!
    @IBOutlet weak var btnSelection: UIButton!
    var completionPayment:((Bool)->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    @IBAction func actionCellSelection(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.tag  == 0 {
            completionPayment?(sender.isSelected)
        }
    }
    
}
