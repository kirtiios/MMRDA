//
//  JourneyplannerStationCell.swift
//  MMRDA
//
//  Created by Sandip Patel on 29/08/22.
//

import UIKit

class JourneyplannerStationCell: UITableViewCell {
    
    @IBOutlet weak var transportTypeCollectionView: UICollectionView!

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
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"TransportTypeCell", for: indexPath) as! TransportTypeCell
        return cell
    }
    
    
}
