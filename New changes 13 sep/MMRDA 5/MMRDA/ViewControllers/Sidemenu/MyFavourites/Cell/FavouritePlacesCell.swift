//
//  FavouritePlacesCell.swift
//  BMTC
//
//  Created by Sandip Patel on 18/08/21.
//

import UIKit

class FavouritePlacesCell: UITableViewCell {
    @IBOutlet weak var imgIcon : UIImageView!
    @IBOutlet weak var lblTitleName : UILabel!
    @IBOutlet weak var lbladdress : UILabel!
    @IBOutlet weak var btnDelete : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
