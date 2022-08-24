//
//  RouteDetailCell.swift
//  MMRDA
//
//  Created by Sandip Patel on 24/08/22.
//

import UIKit

class RouteDetailCell: UITableViewCell {

    @IBOutlet weak var lblStatioName: UILabel!
    
    @IBOutlet weak var lblTripType: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func actionNotify(_ sender: Any) {
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
