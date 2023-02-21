//
//  JourneyPlannerRouteDetailCell.swift
//  MMRDA
//
//  Created by Sandip Patel on 06/09/22.
//

import UIKit

//let kunCovered = "Uncovered"
//let kCovered = "Covered"

class JourneyPlannerRouteDetailCell: UITableViewCell {
    
    @IBOutlet weak var lblStatioName: UILabel!
    @IBOutlet weak var imgVehicle: UIImageView!
    @IBOutlet weak var btnNotify: UIButton!
    @IBOutlet weak var btnPrice: UIButton!
    @IBOutlet weak var btnShowRoutes: UIButton!
    @IBOutlet weak var imgTransportTypeBValue: UIImageView!
    @IBOutlet weak var lblVehchcileStatus: UILabel!
    
    @IBOutlet weak var lblToDistance: UILabel!
    @IBOutlet weak var lblToFare: UILabel!
    @IBOutlet weak var imgEndWalk: UIImageView!
    @IBOutlet weak var imgStartWalk: UIImageView!
    @IBOutlet weak var imgViewToLine: UIImageView!
    @IBOutlet weak var lbDistance: UILabel!
    @IBOutlet weak var lblTripStatus: UILabel!
    
    @IBOutlet weak var btnToNOtify: UIButton!
    @IBOutlet weak var lblToTime: UILabel!
    @IBOutlet weak var lblToStatus: UILabel!
    @IBOutlet weak var lblToStation: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    
    @IBOutlet weak var lblFromFare: UILabel!
    @IBOutlet weak var imgViewLine: UIImageView!
    
    var completionBlockData:c2B?
    var completionBlockNotify:((TransitPaths?) ->(Void))?
    var completionBlockOFAlternatives:c2B?
   // var isShowTable: ((_ isHidden: Bool) -> ())?
    var indexpath:IndexPath?
    
    @IBOutlet weak var lblfromDistance: UILabel!
    @IBOutlet weak var lblFromStation: UILabel!
    @IBOutlet weak var lblMainToStation: UILabel!
    var arrRoutePaths = [TransitPaths](){
        didSet{
            self.reloadData()
        }
    }
    
    @IBOutlet weak var lblTOSTation1: UILabel!
    @IBOutlet weak var lblTOSTation2: UILabel!
    @IBOutlet weak var lblTODistance1: UILabel!
    @IBOutlet weak var lblTODistance2: UILabel!
    @IBOutlet weak var lblTOTime1: UILabel!
    @IBOutlet weak var lblTOTime2: UILabel!
    @IBOutlet weak var lblFromSTation1: UILabel!
    @IBOutlet weak var lblFromSTation2: UILabel!
    @IBOutlet weak var lblFromDistance1: UILabel!
    @IBOutlet weak var lblFromDistance2: UILabel!
    @IBOutlet weak var lblFromTime1: UILabel!
    @IBOutlet weak var lblFromTime2: UILabel!
    var arrOriginal = [TransitPaths]()
    @IBOutlet weak var consttblviewHeight: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tblView.delegate = self
        tblView.dataSource = self
        
    }

    
    func reloadData() {
        self.tblView.reloadData()
        self.tblView.layoutIfNeeded()
        self.contentView.setNeedsLayout()
        self.tblView.beginUpdates()
        self.tblView.endUpdates()
        consttblviewHeight.constant = tblView.contentSize.height
        self.tblView.layoutIfNeeded()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.tblView.beginUpdates()
            self.tblView.endUpdates()
            print("height cell:",self.tblView.contentSize.height)
            self.consttblviewHeight.constant = self.tblView.contentSize.height
            if self.tblView.isHidden {
                self.consttblviewHeight.constant = 0
            }
            if let cb = self.completionBlockData {
                cb()
            }
        })
        
        if let cb = completionBlockData {
            cb()
        }

    }
    
    @IBAction func actionNotify(_ sender: UIButton) {
        if let cb = completionBlockNotify {
            if sender == btnNotify {
                cb(arrOriginal[sender.tag])
            }else {
                var obj = arrOriginal.last
                obj?.fromStationName = arrOriginal.last?.toStationName
                obj?.fromStationId = arrOriginal.last?.toStationId
                obj?.lat1 = arrOriginal.last?.lat2
                obj?.bCovered1 = arrOriginal.last?.bCovered2
                obj?.long1 = arrOriginal.last?.long2
                obj?.etaNode1 = arrOriginal.last?.etaNode2
                obj?.bNotify1 = arrOriginal.last?.bNotify2
                cb(obj)
            }
        }
    }
    
    
    
    @IBAction func actionAlternatives(_ sender: Any) {
        if let cb = completionBlockOFAlternatives {
            cb()
        }
    }
    @IBAction func btnActionMyBikeClicked(_ sender: UIButton) {
       
        guard let url = URL(string: "https://apps.apple.com/in/app/id1302751321") else {
          return //be safe
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        
    }
    
    @IBAction func actionShowHideRoutes(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            btnShowRoutes.setImage(UIImage(named: "dropdown"), for:.normal)
            tblView.isHidden = false
            consttblviewHeight.constant = tblView.contentSize.height
            self.reloadData()
        }else{
            btnShowRoutes.setImage(UIImage(named: "dropup"), for:.normal)
            tblView.isHidden = true
            consttblviewHeight.constant = 0
            self.reloadData()
            
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension JourneyPlannerRouteDetailCell :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRoutePaths.count
//        return tblView.isHidden ? 0 : arrRoutePaths.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"JourneyPlannerShowRoutesCell") as? JourneyPlannerShowRoutesCell else  { return UITableViewCell() }
        
        let objdata = arrRoutePaths[indexPath.row]
        cell.lblFromStatioName.text =  objdata.fromStationName
        
        
        if objdata.bNotify1 ?? false {
            cell.btnNotify.backgroundColor =  UIColor.greenColor
            cell.btnNotify.setTitleColor(UIColor.white, for: .normal)
        }else {
            cell.btnNotify.backgroundColor = UIColor.white
            cell.btnNotify .setTitleColor(UIColor.greenColor, for: .normal)
        }
        
        cell.btnNotify.tag = indexPath.row
        cell.btnNotify.superview?.isHidden = false
        cell.lblStatus.text = "strNotArrived".LocalizedString
        cell.imgViewLine.tintColor = UIColor.blue
        cell.imgVehcile.image = UIImage(named:"CenterPinGreen")
        if objdata.bCovered1 == "1" {
            cell.btnNotify.superview?.isHidden = true
            cell.lblStatus.text = "strArrived".LocalizedString
            cell.imgViewLine.tintColor = UIColor.greenColor
            cell.imgVehcile.tintColor = UIColor.greenColor
            cell.imgVehcile.image = UIImage(named:"centerFillGreen")
        }
        cell.lbltime.text = (objdata.etaNode1 ?? "").getCurrentDatewithDash().toString(withFormat:"hh:mm a")
        if tblView.isHidden == true {
            consttblviewHeight.constant = 0
        }else{
            consttblviewHeight.constant = tblView.contentSize.height
        }
        self.tblView.layoutIfNeeded()
        self.contentView.layoutSubviews()
        
        cell.completionBlockNotify = { index  in
            if let index = index {
                self.completionBlockNotify?(self.arrRoutePaths[index])
            }
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = UIStoryboard.RoueDetailVC()
//        self.navigationController?.pushViewController(vc!, animated:true)
        
    }
    
    
}
