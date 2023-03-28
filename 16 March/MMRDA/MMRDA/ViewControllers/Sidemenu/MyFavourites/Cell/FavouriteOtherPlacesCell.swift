//
//  FavouriteOtherPlacesCell.swift
//  BMTC
//
//  Created by Sandip Patel on 18/08/21.
//

import UIKit

class FavouriteOtherPlacesCell: UITableViewCell {
    var favouriteAttchmentAction: (() -> Void)?
    var editFavouriteAttchmentAction: (() -> Void)?
    
    var favouriteDeleteAction: ((_ indexpath:IndexPath?) -> Void)?

    @IBOutlet weak var imgIcon : UIImageView!
    @IBOutlet weak var lblTitleName : UILabel!
    @IBOutlet weak var lblFavouriteName: UILabel!
    @IBOutlet weak var btnDelete : UIButton!
    
    @IBOutlet weak var lblFromStation: UILabel!
    @IBOutlet weak var lblToStation: UILabel!
    
    var indexptah:IndexPath?
    @IBOutlet weak var btnEdit: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnDelete.tintColor = Colors.APP_Theme_color.value
    }

    // MARK: - Grievance Attachment Details
    @IBAction func btnDeleteFavouriteActionClick(sender: UIButton) {
        favouriteDeleteAction?(indexptah)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func edit_actionbutton(_ sender: Any) {
        // edit action Button
        editFavouriteAttchmentAction?()
        
    }
}
