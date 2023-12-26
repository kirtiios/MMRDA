//
//  StationListCell.swift
//  MMRDA
//
//  Created by Sandip Patel on 24/08/22.
//

import UIKit

class StationListCell: UITableViewCell {

    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblToStation: UILabel!
    @IBOutlet weak var lblFromStation: UILabel!
    @IBOutlet weak var imgview: UIImageView!
    @IBOutlet weak var btnRoute: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
