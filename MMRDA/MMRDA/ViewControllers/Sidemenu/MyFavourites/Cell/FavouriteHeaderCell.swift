//
//  FavouriteHeaderCell.swift
//  BMTC
//
//  Created by Sandip Patel on 18/08/21.
//

import UIKit

class FavouriteHeaderCell: UITableViewCell {
    @IBOutlet weak var lblHeaderName : UILabel!

    @IBOutlet weak var lblErromSg: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
