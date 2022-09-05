//
//  SaveLocationVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 30/08/22.
//

import UIKit
import MapKit

class SaveLocationVC: UIViewController {

    @IBOutlet weak var txtLabelName: UITextField!
    @IBOutlet weak var txtLocatioName: UITextField!
    @IBOutlet weak var popupView: UIView!
    private var  objViewModel = FavouriteModelView()
    var objLocation:CLLocationCoordinate2D?
    var strLocation:String?
    var compeltion:(()->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 6
        txtLocatioName.text = strLocation
        objViewModel.delegate = self
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
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
        if txtLocatioName.text?.trim().isEmpty ?? false {
            self.objViewModel.inputErrorMessage.value = "plsenterlocationname".LocalizedString
        }
        else if txtLabelName.text?.trim().isEmpty ?? false {
            self.objViewModel.inputErrorMessage.value = "plsenterlabelname".LocalizedString
        }else {
            
            var param =  [String:Any]()
            param["intUserID"] = Helper.shared.objloginData?.intUserID
            param["intFavouriteTypeID"] = typeOfFav.Location.rawValue
            param["strLocationName"] =  ""
            param["strAddress"] = txtLocatioName.text
            param["strlabel"] = txtLabelName.text
            param["decLocationLat"] = objLocation?.latitude
            param["decLocationLong"] = objLocation?.longitude
            
            
            ApiRequest.shared.requestPostMethod(strurl: apiName.insertFavourite, params: param, showProgress: true, completion: { suces, data, error in
                if var obj = try? JSONDecoder().decode(AbstractResponseModel<LocationResuleModel>.self, from: data) {
                    if obj.issuccess ?? false {
                        if  let model = obj.data?.first?.result , model == 1 {
                            self.showAlertViewWithMessageAndActionHandler("", message:  obj.message ?? "") {
                                self.dismiss(animated: true) {
                                    self.compeltion?()
                                }
                            }
                            
                        }else {
                            if let message = obj.message {
                                self.objViewModel.inputErrorMessage.value = message
                            }
                        }
                    }else {
                        if let message = obj.message {
                            self.objViewModel.inputErrorMessage.value = message
                        }
                    }
                }
            })
            
           // objViewModel.insertFavourite(param: param)
        }
    }
    
    
    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated:true)
        
    }
    
    

}
extension SaveLocationVC:ViewcontrollerSendBackDelegate {
    func getInformatioBack<T>(_ handleData: inout T) {
        if let data = handleData as? [LocationResuleModel] {
            
            if let objData = data.first?.result,objData == 1 {
                
            }
            
           
        }
       
    }
}
