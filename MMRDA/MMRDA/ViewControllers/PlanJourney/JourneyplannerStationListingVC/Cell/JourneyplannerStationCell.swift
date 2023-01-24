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
        cell.imgStartWalk.image = UIImage(named: "Walk")
        cell.imgEndWalk.image = UIImage(named: "Walk")
        if obj?.modeOfFromStationTravel == "T" {
            cell.imgStartWalk.image = UIImage(named: "Taxi")
        }
        else if obj?.modeOfFromStationTravel == "A" {
            cell.imgStartWalk.image = UIImage(named: "Rickshaw")
        }
        
        if obj?.modeOfToStationTravel == "A" {
            cell.imgEndWalk.image = UIImage(named: "Rickshaw")
        }
        else if obj?.modeOfToStationTravel == "T" {
            cell.imgEndWalk.image = UIImage(named: "Taxi")
        }
        return cell
    }
    
    
}
