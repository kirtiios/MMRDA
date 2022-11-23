//
//  ReviewCell.swift
//  MMRDA
//
//  Created by Sandip Patel on 31/08/22.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var lblFeedBackTime: UILabel!
    @IBOutlet weak var ratingView: SwiftyStarRatingView!
    @IBOutlet weak var imgUserProfile: UIImageView!
    @IBOutlet weak var lblUserComment: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.ratingView.shouldBeginGestureHandler = { _ in return false }
        self.ratingView.isUserInteractionEnabled = false
        self.ratingView.tintColor = UIColor.systemOrange
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
