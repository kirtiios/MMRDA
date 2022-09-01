//
//  ReviewCell.swift
//  MMRDA
//
//  Created by Sandip Patel on 31/08/22.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var lblFeedBackTime: UILabel!
    @IBOutlet weak var ratingView: StarRatingView!
    @IBOutlet weak var imgUserProfile: UIImageView!
    @IBOutlet weak var lblUserComment: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
