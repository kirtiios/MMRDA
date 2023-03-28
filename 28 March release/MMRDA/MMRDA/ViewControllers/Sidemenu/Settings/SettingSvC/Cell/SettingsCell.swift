//
//  SettingsCell.swift
//  MMRDA
//
//  Created by Sandip Patel on 01/09/22.
//

import UIKit

class SettingsCell: UITableViewCell {
    
   
    @IBOutlet weak var sideArrowIcon: UIImageView!
    @IBOutlet weak var setMPinEnableSwitch: UISwitch!
    @IBOutlet weak var imgMenu: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var completion:((Bool)->Void)?
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

  
    @IBAction func actionSwitchValueChnaged(_ sender: UISwitch) {
        
        completion?(sender.isOn)
        
    }
}
