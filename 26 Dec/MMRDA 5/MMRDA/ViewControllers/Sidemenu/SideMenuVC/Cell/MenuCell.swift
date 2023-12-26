//
//  MenuCell.swift
//  MMRDA
//
//  Created by Sandip Patel on 22/08/22.
//

import UIKit

class MenuCell: UITableViewCell {
    
    @IBOutlet weak var imgMenu: UIImageView!
    @IBOutlet weak var lblMenuName: UILabel!
    @IBOutlet weak var viewComingSoon: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
