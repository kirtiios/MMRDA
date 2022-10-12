//
//  JourneyPlannerShowRoutesCell.swift
//  MMRDA
//
//  Created by Sandip Patel on 06/09/22.
//

import UIKit

class JourneyPlannerShowRoutesCell: UITableViewCell {
   
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var lblStation: UILabel!
    @IBOutlet weak var imgVehcile: UIImageView!
    @IBOutlet weak var lblFromStatioName: UILabel!
    @IBOutlet weak var btnNotify: UIButton!
    @IBOutlet weak var imgViewLine: UIImageView!
    var completionBlockNotify:((Int?) ->(Void))?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

  
    
   
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func actionNotify(_ sender: UIButton) {
        completionBlockNotify?(sender.tag)
    }
    
}
