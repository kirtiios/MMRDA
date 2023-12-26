//
//  SuggestedItineraryCell.swift
//  MMRDA
//
//  Created by meghana.trivedi on 01/06/23.
//

import UIKit

class SuggestedItineraryCell: UITableViewCell {
    
    @IBOutlet var btnRadio:UIButton!
    @IBOutlet var lblDate:UILabel!
    @IBOutlet var lblDurationTime:UILabel!
    @IBOutlet var lblChange:UILabel!
    @IBOutlet var twoTime:UILabel!
    @IBOutlet var lblStationName:UILabel!
    @IBOutlet var subTitleStation:UILabel!
    @IBOutlet var platformestimated:UILabel!
    @IBOutlet var imgfirstwalk:UIImageView!
    @IBOutlet var imgfirstwalkrightArrow:UIImageView!
    @IBOutlet var imgfirstCycle:UIImageView!
    @IBOutlet var imgfirstCycleArrow:UIImageView!
    @IBOutlet var secondCycle:UIImageView!
    @IBOutlet var secondCycleArrow:UIImageView!
    @IBOutlet var imgSecondWalk:UIImageView!
    @IBOutlet var imgSecongwalkarrow:UIImageView!
    @IBOutlet var imgFirstBus:UIImageView!
    @IBOutlet var imgFirstbusArrow:UIImageView!
    @IBOutlet var imgSecondBus:UIImageView!
    @IBOutlet var imgSecondBusArrow:UIImageView!
    @IBOutlet var imgThirdWalk:UIImageView!
    @IBOutlet var imgThirdWalkArrow:UIImageView!
    @IBOutlet var imgForthCycle:UIImageView!
    @IBOutlet var imgForthCycleArrow:UIImageView!
    @IBOutlet var ingThirdCycle:UIImageView!
    @IBOutlet var ingThirdCycleArrow:UIImageView!
    @IBOutlet weak var transportTypeCollectionView: UICollectionView!
    @IBOutlet var  leftSideSpace:NSLayoutConstraint!
    @IBOutlet var leftSideStationSpace:NSLayoutConstraint!
    
    
    var obj:JourneyPlannerStationDetail? {
        didSet {
            transportTypeCollectionView.reloadData()
        }
    }
    var objTeraslistPath:[TransitPaths]?{
        didSet{
            transportTypeCollectionView.reloadData()
        }
    }
    var radioClick: ((Int) -> Void)? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        
        transportTypeCollectionView.delegate = self
        transportTypeCollectionView.dataSource = self
        
        let nibName = UINib(nibName: "trasferReturnCell", bundle:nil)
        transportTypeCollectionView.register(nibName, forCellWithReuseIdentifier: "trasferReturnCell")
        
        let width = UIScreen.main.bounds.width - 40
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: width, height: 30)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        transportTypeCollectionView.collectionViewLayout = layout
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnRadio(_ sender: UIButton) {
        radioClick?(sender.tag)
    }
}
extension SuggestedItineraryCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"trasferReturnCell", for: indexPath) as! trasferReturnCell
       
        cell.imgEnd1.superview?.isHidden = false
        cell.imgStart1.superview?.isHidden = false
        
        print(objTeraslistPath?[indexPath.row].lstModes)
        
        if obj?.modeOfFromStationTravel == "T" {
            
            cell.imgStart.image = UIImage(named: "Taxi")
            cell.imgStart1.superview?.isHidden = true
            
//            cell.imgStart1.image = UIImage(named: "Taxi")
//            cell.imgStart2.image = UIImage(named: "Taxi")
        }
        else if obj?.modeOfFromStationTravel == "A" {
            
            cell.imgStart.image = UIImage(named: "Rickshaw")
            cell.imgStart1.superview?.isHidden = true
            
//            cell.imgStart1.image = UIImage(named: "Rickshaw")
//            cell.imgStart2.image = UIImage(named: "Rickshaw")
        }
        else if obj?.modeOfFromStationTravel == "B" {
            cell.imgStart1.image = UIImage(named: "myBike")
            cell.imgStart2.image = UIImage(named: "myBike")
            
        }else {
            cell.imgStart1.superview?.isHidden = true
        }
        if obj?.modeOfToStationTravel == "A" {
            cell.imgEnd.image = UIImage(named: "Rickshaw")
            cell.imgEnd1.superview?.isHidden = true
//            cell.imgEnd1.image = UIImage(named: "Rickshaw")
//            cell.imgEnd2.image = UIImage(named: "Rickshaw")
        }
        else if obj?.modeOfToStationTravel == "T" {
            cell.imgEnd.image = UIImage(named: "Taxi")
//            cell.imgEnd1.image = UIImage(named: "Taxi")
//            cell.imgEnd2.image = UIImage(named: "Taxi")
            cell.imgEnd1.superview?.isHidden = true
        }
        else if obj?.modeOfToStationTravel == "B" {
            cell.imgEnd1.image = UIImage(named:"myBike")
            cell.imgEnd1.image = UIImage(named:"myBike")
        }
        else {
            cell.imgEnd1.superview?.isHidden = true
        }
        
//        cell.imgEnd1.superview?.isHidden = false
//        cell.imgStart1.superview?.isHidden = false
        return cell
    }
    
    
}
