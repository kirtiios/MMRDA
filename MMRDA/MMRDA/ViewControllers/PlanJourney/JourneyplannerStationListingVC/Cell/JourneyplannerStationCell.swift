//
//  JourneyplannerStationCell.swift
//  MMRDA
//
//  Created by Sandip Patel on 29/08/22.
//

import UIKit

class JourneyplannerStationCell: UITableViewCell {
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblToStation: UILabel!
    @IBOutlet weak var lblFromStation: UILabel!
    @IBOutlet weak var transportTypeCollectionView: UICollectionView!
    var obj:JourneyPlannerStationDetail? {
        didSet {
            transportTypeCollectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        transportTypeCollectionView.delegate = self
        transportTypeCollectionView.dataSource = self
        
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

}


extension JourneyplannerStationCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"TransportTypeCell", for: indexPath) as! TransportTypeCell
       
        cell.imgEnd1.superview?.isHidden = false
        cell.imgStart1.superview?.isHidden = false
        
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
