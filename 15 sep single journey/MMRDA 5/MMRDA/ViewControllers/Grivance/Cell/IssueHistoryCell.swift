//
//  IssueHistoryCell.swift
//  MMRDA
//
//  Created by meghana.trivedi on 28/03/23.
//

import UIKit

class IssueHistoryCell: UITableViewCell {
    
    @IBOutlet var viewBack:UIView!
    @IBOutlet var imgProfile:UIImageView!
    @IBOutlet var lblProfileNm:UILabel!
    @IBOutlet var lblProfileDescription:UILabel!
    @IBOutlet var lblProfileDate:UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
