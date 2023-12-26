//
//  FareAmountCell.swift
//  MMRDA
//
//  Created by Sandip Patel on 07/09/22.
//

import UIKit

class FareAmountCell: UITableViewCell {
    
    
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblBusNo: UILabel!
    
    @IBOutlet weak var lblToStation: UILabel!
    @IBOutlet weak var lbltxtBusNo: UILabel!
    
    @IBOutlet weak var lblFromStation: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
