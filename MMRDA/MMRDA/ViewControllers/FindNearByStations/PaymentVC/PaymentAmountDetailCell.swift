//
//  PaymentAmountDetailCell.swift
//  MMRDA
//
//  Created by Sandip Patel on 26/08/22.
//

import UIKit

class PaymentAmountDetailCell: UITableViewCell {

    @IBOutlet weak var lblAmountinFraction: UILabel!
    @IBOutlet weak var lblAmountinRS: UILabel!
    @IBOutlet weak var lblAdultCount: UILabel!
    @IBOutlet weak var lblToStation: UILabel!
    @IBOutlet weak var lblFromStation: UILabel!
    @IBOutlet weak var lblBaseAmount: UILabel!
    @IBOutlet weak var lblRouteNo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
