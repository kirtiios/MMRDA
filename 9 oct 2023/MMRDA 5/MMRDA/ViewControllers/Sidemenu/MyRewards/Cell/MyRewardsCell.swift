//
//  MyRwardsCell.swift
//  MMRDA
//
//  Created by Sandip Patel on 30/08/22.
//

import UIKit

class MyRewardsCell: UITableViewCell {

    @IBOutlet weak var lblPoints: UILabel!
    @IBOutlet weak var lbltransactionDetail: UILabel!
    @IBOutlet weak var lblEarnedPoints: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
