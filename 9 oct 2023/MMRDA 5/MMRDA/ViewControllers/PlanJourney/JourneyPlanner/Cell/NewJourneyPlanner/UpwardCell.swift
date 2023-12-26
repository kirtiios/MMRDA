//
//  UpwardCell.swift
//  MMRDA
//
//  Created by meghana.trivedi on 01/06/23.
//

import UIKit

class UpwardCell: UITableViewCell {

    @IBOutlet weak var btnExpress: UIButton!
    @IBOutlet weak var lblScheduledArrival: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDestination: UILabel!
    @IBOutlet weak var lblSource: UILabel!
    @IBOutlet weak var btnRouteDetails: UIButton!
    @IBOutlet weak var btnBookNow: UIButton!
    
    
    
    var ExpressBlock: ((Int) -> Void)? = nil
    var RoundDetailsBlock: ((Int) -> Void)? = nil
    var BookNowBlock: ((Int) -> Void)? = nil
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnExpressClick(_ sender: UIButton) {
        
        ExpressBlock?(sender.tag)
    }
    @IBAction func btnRouteDetailsClick(_ sender: UIButton) {
        RoundDetailsBlock?(sender.tag)
    }
    @IBAction func btnBookNowClick(_ sender: UIButton) {
        BookNowBlock?(sender.tag)
    }
    
}
