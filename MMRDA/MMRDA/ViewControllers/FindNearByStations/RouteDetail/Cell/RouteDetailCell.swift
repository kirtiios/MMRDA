//
//  RouteDetailCell.swift
//  MMRDA
//
//  Created by Sandip Patel on 24/08/22.
//

import UIKit


typealias c2V = () ->()

class RouteDetailCell: UITableViewCell {

    @IBOutlet weak var imgViewLine: UIImageView!
    @IBOutlet weak var lblStatioName: UILabel!
    @IBOutlet weak var lblTripType: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var btnNotify: UIButton!
    @IBOutlet weak var imgview:UIImageView!
    var indexpath:IndexPath?
    var completionBlock:((IndexPath?) ->(Void))?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func actionNotify(_ sender: Any) {
//        guard let cb = completionBlock else {return}
//            cb(indexpath)
        completionBlock?(indexpath)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
