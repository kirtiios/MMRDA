//
//  TransportDataCell.swift
//  MMRDA
//
//  Created by Sandip Patel on 22/08/22.
//

import UIKit

class TransportDataCell: UITableViewCell {
    
    @IBOutlet weak var imgTransportType: UIImageView!
    @IBOutlet weak var lblKm: UILabel!
    @IBOutlet weak var lblStopName: UILabel!
    @IBOutlet weak var btnDirection: UIButton!
 
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
