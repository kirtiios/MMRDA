//
//  GrivanceCell.swift
//  MMRDA
//
//  Created by Sandip Patel on 01/09/22.
//

import UIKit

class GrivanceCell: UITableViewCell {
    
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblIncidentDate: UILabel!
    @IBOutlet weak var lblRoute: UILabel!
    
    @IBOutlet weak var txtFiledDate: UILabel!
    @IBOutlet weak var txtSubcatgory: UILabel!
    @IBOutlet weak var txtCategory: UILabel!
    @IBOutlet weak var txtGrivanceNO: UILabel!
    
    @IBOutlet weak var lblOpenDate: UILabel!
    @IBOutlet weak var lblOpenStatus: UILabel!
    @IBOutlet weak var lblProgressDate: UILabel!
    @IBOutlet weak var lblInProgressStatus: UILabel!
    @IBOutlet weak var lblCloseStatus: UILabel!
    @IBOutlet weak var lblCloseDate: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblAttachment: UILabel!
    
    @IBOutlet weak var stackviewProgress: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
