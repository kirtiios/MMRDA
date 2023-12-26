//
//  trasferReturnCell.swift
//  MMRDA
//
//  Created by meghana.trivedi on 15/06/23.
//

import UIKit

class trasferReturnCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionviewHeight: NSLayoutConstraint!
    @IBOutlet weak var TrasportModeCollectionView: UICollectionView!
    @IBOutlet weak var imgEnd: UIImageView!
    @IBOutlet weak var imgStart: UIImageView!
    @IBOutlet weak var imgEnd1: UIImageView!
    @IBOutlet weak var imgEnd2: UIImageView!
    @IBOutlet weak var imgStart1: UIImageView!
    @IBOutlet weak var imgStart2: UIImageView!
    
   
    var trasportparth:TransitPaths?{
        didSet{
            collectionviewHeight.constant = CGFloat((trasportparth?.lstModes?.count ?? 0) * 60)
            TrasportModeCollectionView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        TrasportModeCollectionView.delegate = self
        TrasportModeCollectionView.dataSource = self
        
        let nibName = UINib(nibName: "trasportModeCell", bundle:nil)
        TrasportModeCollectionView.register(nibName, forCellWithReuseIdentifier: "trasportModeCell")
        
      
        
       
        // Initialization code
    }

}
extension trasferReturnCell:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trasportparth?.lstModes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"trasportModeCell", for: indexPath) as! trasportModeCell
        cell.imgSideArrow.image = UIImage(named: "sideArrow")
        print(trasportparth?.lstModes?[indexPath.row])
        let path = trasportparth?.lstModes?[indexPath.row] ?? ""
        let lastName = URL(fileURLWithPath: path).lastPathComponent
        print(lastName)
        if lastName == "bus-round.svg"{
            cell.imgTrasport.image = UIImage(named: "lightBackgroundBus")
        }else if lastName == "walk.svg"{
            cell.imgTrasport.image = UIImage(named: "Walk")
        }else if lastName == "metro-round.svg"{
            cell.imgTrasport.image = UIImage(named: "metroJourney")
        }else{
            cell.imgTrasport.image = UIImage(named: "metroJourney")
        }
       
        return cell
    }
   
    
}
extension trasferReturnCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 55, height: 55)
    }
}
