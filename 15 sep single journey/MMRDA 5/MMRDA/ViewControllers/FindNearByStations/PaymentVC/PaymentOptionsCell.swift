//
//  PaymentOptionsCell.swift
//  MMRDA
//
//  Created by Sandip Patel on 26/08/22.
//

import UIKit

class PaymentOptionsCell: UITableViewCell {

    @IBOutlet weak var lblPaymentDetail: UILabel!
    @IBOutlet weak var lblPaymentTitle: UILabel!
    @IBOutlet weak var btnSelection: UIButton!
    @IBOutlet var btn1Pay:UIButton!
    
    var completionPayment:((Bool)->Void)?
    
    var OnePayPayment:((Bool)->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    @IBAction func actionCellSelection(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
//        if (btnSelection.currentImage == UIImage(named: "RectangleCheckBoxUnSelected")){
//            btnSelection.setImage(UIImage(named: "RectangleCheckBoxSelected"), for: .normal)
//            btn1Pay.setImage(UIImage(named: "RectangleCheckBoxUnSelected"), for: .normal)
//        }
     
            completionPayment?(sender.isSelected)
        
    }
    @IBAction func btn1PayClick(_ sender: UIButton) {
        
//        if (btn1Pay.currentImage == UIImage(named: "RectangleCheckBoxUnSelected")){
//            btn1Pay.setImage(UIImage(named: "RectangleCheckBoxSelected"), for: .normal)
//            btnSelection.setImage(UIImage(named: "RectangleCheckBoxUnSelected"), for: .normal)
//        }
//        sender.isSelected = !sender.isSelected
//        if sender.tag  == 1 {
            OnePayPayment?(sender.isSelected)
//        }
    }
}
