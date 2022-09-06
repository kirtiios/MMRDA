//
//  TicketDetailCell.swift
//  MMRDA
//
//  Created by Sandip Patel on 31/08/22.
//

import UIKit

typealias c2B = () ->()

class TicketDetailCell: UITableViewCell {
    
    @IBOutlet weak var lblticketNo: UILabel!
    @IBOutlet weak var btnSideArrow: UIButton!
    @IBOutlet weak var ticketDetailCell: UIStackView!
    
    @IBOutlet weak var lblRouteNo: UILabel!
   
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lbltotalAmount: UILabel!
    
    @IBOutlet weak var lblTransctionDate: UILabel!
    
    @IBOutlet weak var lblTransctionID: UILabel!
    @IBOutlet weak var lblTicketQuantityValue: UILabel!
    @IBOutlet weak var lblTransactionNumberValue: UILabel!
    @IBOutlet weak var lblTicketTypeValue: UILabel!
    @IBOutlet weak var lblServiceTypeValue: UILabel!
    @IBOutlet weak var lblExpireAtValue: UILabel!
    @IBOutlet weak var lblPurchaseAtValue: UILabel!
    @IBOutlet weak var lblDestinationValue: UILabel!
    @IBOutlet weak var lblSourceValue: UILabel!
    @IBOutlet weak var lblAmount: UILabel!

    
    var completionBlock:c2V?
    var completionBlockData:c2B?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func actionhideShowTicketDetails(_ sender: UIButton) {
        sender.isHighlighted = false
        sender.isSelected  = !sender.isSelected
        
        if sender.isSelected == true {
            ticketDetailCell.isHidden = false
            sender.setImage(UIImage(named:"dropup"), for: .normal)
            sender.backgroundColor = .white
        }else{
            ticketDetailCell.isHidden = true
            sender.setImage(UIImage(named:"sideArrow"), for: .normal)
            sender.backgroundColor = .white
        }
        guard let cb = completionBlock else {return}
            cb()
        
    }
    func cellConfig(objdata:myTicketList,indexpath:IndexPath){
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

    @IBAction func actionShowQR(_ sender: Any) {
        guard let cb = completionBlockData else {return}
            cb()
        
    }
}
