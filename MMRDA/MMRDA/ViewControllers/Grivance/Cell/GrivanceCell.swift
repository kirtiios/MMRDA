//
//  GrivanceCell.swift
//  MMRDA
//
//  Created by Sandip Patel on 01/09/22.
//

import UIKit

class GrivanceCell: UITableViewCell {
    
    @IBOutlet weak var xtResolvedDate: UILabel!
    @IBOutlet weak var txtFiledDate: UILabel!
    @IBOutlet weak var txtcomment: UILabel!
    @IBOutlet weak var txtTransportType: UILabel!
    @IBOutlet weak var txtGrivanceNO: UILabel!
    
    @IBOutlet weak var lblStatus: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
