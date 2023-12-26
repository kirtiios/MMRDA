//
//  cellAttraction.swift
//  MMRDA
//
//  Created by Kirti Chavda on 30/08/22.
//

import UIKit

class cellAttraction: UITableViewCell {

    @IBOutlet weak var btnDirection: UIButton!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgview: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
