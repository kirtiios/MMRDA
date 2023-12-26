//
//  statusTrackCell.swift
//  MMRDA
//
//  Created by meghana.trivedi on 28/03/23.
//

import UIKit

class statusTrackCell: UITableViewCell {
    
    @IBOutlet var viewBack:UIView!
    @IBOutlet var imgCenter:UIImageView!
    @IBOutlet var imgLine:UIImageView!
    @IBOutlet var lblStatusTitle:UILabel!
    @IBOutlet var lblStatusDate:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
