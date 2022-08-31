//
//  SaveLocationVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 30/08/22.
//

import UIKit

class SaveLocationVC: UIViewController {

    @IBOutlet weak var txtLabelName: UITextField!
    @IBOutlet weak var txtLocatioName: UITextField!
    @IBOutlet weak var popupView: UIView!
    private var  objViewModel = FavouriteModelView()
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 6
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func actionSave(_ sender: Any) {
        
//        ADD Fav
//        API : Favourite/InsertFavoriteDetails
//        intUserID
//        intFavouriteTypeID
//        strLocationName  (isblanck)
//        strAddress
//        decLocationLat
//        decLocationLong
//        strlabel
//        intPlaceID
//        intRouteID
        
        
        //objViewModel.insertFavourite(param: <#T##[String : Any]#>)
    }
    
    
    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated:true)
        
    }
    
    

}
