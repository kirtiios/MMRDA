//
//  ContactCell.swift
//  MMRDA
//
//  Created by Sandip Patel on 02/09/22.
//

import Foundation
import UIKit



protocol SOSContactDelegate{
    func deleteContactTapped(at index:IndexPath)
}

class ContactCell: UITableViewCell {
    var tapCallback: (() -> Void)?
    
    @IBOutlet weak var lblName: UILabel!
    var delegate:SOSContactDelegate!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func deleteActionButton(sender: UIButton) {
        tapCallback?()
//        self.delegate?.deleteContactTapped(at: indexPath)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
