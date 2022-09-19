//
//  UserProfileCell.swift
//  MMRDA
//
//  Created by Sandip Patel on 22/08/22.
//

import UIKit

class UserProfileCell: UITableViewCell {
    
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblEmailID: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnProfile: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
// MARK: EDIT PROFILE ACTION
    @IBAction func actionEditProfile(_ sender: Any) {
        
    }
}
