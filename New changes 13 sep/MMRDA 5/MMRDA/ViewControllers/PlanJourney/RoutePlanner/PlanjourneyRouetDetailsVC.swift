//
//  PlanjourneyRouetDetailsVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 06/09/22.
//

import UIKit
import GoogleMaps

class PlanjourneyRouetDetailsVC: BaseVC {
    
    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var btnPayNow: UIButton!
    @IBOutlet weak var lblLastUpdatedtime: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var btnMapView: UIButton!
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var lblToStation: UILabel!
    @IBOutlet weak var lblFromStation: UILabel!
    @IBOutlet weak var lblStatusValue: UILabel!
    @IBOutlet weak var constMapViewHeight: NSLayoutConstraint!
    @IBOutlet var btnShoPopup:UIButton!
    @IBOutlet weak var transportTypeCollectionView: UICollectionView!
    
    var objJourney:JourneyPlannerModel?
    var objStation:RecentPlaneStation?
    var arrRoutes:[TransitPaths]? {
        didSet {
           
            self.tblView.reloadData()
        }
    }
    var arrMarker = [GMSMarker]()
    
    var path = GMSMutablePath()
    var pathDifferentFrom = GMSMutablePath()
    var pathDifferentTO = GMSMutablePath()
    var pathDifferentBlueLine = GMSMutablePath()
    var pathMYBikeTo = GMSMutablePath()
    var pathMYBikeFrom = GMSMutablePath()
    var isFromFareCalVCValue = false
    var isFromNewJourney = false
    var isfromSuggestedItineratyVC = false
    var isfromUpwoedNewJourneyVc = false
    
    var downwardget = false
    var PassFullnameFrom = ""
    var PassFullnameTo = ""
    
    private var  objViewModel = JourneyPlannerModelView()
    private var objBlueLine = JourneyPlannerModelView()
    @IBOutlet weak var constTblViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var scrollview: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "routedetail".localized()
        let barButton = UIBarButtonItem(image:UIImage(named:"back"), style:.plain, target: self, action: #selector(btnActionBackClicked))
        barButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = barButton
        
        //  self.setBackButton()
        
        // self.callBarButtonForHome(isloggedIn:true, leftBarLabelName:"routedetail".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
      
        lblFromStation.text = objJourney?.journeyPlannerStationDetail?.strFromStationName
        lblToStation.text = objJourney?.journeyPlannerStationDetail?.strToStationName
        lblStatus.text = objJourney?.journeyPlannerStationDetail?.strToStationName
        arrRoutes = objJourney?.transitPaths
        
        self.refreshandAddMarker()
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
        btnFav.isSelected = objJourney?.journeyPlannerStationDetail?.isFavorite ?? false
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy h:mm:ss a"
        let currentTime = dateFormatter.string(from: Date())
        lblLastUpdatedtime.text = "\(currentTime)"
        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        if downwardget == true{
            btnPayNow.isHidden = false
        }else if isfromSuggestedItineratyVC == true{
            btnPayNow.isHidden = false
        }
        else{
            btnPayNow.isHidden = true
        }
        
        lblFromStation.text = objJourney?.journeyPlannerStationDetail?.strFromStationName
        lblToStation.text = objJourney?.journeyPlannerStationDetail?.strToStationName
        //Timer.scheduledTimer(timeInterval: 58.0, target: self, selector: #selector(CallAPIfor1Minit), userInfo: nil, repeats: true)
        
    }
    @objc private func btnActionBackClicked() {
        if isFromFareCalVCValue == true{
            self.navigationController?.popToRootViewController(animated: true)
            //            let vc = UIStoryboard.FareCalVC()
            //            self.navigationController?.pushViewController(vc, animated:true)
            return
        }else if  isfromUpwoedNewJourneyVc == true{
            self.navigationController?.popToViewController(ofClass: UpwordNewJourneyVC.self)
        } else if isfromSuggestedItineratyVC == true{
            self.navigationController?.popToViewController(ofClass: SuggestedItineraryVC.self)
        }
        else{
//            self.navigationController?.popToViewController(ofClass: JourneySearchVC.self)
            self.navigationController?.popToViewController(ofClass: NewPlaneJourneyVC.self)
            return
        }
    }
    
    func refreshandAddMarker(){
        
        let arr = objJourney?.transitPaths ?? [TransitPaths]()
        
        
        arrMarker .removeAll()
        if let obj = objJourney?.journeyPlannerStationDetail {
            let marker = GMSMarker()
            let locationCordinate = CLLocationCoordinate2D(latitude: Double(obj.decFromStationLat ?? 0) , longitude:  Double(obj.decFromStationLong ?? 0) )
            marker.position = locationCordinate
            marker.icon = UIImage(named:"fromStation")
            marker.map = mapView
            marker.snippet = objStation?.from_locationname
          //  marker.title = objStation?.from_locationname//obj.strFromStationName
            marker.userData = obj
            pathDifferentFrom.add(locationCordinate)
            arrMarker.append(marker)
        }
        
        for  i in 0..<arr.count {
            let obj = arr[i]
            let marker = GMSMarker()
            let locationCordinate = CLLocationCoordinate2D(latitude: Double(obj.lat1 ?? "0") ?? 0, longitude:  Double(obj.long1 ?? "0") ?? 0)
            marker.position = locationCordinate
            marker.icon = (i == 0 ? UIImage(named:"metroPin") : UIImage(named: "Noncoveredstation"))
            marker.map = mapView
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

            if let etaString = obj.etaNode2, let etaDate = dateFormatter.date(from: etaString) {
                dateFormatter.dateFormat = "hh:mm:ss"
                let formattedETA = dateFormatter.string(from: etaDate)
               
                marker.snippet =  "station_name".LocalizedString + ": \(obj.fromStationName ?? "")\n" + "txtStationNo".LocalizedString + "+: \(obj.edgeSrNo ?? 0)\n" +
                "txtETA".LocalizedString+": \(formattedETA)"
            } else {
                marker.snippet =  "station_name".LocalizedString+": \(obj.fromStationName ?? "")\n" + "txtStationNo".LocalizedString + "+: \(obj.edgeSrNo ?? 0)\n" +
                "txtETA".LocalizedString+": \(obj.etaNode2 ?? "")"
            }


            marker.userData = obj
            path.add(locationCordinate)
            // pathDifferentBlueLine.add(locationCordinate)
            arrMarker .append(marker)
            if i  == 0 {
                pathDifferentFrom.add(locationCordinate)
            }
        }
        if arr.count > 0 {
            let marker = GMSMarker()
            let locationCordinate = CLLocationCoordinate2D(latitude:Double(arr.last?.lat2 ?? "0") ?? 0, longitude:  Double(arr.last?.long2 ?? "0") ?? 0)
            marker.position = locationCordinate
            marker.icon = UIImage(named:"metroPin")
            marker.map = mapView
            marker.snippet = arr.last?.toStationName
            marker.userData = arr.last
            path.add(locationCordinate)
            arrMarker.append(marker)
            pathDifferentTO.add(locationCordinate)
            
            
        }
        if let obj = objJourney?.journeyPlannerStationDetail?.startingMYBYKPath{//objJourney?.journeyPlannerStationDetail?.startingMYBYKPath {
            let marker = GMSMarker()
            let locationCordinate = CLLocationCoordinate2D(latitude: Double(obj.decFromMYBYKStationLat ?? 0) , longitude:  Double(obj.decFromMYBYKStationLong ?? 0))
            marker.position = locationCordinate
            marker.icon = UIImage(named:"MapMYBike")
            marker.map = mapView
            marker.snippet = obj.strFromMYBYKStationName
            marker.userData = obj
            pathMYBikeFrom.add(locationCordinate)
            arrMarker.append(marker)
        }
        if let obj = objJourney?.journeyPlannerStationDetail?.startingMYBYKPath {
            let marker = GMSMarker()
            let locationCordinate = CLLocationCoordinate2D(latitude: Double(obj.decToMYBYKStationLat ?? 0) , longitude:  Double(obj.decToMYBYKStationLong ?? 0))
            marker.position = locationCordinate
            marker.icon = UIImage(named:"MapMYBike")
            marker.map = mapView
            marker.snippet = obj.strToMYBYKStationName
            marker.userData = obj
            pathMYBikeTo.add(locationCordinate)
            arrMarker.append(marker)
        }
        
        if let obj = objJourney?.journeyPlannerStationDetail?.endingMYBYKPath {
            let marker = GMSMarker()
            let locationCordinate = CLLocationCoordinate2D(latitude: Double(obj.decFromMYBYKStationLat ?? 0) , longitude:  Double(obj.decFromMYBYKStationLong ?? 0))
            marker.position = locationCordinate
            marker.icon = UIImage(named:"MapMYBike")
            marker.map = mapView
            marker.snippet = obj.strFromMYBYKStationName
            marker.userData = obj
            pathMYBikeFrom.add(locationCordinate)
            arrMarker.append(marker)
        }
        if let obj = objJourney?.journeyPlannerStationDetail?.endingMYBYKPath {
            let marker = GMSMarker()
            let locationCordinate = CLLocationCoordinate2D(latitude: Double(obj.decToMYBYKStationLat ?? 0) , longitude:  Double(obj.decToMYBYKStationLong ?? 0))
            marker.position = locationCordinate
            marker.icon = UIImage(named:"MapMYBike")
            marker.map = mapView
            marker.snippet = obj.strToMYBYKStationName
            marker.userData = obj
            pathMYBikeTo.add(locationCordinate)
            arrMarker.append(marker)
        }
        if objJourney?.journeyPlannerStationDetail?.modeOfFromStationTravel?.lowercased() == "a"{
            let marker = GMSMarker()
            let locationCordinate = CLLocationCoordinate2D(latitude: Double(objJourney?.journeyPlannerStationDetail?.decFromStationLat ?? 0) , longitude:  Double(objJourney?.journeyPlannerStationDetail?.decFromStationLat ?? 0))
            marker.position = locationCordinate
            marker.icon = UIImage(named:"Rickshaw")
            marker.map = mapView
            marker.snippet = objJourney?.journeyPlannerStationDetail?.strFromStationName
            //  marker.userData = obj
            pathMYBikeTo.add(locationCordinate)
            arrMarker.append(marker)
        }
        if objJourney?.journeyPlannerStationDetail?.modeOfToStationTravel?.lowercased() == "a"{
            let marker = GMSMarker()
            let locationCordinate = CLLocationCoordinate2D(latitude: Double(objJourney?.journeyPlannerStationDetail?.decToStationLat ?? 0) , longitude:  Double(objJourney?.journeyPlannerStationDetail?.decToStationLong ?? 0))
            marker.position = locationCordinate
            marker.icon = UIImage(named:"Rickshaw")
            marker.map = mapView
            marker.snippet = objJourney?.journeyPlannerStationDetail?.strToStationName
            //  marker.userData = obj
            pathMYBikeTo.add(locationCordinate)
            arrMarker.append(marker)
        }
        if let obj = objJourney?.journeyPlannerStationDetail {
            let marker = GMSMarker()
            let locationCordinate = CLLocationCoordinate2D(latitude: Double(obj.decToStationLat ?? 0) , longitude:  Double(obj.decToStationLong ?? 0))
            marker.position = locationCordinate
            marker.icon = UIImage(named:"toStation")
            marker.map = mapView
            marker.snippet = objStation?.to_locationname
           // marker.title = objStation?.to_locationname//obj.strToStationName
            marker.userData = obj
            
            pathDifferentTO.add(locationCordinate)
            arrMarker.append(marker)
        }
        print(arr)
        
        //        let rectangle = GMSPolyline(path: path)
        //        rectangle.strokeWidth = 5
        //        rectangle.strokeColor = UIColor(hexString:"#339A4E")
        //        rectangle.map = mapView
        //
        //        let rectanglefrom = GMSPolyline(path:pathDifferentFrom)
        //        rectanglefrom.strokeWidth = 5
        //        rectanglefrom.strokeColor = UIColor.blue.withAlphaComponent(0.5)
        //        rectanglefrom.map = mapView
        
        //
        //        let rectangleTo = GMSPolyline(path:pathDifferentTO)
        //        rectangleTo.strokeWidth = 5
        //        rectangleTo.strokeColor = UIColor.blue.withAlphaComponent(0.5)
        //        rectangleTo.map = mapView
        
        
        // modeOfToStationTravel - b -ending // greenline
        print(objJourney?.journeyPlannerStationDetail?.modeOfToStationTravel)
        
        // modeOfToStationTravel - b -string
        print(objJourney?.journeyPlannerStationDetail?.modeOfFromStationTravel)
        print(objJourney?.journeyPlannerStationDetail?.modeOfToStationTravel)
        
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            self.NGetMrtroTripDirection()
            //            self.BlueLineLatLong(decCurrentLat: self.objJourney?.journeyPlannerStationDetail?.decFromMetroStationLat ?? 0.0,
            //                                 decCurrentLong: self.objJourney?.journeyPlannerStationDetail?.decFromMetroStationLong ?? 0.0,
            //                                 decStationLat: self.objJourney?.journeyPlannerStationDetail?.decToMetroStationLat ?? 0.0,
            //                                 decStationLong: self.objJourney?.journeyPlannerStationDetail?.decToMetroStationLong ?? 0.0)
            
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            self.GreenLineLatLong(decCurrentLat: self.objJourney?.journeyPlannerStationDetail?.startingMYBYKPath?.decFromMYBYKStationLat ?? 0.0,
                                  decCurrentLong: self.objJourney?.journeyPlannerStationDetail?.startingMYBYKPath?.decFromMYBYKStationLong ?? 0.0,
                                  decStationLat: self.objJourney?.journeyPlannerStationDetail?.startingMYBYKPath?.decToMYBYKStationLat ?? 0.0,
                                  decStationLong: self.objJourney?.journeyPlannerStationDetail?.startingMYBYKPath?.decToMYBYKStationLong ?? 0.0)
            
        })
        
        if objJourney?.journeyPlannerStationDetail?.modeOfFromStationTravel?.lowercased() == "b"{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                self.StartMybykFromStationToFromMybyk(decCurrentLat:self.objJourney?.journeyPlannerStationDetail?.decFromStationLat ?? 0.0
                                                      ,decCurrentLong:self.objJourney?.journeyPlannerStationDetail?.decFromStationLong ?? 0.0
                                                      ,decStationLat:self.objJourney?.journeyPlannerStationDetail?.startingMYBYKPath?.decToMYBYKStationLat ?? 0.0
                                                      ,decStationLong:self.objJourney?.journeyPlannerStationDetail?.startingMYBYKPath?.decToMYBYKStationLong ?? 0.0)
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                self.startingFromMybykToMyByk(
                    decCurrentLat: self.objJourney?.journeyPlannerStationDetail?.startingMYBYKPath?.decFromMYBYKStationLat ?? 0.0,
                    decCurrentLong: self.objJourney?.journeyPlannerStationDetail?.startingMYBYKPath?.decFromMYBYKStationLong ?? 0.0,
                    decStationLat: self.objJourney?.journeyPlannerStationDetail?.startingMYBYKPath?.decToMYBYKStationLat ?? 0.0,
                    decStationLong: self.objJourney?.journeyPlannerStationDetail?.startingMYBYKPath?.decToMYBYKStationLong ?? 0.0)
            })
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                self.walkingFrom(decCurrentLat:self.objJourney?.journeyPlannerStationDetail?.decFromStationLat ?? 0.0
                                 ,decCurrentLong:self.objJourney?.journeyPlannerStationDetail?.decFromStationLong ?? 0.0
                                 ,decStationLat:self.objJourney?.journeyPlannerStationDetail?.decFromMetroStationLat ?? 0.0
                                 ,decStationLong:self.objJourney?.journeyPlannerStationDetail?.decFromMetroStationLong ?? 0.0)
            })
        }
        
        if objJourney?.journeyPlannerStationDetail?.modeOfToStationTravel?.lowercased() == "b"{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                
                // dotted
                self.EndMybykFromStationToFromMybyk(decCurrentLat:self.objJourney?.journeyPlannerStationDetail?.decToMetroStationLat ?? 0.0
                                                    ,decCurrentLong:self.objJourney?.journeyPlannerStationDetail?.decToMetroStationLong ?? 0.0
                                                    ,decStationLat:self.objJourney?.journeyPlannerStationDetail?.startingMYBYKPath?.decFromMYBYKStationLat ?? 0.0
                                                    ,decStationLong:self.objJourney?.journeyPlannerStationDetail?.startingMYBYKPath?.decFromMYBYKStationLong ?? 0.0)
            })
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                self.endingFromMybykToMyByk(
                    decCurrentLat: self.objJourney?.journeyPlannerStationDetail?.endingMYBYKPath?.decFromMYBYKStationLat ?? 0.0,
                    decCurrentLong: self.objJourney?.journeyPlannerStationDetail?.endingMYBYKPath?.decFromMYBYKStationLong ?? 0.0,
                    decStationLat: self.objJourney?.journeyPlannerStationDetail?.endingMYBYKPath?.decToMYBYKStationLat ?? 0.0,
                    decStationLong: self.objJourney?.journeyPlannerStationDetail?.endingMYBYKPath?.decToMYBYKStationLong ?? 0.0)
            })
        }
        if objJourney?.journeyPlannerStationDetail?.modeOfFromStationTravel?.lowercased() == "a"{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                self.FromRiskaToFromMetroStation(
                    decCurrentLat: self.objJourney?.journeyPlannerStationDetail?.decFromStationLat ?? 0.0,
                    decCurrentLong: self.objJourney?.journeyPlannerStationDetail?.decFromStationLong ?? 0.0,
                    decStationLat: self.objJourney?.journeyPlannerStationDetail?.decFromMetroStationLat ?? 0.0,
                    decStationLong: self.objJourney?.journeyPlannerStationDetail?.decFromMetroStationLong ?? 0.0)
            })
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                self.walkingFrom(decCurrentLat:self.objJourney?.journeyPlannerStationDetail?.decFromStationLat ?? 0.0
                                 ,decCurrentLong:self.objJourney?.journeyPlannerStationDetail?.decFromStationLong ?? 0.0
                                 ,decStationLat:self.objJourney?.journeyPlannerStationDetail?.decFromMetroStationLat ?? 0.0
                                 ,decStationLong:self.objJourney?.journeyPlannerStationDetail?.decFromMetroStationLong ?? 0.0)
            })
        }
         if  objJourney?.journeyPlannerStationDetail?.modeOfToStationTravel?.lowercased() == "a"{
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                self.ToRiskaToToMetroStation(
                    decCurrentLat: self.objJourney?.journeyPlannerStationDetail?.decToStationLat ?? 0.0,
                    decCurrentLong: self.objJourney?.journeyPlannerStationDetail?.decToStationLong ?? 0.0,
                    decStationLat: self.objJourney?.journeyPlannerStationDetail?.decToMetroStationLat ?? 0.0,
                    decStationLong: self.objJourney?.journeyPlannerStationDetail?.decToMetroStationLong ?? 0.0)
            })
        }
        else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                self.WalkingToDashLine(
                    decCurrentLat: self.objJourney?.journeyPlannerStationDetail?.decToMetroStationLat ?? 0.0,
                    decCurrentLong: self.objJourney?.journeyPlannerStationDetail?.decToMetroStationLong ?? 0.0,
                    decStationLat: self.objJourney?.journeyPlannerStationDetail?.decToStationLat ?? 0.0,
                    decStationLong: self.objJourney?.journeyPlannerStationDetail?.decToStationLong ?? 0.0)
            })
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            self.toMyBykToStation(
                decCurrentLat: self.objJourney?.journeyPlannerStationDetail?.endingMYBYKPath?.decToMYBYKStationLat ?? 0.0,
                decCurrentLong: self.objJourney?.journeyPlannerStationDetail?.endingMYBYKPath?.decToMYBYKStationLong ?? 0.0,
                decStationLat: self.objJourney?.journeyPlannerStationDetail?.decToStationLat ?? 0.0,
                decStationLong: self.objJourney?.journeyPlannerStationDetail?.decToStationLong ?? 0.0)
        })
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
        //            self.EndMyBykToMetro(
        //                decCurrentLat: self.objJourney?.journeyPlannerStationDetail?.startingMYBYKPath?.decToMYBYKStationLat ?? 0.0,
        //                decCurrentLong: self.objJourney?.journeyPlannerStationDetail?.startingMYBYKPath?.decToMYBYKStationLong ?? 0.0,
        //                decStationLat: self.objJourney?.journeyPlannerStationDetail?.decFromMetroStationLat ?? 0.0,
        //                decStationLong: self.objJourney?.journeyPlannerStationDetail?.decFromMetroStationLong ?? 0.0)
        //        })
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            self.startToMyBYKtoFromMetro(
                decCurrentLat: self.objJourney?.journeyPlannerStationDetail?.startingMYBYKPath?.decToMYBYKStationLat ?? 0.0,
                decCurrentLong: self.objJourney?.journeyPlannerStationDetail?.startingMYBYKPath?.decToMYBYKStationLong ?? 0.0,
                decStationLat: self.objJourney?.journeyPlannerStationDetail?.decFromMetroStationLat ?? 0.0,
                decStationLong: self.objJourney?.journeyPlannerStationDetail?.decFromMetroStationLong ?? 0.0)
        })
        btnShoPopup.isHidden = true
        self.tblView.reloadData()
    }
    //
    //    func addPolyLine(getPath: GMSMutablePath, encodedString:String!) {
    //
    //        let dotPath :GMSMutablePath = GMSMutablePath()
    //            // add coordinate to your path
    ////            dotPath.add(CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude))
    ////            dotPath.add(CLLocationCoordinate2DMake(dotCoordinate.latitude, dotCoordinate.longitude))
    //        self.path = GMSMutablePath(fromEncodedPath: encodedString)!
    //            let dottedPolyline  = GMSPolyline(path: getPath)
    //        dottedPolyline.map = mapView
    //        dottedPolyline.strokeWidth = 5.0
    //            let styles: [Any] = [GMSStrokeStyle.solidColor(UIColor.black), GMSStrokeStyle.solidColor(UIColor.clear)]
    //            let lengths: [Any] = [10, 5]
    //        dottedPolyline.spans = GMSStyleSpans(dottedPolyline.path!, styles as! [GMSStrokeStyle], lengths as! [NSNumber], GMSLengthKind.rhumb)
    //
    //
    //    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        //  self.constTblViewHeight?.constant = self.tblView.contentSize.height
        
        print("height:",self.tblView.contentSize.height)
    }
    
    @IBAction func actionFavourites(_ sender: UIButton) {
        
        let strlocation = (objStation?.from_locationname ?? "") + "|" + (objStation?.to_locationname ?? "")
        
        let strLatLong = "\(objJourney?.journeyPlannerStationDetail?.decFromStationLat ?? 0)" + "," +
        "\(objJourney?.journeyPlannerStationDetail?.decFromStationLong  ?? 0)" + "|" +
        "\(objJourney?.journeyPlannerStationDetail?.decToStationLat  ?? 0)" + "," +
        "\(objJourney?.journeyPlannerStationDetail?.decToStationLong  ?? 0)"
        
        
        if btnFav.isSelected {
            objViewModel.deleteFavourite(strLocationLatLong:strLatLong, completionHandler: { sucess in
                self.btnFav.isSelected = false
            })
        }else {
            objViewModel.saveFavouriteStation(strLocationLatLong: strLatLong, strLocation: strlocation) { sucess in
                self.btnFav.isSelected = true
            }
        }
        
        
        
    }
    
    
    @IBAction func actionShare(_ sender: Any) {
        
        var metroNumber = objJourney?.transitPaths?.first?.routeno ?? ""
        if metroNumber.isEmpty  || metroNumber == "NA"  || metroNumber == "N/A" {
            metroNumber = "Mumbai Metro"
        }
        
        let strMessage = String(format: "\("travelling_inn".LocalizedString) %@ \("from".LocalizedString) %@  \("to".LocalizedString) %@,",metroNumber,objJourney?.journeyPlannerStationDetail?.strFromStationName ?? "",objJourney?.journeyPlannerStationDetail?.strToStationName ?? "")
        
        let activityViewController = UIActivityViewController(activityItems: [ strMessage ], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = []
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
        //        if let firstPresented = UIStoryboard.ShareLocationVC() {
        //            firstPresented.modalTransitionStyle = .crossDissolve
        //            firstPresented.titleString = "sharebusdetails".LocalizedString
        //            firstPresented.isSharephoto = false
        //            firstPresented.isShareVoice = false
        //            firstPresented.messageString = strMessage
        //            firstPresented.isShowTrusedContacts = true
        //            firstPresented.isShareLocation = true
        //            firstPresented.topImage = #imageLiteral(resourceName: "shareLocation")
        //            firstPresented.modalPresentationStyle = .overCurrentContext
        //            APPDELEGATE.topViewController!.present(firstPresented, animated: false, completion: nil)
        //        }
    }
    
    
    @IBAction func actionRefersh(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy h:mm:ss a"
        let currentTime = dateFormatter.string(from: Date())
        lblLastUpdatedtime.text = "\(currentTime)"
        //        var param = [String:Any]()
        //        param["intUserID"] = Helper.shared.objloginData?.intUserID
        //        param["decFromStationLat"] =  "\(objJourney?.journeyPlannerStationDetail?.decFromStationLat ?? 0)"
        //        param["decFromStationLong"] =   "\(objJourney?.journeyPlannerStationDetail?.decFromStationLong ?? 0)"
        //        param["decToStationLat"] =  "\(objJourney?.journeyPlannerStationDetail?.decToStationLat ?? 0)"
        //        param["decToStationLong"] =  "\(objJourney?.journeyPlannerStationDetail?.decToStationLong ?? 0)"
        //        param["strStationName"] =  ""
        //
        //        self.objViewModel.getRefreshStation(param: param) { array in
        //            print(array)
        //        }
    }
    @objc func CallAPIfor1Minit()
    {
        print("api calling here......")
//        var param = [String:Any]()
//        param["intUserID"] = Helper.shared.objloginData?.intUserID
//        param["decFromStationLat"] =  "\(objJourney?.journeyPlannerStationDetail?.decFromStationLat ?? 0)"
//        param["decFromStationLong"] =   "\(objJourney?.journeyPlannerStationDetail?.decFromStationLong ?? 0)"
//        param["decToStationLat"] =  "\(objJourney?.journeyPlannerStationDetail?.decToStationLat ?? 0)"
//        param["decToStationLong"] =  "\(objJourney?.journeyPlannerStationDetail?.decToStationLong ?? 0)"
//        param["strStationName"] =  ""
//
//        self.objViewModel.getRefreshStation(param: param) { array in
//            print(array)
//        }
    }
    @IBAction func actiobBookNow(_ sender: Any) {
        
        let vc = UIStoryboard.PaymentVC()
        vc?.objJourney = objJourney
        vc?.fromType  = .JourneyPlanner
        vc?.isfromSuggestedItineratyVCPass = self.isfromSuggestedItineratyVC
        vc?.isfromUpwoedNewJourneyVcPass = self.isfromUpwoedNewJourneyVc
        self.navigationController?.pushViewController(vc!, animated:true)
    }
    
    
    @IBAction func actionSelectMapView(_ sender: UIButton) {
        sender.isSelected  = !sender.isSelected
        if sender.isSelected == true {
            sender.setTitle("tv_listView".LocalizedString, for: .normal)
            mapView.isHidden = false
          //  mapView.delegate = self
            tblView.isHidden  = true
            let buttonAbsoluteFrame = btnMapView.convert(btnMapView.bounds, to: self.view)
            let buttonPauNow = btnPayNow.convert(btnPayNow.bounds, to: self.view)
            self.constMapViewHeight.constant = buttonPauNow.origin.y - buttonAbsoluteFrame.origin.y - 70
            
            
            var bounds = GMSCoordinateBounds()
            let arr = objJourney?.transitPaths ?? [TransitPaths]()
            for obj in arr {
                let position = CLLocationCoordinate2D(latitude: ((obj.lat1 ?? "0") as? NSString)?.doubleValue ?? 0, longitude: ((obj.long1 ?? "0") as? NSString)?.doubleValue ?? 0)
                bounds = bounds.includingCoordinate(position)
            }
            
            if arr.count > 0 {
                let marker = GMSMarker()
                let position = CLLocationCoordinate2D(latitude:((arr.last?.lat2 ?? "0") as? NSString)?.doubleValue ?? 0, longitude:((arr.last?.long2 ?? "0") as? NSString)?.doubleValue ?? 0)
                arrMarker .append(marker)
            }
            let update = GMSCameraUpdate.fit(bounds, withPadding: 30.0)
            self.mapView.animate(with: update)
            DispatchQueue.main.async {
                self.mapView.animate(toZoom:11.5)
            }
            btnShoPopup.isHidden = false
            
        }else{
            sender.setTitle("mapview".LocalizedString, for: .normal)
            mapView.isHidden = true
            tblView.isHidden  = false
            btnShoPopup.isHidden = true
        }
    }
    @IBAction func btnShowPopUp(_ sender: UIButton) {
        let root = UIWindow.key?.rootViewController!
        if let firstPresented = UIStoryboard.InformationVC() {
            firstPresented.modalTransitionStyle = .crossDissolve
            firstPresented.modalPresentationStyle = .overCurrentContext
            root?.present(firstPresented, animated: false, completion: nil)
        }
    }
    func getFromStationImage()->UIImage? {
        if objJourney?.journeyPlannerStationDetail?.modeOfFromStationTravel == "T" {
            return UIImage(named: "Taxi")
        }
        else if objJourney?.journeyPlannerStationDetail?.modeOfFromStationTravel == "A" {
            return  UIImage(named: "Rickshaw")
        }else {
            return UIImage(named: "Walk")
        }
    }
    func getTOStationImage()->UIImage? {
        if objJourney?.journeyPlannerStationDetail?.modeOfToStationTravel == "A" {
            return UIImage(named: "Rickshaw")
        }
        else if objJourney?.journeyPlannerStationDetail?.modeOfToStationTravel == "T" {
            return UIImage(named: "Taxi")
        }else {
            return UIImage(named: "Walk")
        }
    }
    
    
}
extension PlanjourneyRouetDetailsVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier:"RouteDetailHeaderCell") as? RouteDetailHeaderCell else  { return UITableViewCell() }
            DispatchQueue.main.async {
                self.tblView.layoutIfNeeded()
            }
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier:"JourneyPlannerRouteDetailCell") as? JourneyPlannerRouteDetailCell else  { return UITableViewCell() }
            
            print("tableview show the data:- \(objJourney?.journeyPlannerStationDetail?.strFromStationName)")
            if (objJourney?.transitPaths?.count ?? 0) > 2{
                cell.btnShowRoutes.isHidden = false
            }else{
                cell.btnShowRoutes.isHidden = true
            }
            cell.btnPrice .setTitle("Rs.\(objJourney?.journeyPlannerStationDetail?.fare ?? 0)", for: .normal)
            cell.lblStatioName.text = objJourney?.journeyPlannerStationDetail?.strFromStationName
            cell.lbltime.text =  (objJourney?.journeyPlannerStationDetail?.stationArrival ?? "").getCurrentDatewithDash().toString(withFormat:"hh:mm a")
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            let currentTime = dateFormatter.string(from: Date())
            
            if cell.lbltime.text == currentTime{
                
            }
            
            cell.btnPrice.setTitle("\(objJourney?.journeyPlannerStationDetail?.fare ?? 0) Rs.", for: .normal)
            cell.lbDistance.text = "\(objJourney?.journeyPlannerStationDetail?.km ?? 0) KM"
            cell.lblFromFare.text = "\(objJourney?.journeyPlannerStationDetail?.fareOfFromStationTravel ?? 0) Rs"
            cell.lblfromDistance.text = "\(objJourney?.journeyPlannerStationDetail?.fromStationWalkDistance ?? 0) KM"
            cell.lblToFare.text = "\(objJourney?.journeyPlannerStationDetail?.fareOfToStationTravel ?? 0) Rs"
            cell.lblToDistance.text = "\(objJourney?.journeyPlannerStationDetail?.toStationWalkDistance ?? 0) KM"
            
            if objJourney?.journeyPlannerStationDetail?.fareOfFromStationTravel ?? 0 < 1 {
                cell.lblFromFare.isHidden = true
            }
            
            if objJourney?.journeyPlannerStationDetail?.fareOfToStationTravel ?? 0 < 1 {
                cell.lblToFare.isHidden = true
            }
            
            cell.imgStartWalk.image = self.getFromStationImage()
            cell.imgEndWalk.image = self.getTOStationImage()
            
            if let obj = objJourney?.journeyPlannerStationDetail?.endingMYBYKPath {
                cell.lblTOSTation1.text = obj.strFromMYBYKStationName ?? ""
                cell.lblTOSTation2.text = obj.strToMYBYKStationName ?? ""
                cell.lblToDistance.text =  String(format:"%0.2f", obj.decFromMYBYKStationDistance ?? 0) + " KM"
                cell.lblTODistance1.text = String(format:"%0.2f", obj.decFrom_ToMYBYKStationDistance ?? 0) + " KM"
                cell.lblTODistance2.text = String(format:"%0.3f", obj.decToMYBYKStationDistance ?? 0) + " KM"
                
                cell.lblTOTime1.text =  (obj.strFromHubArrival ?? "").getCurrentDatewithDash().toString(withFormat:"hh:mm a")
                cell.lblTOTime2.text =  (obj.strToHubArrival ?? "").getCurrentDatewithDash().toString(withFormat:"hh:mm a")
                
                cell.imgBottom1.image = UIImage(named:"myBike")
                cell.imgBottom2.image = UIImage(named:"myBike")
                cell.btnMyBikeBottom.isHidden = false
                //                if obj.decFrom_ToMYBYKStationDistance ?? 0 < 1{
                //                    cell.imgBottom1.image = UIImage(named:"Walk")
                //                    cell.btnMyBikeBottom.isHidden = true
                //                }
                //                if obj.decToMYBYKStationDistance ?? 0 < 1{
                //                    cell.imgBottom2.image = UIImage(named:"Walk")
                //                    cell.btnMyBikeBottom.isHidden = true
                //                }
                //                cell.imgTop1.image = UIImage(named:"myBike")
                //                cell.imgTop2.image = UIImage(named:"myBike")
                //                cell.btnMyBikeTop.isHidden = false
                //
                //                if obj.decFrom_ToMYBYKStationDistance ?? 0 < 1{
                //                    cell.imgTop1.image = UIImage(named:"Walk")
                //                    cell.btnMyBikeTop.isHidden = true
                //                }
                //                if obj.decToMYBYKStationDistance ?? 0 < 1{
                //                    cell.imgTop2.image = UIImage(named:"Walk")
                //                    cell.btnMyBikeTop.isHidden = true
                //                }
            }else {
               
                cell.lblTOSTation1.superview?.superview?.superview?.isHidden = true
                cell.lblTOSTation2.superview?.superview?.superview?.isHidden = true
            }
            
            if let obj = objJourney?.journeyPlannerStationDetail?.startingMYBYKPath {
                cell.lblFromSTation1.text = obj.strFromMYBYKStationName ?? ""
                cell.lblFromSTation2.text = obj.strToMYBYKStationName ?? ""
                cell.lblfromDistance.text =  String(format:"%0.2f", obj.decFromMYBYKStationDistance ?? 0) + " KM"
                cell.lblFromDistance1.text = String(format:"%0.2f", obj.decFrom_ToMYBYKStationDistance ?? 0) + " KM"
                cell.lblFromDistance2.text = String(format:"%0.3f", obj.decToMYBYKStationDistance ?? 0) + " KM"
                
                cell.lblFromTime1.text =  (obj.strFromHubArrival ?? "").getCurrentDatewithDash().toString(withFormat:"hh:mm a")
                cell.lblFromTime2.text =  (obj.strToHubArrival ?? "").getCurrentDatewithDash().toString(withFormat:"hh:mm a")
                
                cell.imgTop1.image = UIImage(named:"myBike")
                cell.imgTop2.image = UIImage(named:"myBike")
                cell.btnMyBikeTop.isHidden = false
                
                //                if obj.decFrom_ToMYBYKStationDistance ?? 0 < 1{
                //                    cell.imgTop1.image = UIImage(named:"Walk")
                //                    cell.btnMyBikeTop.isHidden = true
                //                }
                //                if obj.decToMYBYKStationDistance ?? 0 < 1{
                //                    cell.imgTop2.image = UIImage(named:"Walk")
                //                    cell.btnMyBikeTop.isHidden = true
                //                }
                //                cell.imgBottom1.image = UIImage(named:"myBike")
                //                cell.imgBottom2.image = UIImage(named:"myBike")
                //                cell.btnMyBikeBottom.isHidden = false
                //                if obj.decFrom_ToMYBYKStationDistance ?? 0 < 1{
                //                    cell.imgBottom1.image = UIImage(named:"Walk")
                //                    cell.btnMyBikeBottom.isHidden = true
                //                }
                //                if obj.decToMYBYKStationDistance ?? 0 < 1{
                //                    cell.imgBottom2.image = UIImage(named:"Walk")
                //                    cell.btnMyBikeBottom.isHidden = true
                //                }
            }else {
                cell.lblFromSTation1.superview?.superview?.superview?.isHidden = true
                cell.lblFromSTation2.superview?.superview?.superview?.isHidden = true
            }
            
            
            cell.lblVehchcileStatus.text = "strNotArrived".LocalizedString
            cell.lblToStatus.text = "strNotArrived".LocalizedString
            cell.imgViewLine.tintColor = UIColor.blue
            cell.imgViewToLine.tintColor = UIColor.blue
            if objJourney?.transitPaths?.first?.bCovered1 == "1" {
                cell.btnNotify.superview?.isHidden = true
                cell.lblVehchcileStatus.text = "strArrived".LocalizedString
                cell.imgViewLine.tintColor = UIColor.greenColor
            }
            
            cell.btnNotify.backgroundColor = UIColor.white
            cell.btnNotify .setTitleColor(UIColor.greenColor, for: .normal)
            cell.btnToNOtify.backgroundColor = UIColor.white
            cell.btnToNOtify .setTitleColor(UIColor.greenColor, for: .normal)
            if objJourney?.transitPaths?.first?.bNotify1 ?? false {
                cell.btnNotify.backgroundColor =  UIColor.greenColor
                cell.btnNotify.setTitleColor(UIColor.white, for: .normal)
            }
            
            
            let arrOriginal = objJourney?.transitPaths ?? [TransitPaths]()
            var arrNew = objJourney?.transitPaths ?? [TransitPaths]()
            if arrNew.count > 0 {
                arrNew.removeFirst()
            }
            cell.arrOriginal = objJourney?.transitPaths ??  [TransitPaths]()
            cell.lblToStation.text = arrOriginal.last?.toStationName
            cell.lblToTime.text =  (arrOriginal.last?.etaNode2 ?? "").getCurrentDatewithDash().toString(withFormat:"hh:mm a")
            if arrOriginal.last?.bCovered2 == "1" {
                cell.btnToNOtify.superview?.isHidden = true
                cell.lblToStatus.text = "strArrived".LocalizedString
                cell.imgViewToLine.tintColor = UIColor.greenColor
            }
            if arrOriginal.last?.bNotify2 ?? false {
                cell.btnToNOtify.backgroundColor =  UIColor.greenColor
                cell.btnToNOtify.setTitleColor(UIColor.white, for: .normal)
            }
            cell.arrRoutePaths = arrNew
            
          
                cell.lblFromStation.text = PassFullnameFrom //objJourney?.journeyPlannerStationDetail?.strFromStationName
                cell.lblMainToStation.text = PassFullnameTo
            
//            objJourney?.journeyPlannerStationDetail?.strToStationName
//            cell.lblFromStation.text = objStation?.from_locationname
//            cell.lblMainToStation.text = objStation?.to_locationname
            cell.btnNotify.tag = 0
            //            cell.btnNotify.tag = indexPath.row
            DispatchQueue.main.async {
                self.constTblViewHeight.constant = tableView.contentSize.height
            }
            tblView.layoutIfNeeded()
            cell.completionBlockData = {
                
                cell.lbltime.text = (arrNew[indexPath.row].etaNode1 ?? "").getCurrentDatewithDash().toString(withFormat:"hh:mm a")
                DispatchQueue.main.async {
                    self.tblView.beginUpdates()
                    self.tblView.endUpdates()
                    print("height:",self.tblView.contentSize.height)
                    self.constTblViewHeight.constant = self.tblView.contentSize.height
                    print("height11:",self.tblView.contentSize.height)
                    self.scrollview.layoutIfNeeded()
                    self.scrollview.contentSize = self.scrollview.subviews.reduce(CGRect.zero, {
                        return $0.union($1.frame)
                    }).size
                    
                    DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.3, execute:{
                        self.tblView.beginUpdates()
                        self.tblView.endUpdates()
                        self.constTblViewHeight.constant = self.tblView.contentSize.height
                        self.scrollview.layoutIfNeeded()
                        self.scrollview.contentSize = self.scrollview.subviews.reduce(CGRect.zero, {
                            return $0.union($1.frame)
                        }).size
                    })
                }
            }
            
            cell.completionBlockNotify = { obj,number in
                if let obj = obj {
                    let root = UIWindow.key?.rootViewController!
                    if let firstPresented = UIStoryboard.ReminderVC() {
                        firstPresented.obj = obj
                        firstPresented.routeid = obj.routeid
                        firstPresented.tripID = obj.tripId
                        firstPresented.completionNotifyAction = { indexpath,obj,count,isSave in
                            
                            
                            if let objTransitPaths = obj as? TransitPaths {
                                let arrOriginal = self.objJourney?.transitPaths ?? [TransitPaths]()
                                let index = arrOriginal.firstIndex { objInside in
                                    if number == 0 {
                                        return objInside.fromStationId == objTransitPaths.fromStationId
                                    }else {
                                        return objInside.toStationId == objTransitPaths.fromStationId
                                    }
                                    
                                }
                                if index != nil {
                                    if number == 0 {
                                        self.objJourney?.transitPaths?[index!].bNotify1 = (count ?? 0) > 0 ? true : false
                                    }else {
                                        self.objJourney?.transitPaths?[index!].bNotify2 = (count ?? 0) > 0 ? true : false
                                    }
                                    self.tblView.reloadData()
                                }
                            }
                            
                            
                            let firstPresented = AlertViewVC(nibName:"AlertViewVC", bundle: nil)
                            firstPresented.strMessage = isSave ? "sucess_reminder".LocalizedString :"removeReminder".LocalizedString
                            firstPresented.img = UIImage(named:"Success")!
                            firstPresented.isHideCancel = true
                            firstPresented.okButtonTitle = "ok".LocalizedString
                            firstPresented.completionOK = {
                                self.dismiss(animated: true) {
                                }
                            }
                            firstPresented.modalTransitionStyle = .crossDissolve
                            firstPresented.modalPresentationStyle = .overCurrentContext
                            APPDELEGATE.topViewController!.present(firstPresented, animated: true, completion: nil)
                        }
                        //                        firstPresented.completionNotifyRemove = { indexpath,obj,count in
                        //                           // if let index = indexpath {
                        //                           // self.objJourney?.transitPaths?[indexpath!.row].bNotify1 = false
                        //                             //   self.tblView.reloadData()
                        //
                        //                            if let objTransitPaths = obj as? TransitPaths {
                        //                                let arrOriginal = self.objJourney?.transitPaths ?? [TransitPaths]()
                        //                                let index = arrOriginal.firstIndex { objInside in
                        //                                    return objInside.fromStationId == objTransitPaths.fromStationId
                        //                                }
                        //                                if index != nil {
                        //                                    self.objJourney?.transitPaths?[index!].bNotify1 = (count ?? 0) > 0 ? true : false
                        //                                    self.tblView.reloadData()
                        //                                }
                        //                            }
                        //
                        //
                        //
                        //
                        ////                            cell.btnNotify.backgroundColor = UIColor.white
                        ////                            cell.btnNotify .setTitleColor(UIColor.greenColor, for: .normal)
                        ////
                        ////                            cell.btnToNOtify.backgroundColor = UIColor.white
                        ////                            cell.btnToNOtify .setTitleColor(UIColor.greenColor, for: .normal)
                        //
                        //                                let firstPresented = AlertViewVC(nibName:"AlertViewVC", bundle: nil)
                        //                                firstPresented.strMessage = "removeReminder".LocalizedString
                        //                                firstPresented.img = UIImage(named:"Success")!
                        //                                firstPresented.isHideCancel = true
                        //                                firstPresented.okButtonTitle = "ok".LocalizedString
                        //                                firstPresented.completionOK = {
                        //                                    self.dismiss(animated: true) {
                        //
                        //                                    }
                        //                                }
                        //                                firstPresented.modalTransitionStyle = .crossDissolve
                        //                                firstPresented.modalPresentationStyle = .overCurrentContext
                        //                                APPDELEGATE.topViewController!.present(firstPresented, animated: true, completion: nil)
                        //
                        //
                        //                           // }
                        //                        }
                        firstPresented.modalTransitionStyle = .crossDissolve
                        firstPresented.modalPresentationStyle = .overCurrentContext
                        root?.present(firstPresented, animated: false, completion: nil)
                        
                    }
                }
            }
            
            //            cell.completionBlockOFAlternatives = {
            //
            //                                let root = UIWindow.key?.rootViewController!
            //                                if let firstPresented = UIStoryboard.AlertaltivesVC() {
            //                                    firstPresented.modalTransitionStyle = .crossDissolve
            //                                    firstPresented.modalPresentationStyle = .overCurrentContext
            //                                    root?.present(firstPresented, animated: false, completion: nil)
            //                                }
            //            }
            
            
            
            
            //            cell.isShowTable = { isShow in
            //                self.constTblViewHeight.constant = self.tblView.contentSize.height
            //                self.tblView.layoutIfNeeded()
            //                self.tblView.beginUpdates()
            //                self.tblView.endUpdates()
            //            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}

extension PlanjourneyRouetDetailsVC {
    func addPolyLineBlue(encodedString: String,objDestination:JourneyPlannerModel?) {
        //        self.pathDifferentBlueLine = GMSMutablePath(fromEncodedPath: encodedString)!
        //        let polyline = GMSPolyline(path: pathDifferentBlueLine)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            let polyline = GMSPolyline(path:GMSMutablePath(fromEncodedPath: encodedString)!)
            polyline.strokeWidth = 5
            polyline.strokeColor = UIColor(hexString: "#5EA7FF")
            polyline.map = self.mapView
        })
        
    }
    func addPolyLineGreen(encodedString: String,objDestination:JourneyPlannerModel?) {
        self.path = GMSMutablePath(fromEncodedPath: encodedString)!
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 5
        polyline.strokeColor = UIColor(hexString: "#339A4E")
        polyline.map = mapView
        
    }
    func addPolyLineBlack(encodedString: String,objDestination:JourneyPlannerModel?) {
        //        self.pathDifferentBlueLine = GMSMutablePath(fromEncodedPath: encodedString)!
        //        let polyline = GMSPolyline(path: pathDifferentBlueLine)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            let polyline = GMSPolyline(path:GMSMutablePath(fromEncodedPath: encodedString)!)
            polyline.strokeWidth = 5
            polyline.strokeColor = .black
            polyline.map = self.mapView
        })
        
    }
    func addPolyLineDashLineFrom(encodedString: String,objDestination:JourneyPlannerModel?) {
        self.pathDifferentFrom = GMSMutablePath(fromEncodedPath: encodedString)!
        let polyline = GMSPolyline(path: pathDifferentFrom)
        polyline.strokeWidth = 5.0
        polyline.strokeColor = .black
        let dashPattern = [NSNumber(value: 8), NSNumber(value: 5)]
        polyline.spans = GMSStyleSpans(polyline.path!, [GMSStrokeStyle.solidColor(.black), GMSStrokeStyle.solidColor(.clear)], dashPattern, .rhumb)
        polyline.map = mapView
        
    }
    func addPolyLineToDashLine(encodedString: String,objDestination:JourneyPlannerModel?) {
        self.pathDifferentTO = GMSMutablePath(fromEncodedPath: encodedString)!
        let polyline = GMSPolyline(path: pathDifferentTO)
        polyline.strokeWidth = 5.0
        polyline.strokeColor = .black
        let dashPattern = [NSNumber(value: 8), NSNumber(value: 5)]
        polyline.spans = GMSStyleSpans(polyline.path!, [GMSStrokeStyle.solidColor(.black), GMSStrokeStyle.solidColor(.clear)], dashPattern, .rhumb)
        polyline.map = mapView
        
    }
    
    func animationView(){
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            self.view.layoutSubviews()
            
        }
    }
    func walkingFrom(decCurrentLat:Double,decCurrentLong:Double,decStationLat:Double,decStationLong:Double){
        var paramDashLineFrom = [String:Any]()
        paramDashLineFrom["decCurrentLat"] =  objJourney?.journeyPlannerStationDetail?.decFromStationLat
        paramDashLineFrom["decCurrentLong"] = objJourney?.journeyPlannerStationDetail?.decFromStationLong
        paramDashLineFrom["decStationLat"] =  objJourney?.journeyPlannerStationDetail?.decFromMetroStationLat
        paramDashLineFrom["decStationLong"] = objJourney?.journeyPlannerStationDetail?.decFromMetroStationLong
        paramDashLineFrom["intTransportModeID"] =  1
        
        self.objBlueLine.getDirectionStationJourneyPlanner(param: paramDashLineFrom) { responseDict in
            if let routes = responseDict?["routes"] as? [[String:Any]] {
                let routes = (routes.first as Dictionary<String, AnyObject>?) ?? [:]
                let overviewPolyline = (routes["overview_polyline"] as? Dictionary<String,AnyObject>) ?? [:]
                let polypoints = (overviewPolyline["points"] as? String) ?? ""
                let line  = polypoints
                self.addPolyLineDashLineFrom(encodedString: line, objDestination: self.objJourney)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
                    let bounds = GMSCoordinateBounds(path: self.path)
                    self.mapView!.animate(with: GMSCameraUpdate.fit(bounds, withPadding:0.0))
                    self.animationView()
                })
                
            }
        }
    }
    func BlueLineLatLong(decCurrentLat:Double ,decCurrentLong:Double,decStationLat:Double, decStationLong:Double){
        var param = [String:Any]()
        param["decCurrentLat"] =  decCurrentLat
        param["decCurrentLong"] = decCurrentLong
        param["decStationLat"] =  decStationLat
        param["decStationLong"] = decStationLong
        param["intTransportModeID"] =  2
        self.objBlueLine.getDirectionStationJourneyPlanner(param: param) { responseDict in
            if let routes = responseDict?["routes"] as? [[String:Any]] {
                let routes = (routes.first as Dictionary<String, AnyObject>?) ?? [:]
                let overviewPolyline = (routes["overview_polyline"] as? Dictionary<String,AnyObject>) ?? [:]
                let polypoints = (overviewPolyline["points"] as? String) ?? ""
                let line  = polypoints
                self.addPolyLineBlue(encodedString: line, objDestination: self.objJourney)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
                    let bounds = GMSCoordinateBounds(path: self.path)
                    self.mapView!.animate(with: GMSCameraUpdate.fit(bounds, withPadding:0.0))
                    self.animationView()
                })
            }
        }
    }
    
    func NGetMrtroTripDirection(){
        var param = [String:Any]()
        param["intTripID"] =  objJourney?.transitPaths?.first?.tripId
        param["intFromStationID"] = self.objJourney?.journeyPlannerStationDetail?.intFromStationID
        param["intToStationID"] =  self.objJourney?.journeyPlannerStationDetail?.intToStationID
        self.objBlueLine.getGetMetroTripDirectionJourneyPlanner(param: param) { responseDict in
            if let responseDict = responseDict,
               let dataArray = responseDict["data"] as? [[String:Any]]{
                
                print(dataArray)
                
                for item in dataArray {
                    if let geoPolygonlineGeometry = item["geoPolygonlineGeometry"] as? String {
                        print(geoPolygonlineGeometry)
                        let polypoints = geoPolygonlineGeometry
                        let line  = polypoints
                        self.addPolyLineBlue(encodedString: line, objDestination: self.objJourney)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
                            let bounds = GMSCoordinateBounds(path: self.path)
                            self.mapView!.animate(with: GMSCameraUpdate.fit(bounds, withPadding:0.0))
                            self.animationView()
                        })
                    }
                }
            }
        }
    }
    func GreenLineLatLong(decCurrentLat:Double ,decCurrentLong:Double,decStationLat:Double, decStationLong:Double){
        var param = [String:Any]()
        param["decCurrentLat"] =  decCurrentLat
        param["decCurrentLong"] = decCurrentLong
        param["decStationLat"] =  decStationLat
        param["decStationLong"] = decStationLong
        param["intTransportModeID"] =  2
        self.objBlueLine.getDirectionStationJourneyPlanner(param: param) { responseDict in
            if let routes = responseDict?["routes"] as? [[String:Any]] {
                let routes = (routes.first as Dictionary<String, AnyObject>?) ?? [:]
                let overviewPolyline = (routes["overview_polyline"] as? Dictionary<String,AnyObject>) ?? [:]
                let polypoints = (overviewPolyline["points"] as? String) ?? ""
                let line  = polypoints
                self.addPolyLineBlue(encodedString: line, objDestination: self.objJourney)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
                    let bounds = GMSCoordinateBounds(path: self.path)
                    self.mapView!.animate(with: GMSCameraUpdate.fit(bounds, withPadding:0.0))
                    self.animationView()
                })
            }
        }
    }
    func WalkingToDashLine(decCurrentLat:Double,decCurrentLong:Double,decStationLat:Double,decStationLong:Double){
        var paramDashLineFrom = [String:Any]()
        paramDashLineFrom["decCurrentLat"] =  decCurrentLat
        paramDashLineFrom["decCurrentLong"] = decCurrentLong
        paramDashLineFrom["decStationLat"] =  decStationLat
        paramDashLineFrom["decStationLong"] = decStationLong
        paramDashLineFrom["intTransportModeID"] =  1
        
        
        self.objBlueLine.getDirectionStationJourneyPlanner(param: paramDashLineFrom) { responseDict in
            
            if let routes = responseDict?["routes"] as? [[String:Any]] {
                let routes = (routes.first as Dictionary<String, AnyObject>?) ?? [:]
                let overviewPolyline = (routes["overview_polyline"] as? Dictionary<String,AnyObject>) ?? [:]
                let polypoints = (overviewPolyline["points"] as? String) ?? ""
                let line  = polypoints
                self.addPolyLineToDashLine(encodedString: line, objDestination: self.objJourney)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
                    let bounds = GMSCoordinateBounds(path: self.path)
                    self.mapView!.animate(with: GMSCameraUpdate.fit(bounds, withPadding:0.0))
                    self.animationView()
                })
                
            }
        }
    }
    
    
    func StartMybykFromStationToFromMybyk(decCurrentLat:Double,decCurrentLong:Double,decStationLat:Double,decStationLong:Double){
        var paramDashLineFrom = [String:Any]()
        paramDashLineFrom["decCurrentLat"] =  decCurrentLat
        paramDashLineFrom["decCurrentLong"] = decCurrentLong
        paramDashLineFrom["decStationLat"] =  decStationLat
        paramDashLineFrom["decStationLong"] = decStationLong
        paramDashLineFrom["intTransportModeID"] =  1
        
        
        self.objBlueLine.getDirectionStationJourneyPlanner(param: paramDashLineFrom) { responseDict in
            
            if let routes = responseDict?["routes"] as? [[String:Any]] {
                let routes = (routes.first as Dictionary<String, AnyObject>?) ?? [:]
                let overviewPolyline = (routes["overview_polyline"] as? Dictionary<String,AnyObject>) ?? [:]
                let polypoints = (overviewPolyline["points"] as? String) ?? ""
                let line  = polypoints
                self.addPolyLineGreen(encodedString: line, objDestination: self.objJourney)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
                    let bounds = GMSCoordinateBounds(path: self.path)
                    self.mapView!.animate(with: GMSCameraUpdate.fit(bounds, withPadding:0.0))
                    self.animationView()
                })
                
            }
        }
    }
    
    func EndMybykFromStationToFromMybyk(decCurrentLat:Double,decCurrentLong:Double,decStationLat:Double,decStationLong:Double){
        var paramDashLineFrom = [String:Any]()
        paramDashLineFrom["decCurrentLat"] =  decCurrentLat
        paramDashLineFrom["decCurrentLong"] = decCurrentLong
        paramDashLineFrom["decStationLat"] =  decStationLat
        paramDashLineFrom["decStationLong"] = decStationLong
        paramDashLineFrom["intTransportModeID"] =  1
        
        
        self.objBlueLine.getDirectionStationJourneyPlanner(param: paramDashLineFrom) { responseDict in
            
            if let routes = responseDict?["routes"] as? [[String:Any]] {
                let routes = (routes.first as Dictionary<String, AnyObject>?) ?? [:]
                let overviewPolyline = (routes["overview_polyline"] as? Dictionary<String,AnyObject>) ?? [:]
                let polypoints = (overviewPolyline["points"] as? String) ?? ""
                let line  = polypoints
                self.addPolyLineToDashLine(encodedString: line, objDestination: self.objJourney)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
                    let bounds = GMSCoordinateBounds(path: self.path)
                    self.mapView!.animate(with: GMSCameraUpdate.fit(bounds, withPadding:0.0))
                    self.animationView()
                })
                
            }
        }
    }
    func startingFromMybykToMyByk(decCurrentLat:Double,decCurrentLong:Double,decStationLat:Double,decStationLong:Double){
        var paramDashLineFrom = [String:Any]()
        paramDashLineFrom["decCurrentLat"] =  decCurrentLat
        paramDashLineFrom["decCurrentLong"] = decCurrentLong
        paramDashLineFrom["decStationLat"] =  decStationLat
        paramDashLineFrom["decStationLong"] = decStationLong
        paramDashLineFrom["intTransportModeID"] =  1
        
        
        self.objBlueLine.getDirectionStationJourneyPlanner(param: paramDashLineFrom) { responseDict in
            
            if let routes = responseDict?["routes"] as? [[String:Any]] {
                let routes = (routes.first as Dictionary<String, AnyObject>?) ?? [:]
                let overviewPolyline = (routes["overview_polyline"] as? Dictionary<String,AnyObject>) ?? [:]
                let polypoints = (overviewPolyline["points"] as? String) ?? ""
                let line  = polypoints
                self.addPolyLineGreen(encodedString: line, objDestination: self.objJourney)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
                    let bounds = GMSCoordinateBounds(path: self.path)
                    self.mapView!.animate(with: GMSCameraUpdate.fit(bounds, withPadding:0.0))
                    self.animationView()
                })
                
            }
        }
    }
    func endingFromMybykToMyByk(decCurrentLat:Double,decCurrentLong:Double,decStationLat:Double,decStationLong:Double){
        var paramDashLineFrom = [String:Any]()
        paramDashLineFrom["decCurrentLat"] =  decCurrentLat
        paramDashLineFrom["decCurrentLong"] = decCurrentLong
        paramDashLineFrom["decStationLat"] =  decStationLat
        paramDashLineFrom["decStationLong"] = decStationLong
        paramDashLineFrom["intTransportModeID"] =  1
        
        
        self.objBlueLine.getDirectionStationJourneyPlanner(param: paramDashLineFrom) { responseDict in
            
            if let routes = responseDict?["routes"] as? [[String:Any]] {
                let routes = (routes.first as Dictionary<String, AnyObject>?) ?? [:]
                let overviewPolyline = (routes["overview_polyline"] as? Dictionary<String,AnyObject>) ?? [:]
                let polypoints = (overviewPolyline["points"] as? String) ?? ""
                let line  = polypoints
                self.addPolyLineGreen(encodedString: line, objDestination: self.objJourney)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
                    let bounds = GMSCoordinateBounds(path: self.path)
                    self.mapView!.animate(with: GMSCameraUpdate.fit(bounds, withPadding:0.0))
                    self.animationView()
                })
                
            }
        }
    }
    func toMyBykToStation(decCurrentLat:Double,decCurrentLong:Double,decStationLat:Double,decStationLong:Double){
        var paramDashLineFrom = [String:Any]()
        paramDashLineFrom["decCurrentLat"] =  decCurrentLat
        paramDashLineFrom["decCurrentLong"] = decCurrentLong
        paramDashLineFrom["decStationLat"] =  decStationLat
        paramDashLineFrom["decStationLong"] = decStationLong
        paramDashLineFrom["intTransportModeID"] =  1
        
        
        self.objBlueLine.getDirectionStationJourneyPlanner(param: paramDashLineFrom) { responseDict in
            
            if let routes = responseDict?["routes"] as? [[String:Any]] {
                let routes = (routes.first as Dictionary<String, AnyObject>?) ?? [:]
                let overviewPolyline = (routes["overview_polyline"] as? Dictionary<String,AnyObject>) ?? [:]
                let polypoints = (overviewPolyline["points"] as? String) ?? ""
                let line  = polypoints
                self.addPolyLineToDashLine(encodedString: line, objDestination: self.objJourney)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
                    let bounds = GMSCoordinateBounds(path: self.path)
                    self.mapView!.animate(with: GMSCameraUpdate.fit(bounds, withPadding:0.0))
                    self.animationView()
                })
                
            }
        }
    }
    
    func EndMyBykToMetro(decCurrentLat:Double,decCurrentLong:Double,decStationLat:Double,decStationLong:Double){
        var paramDashLineFrom = [String:Any]()
        paramDashLineFrom["decCurrentLat"] =  decCurrentLat
        paramDashLineFrom["decCurrentLong"] = decCurrentLong
        paramDashLineFrom["decStationLat"] =  decStationLat
        paramDashLineFrom["decStationLong"] = decStationLong
        paramDashLineFrom["intTransportModeID"] =  1
        
        
        self.objBlueLine.getDirectionStationJourneyPlanner(param: paramDashLineFrom) { responseDict in
            
            if let routes = responseDict?["routes"] as? [[String:Any]] {
                let routes = (routes.first as Dictionary<String, AnyObject>?) ?? [:]
                let overviewPolyline = (routes["overview_polyline"] as? Dictionary<String,AnyObject>) ?? [:]
                let polypoints = (overviewPolyline["points"] as? String) ?? ""
                let line  = polypoints
                self.addPolyLineToDashLine(encodedString: line, objDestination: self.objJourney)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
                    let bounds = GMSCoordinateBounds(path: self.path)
                    self.mapView!.animate(with: GMSCameraUpdate.fit(bounds, withPadding:0.0))
                    self.animationView()
                })
                
            }
        }
    }
    
    func startToMyBYKtoFromMetro(decCurrentLat:Double,decCurrentLong:Double,decStationLat:Double,decStationLong:Double){
        var paramDashLineFrom = [String:Any]()
        paramDashLineFrom["decCurrentLat"] =  decCurrentLat
        paramDashLineFrom["decCurrentLong"] = decCurrentLong
        paramDashLineFrom["decStationLat"] =  decStationLat
        paramDashLineFrom["decStationLong"] = decStationLong
        paramDashLineFrom["intTransportModeID"] =  1
        
        
        self.objBlueLine.getDirectionStationJourneyPlanner(param: paramDashLineFrom) { responseDict in
            
            if let routes = responseDict?["routes"] as? [[String:Any]] {
                let routes = (routes.first as Dictionary<String, AnyObject>?) ?? [:]
                let overviewPolyline = (routes["overview_polyline"] as? Dictionary<String,AnyObject>) ?? [:]
                let polypoints = (overviewPolyline["points"] as? String) ?? ""
                let line  = polypoints
                self.addPolyLineDashLineFrom(encodedString: line, objDestination: self.objJourney)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
                    let bounds = GMSCoordinateBounds(path: self.path)
                    self.mapView!.animate(with: GMSCameraUpdate.fit(bounds, withPadding:0.0))
                    self.animationView()
                })
                
            }
        }
    }
    func FromRiskaToFromMetroStation(decCurrentLat:Double,decCurrentLong:Double,decStationLat:Double,decStationLong:Double){
        var paramDashLineFrom = [String:Any]()
        paramDashLineFrom["decCurrentLat"] =  decCurrentLat
        paramDashLineFrom["decCurrentLong"] = decCurrentLong
        paramDashLineFrom["decStationLat"] =  decStationLat
        paramDashLineFrom["decStationLong"] = decStationLong
        paramDashLineFrom["intTransportModeID"] =  1
        
        
        self.objBlueLine.getDirectionStationJourneyPlanner(param: paramDashLineFrom) { responseDict in
            
            if let routes = responseDict?["routes"] as? [[String:Any]] {
                let routes = (routes.first as Dictionary<String, AnyObject>?) ?? [:]
                let overviewPolyline = (routes["overview_polyline"] as? Dictionary<String,AnyObject>) ?? [:]
                let polypoints = (overviewPolyline["points"] as? String) ?? ""
                let line  = polypoints
                self.addPolyLineBlack(encodedString: line, objDestination: self.objJourney)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
                    let bounds = GMSCoordinateBounds(path: self.path)
                    self.mapView!.animate(with: GMSCameraUpdate.fit(bounds, withPadding:0.0))
                    self.animationView()
                })
                
            }
        }
    }
    func ToRiskaToToMetroStation(decCurrentLat:Double,decCurrentLong:Double,decStationLat:Double,decStationLong:Double){
        var paramDashLineFrom = [String:Any]()
        paramDashLineFrom["decCurrentLat"] =  decCurrentLat
        paramDashLineFrom["decCurrentLong"] = decCurrentLong
        paramDashLineFrom["decStationLat"] =  decStationLat
        paramDashLineFrom["decStationLong"] = decStationLong
        paramDashLineFrom["intTransportModeID"] =  1
        
        
        self.objBlueLine.getDirectionStationJourneyPlanner(param: paramDashLineFrom) { responseDict in
            
            if let routes = responseDict?["routes"] as? [[String:Any]] {
                let routes = (routes.first as Dictionary<String, AnyObject>?) ?? [:]
                let overviewPolyline = (routes["overview_polyline"] as? Dictionary<String,AnyObject>) ?? [:]
                let polypoints = (overviewPolyline["points"] as? String) ?? ""
                let line  = polypoints
                self.addPolyLineBlack(encodedString: line, objDestination: self.objJourney)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
                    let bounds = GMSCoordinateBounds(path: self.path)
                    self.mapView!.animate(with: GMSCameraUpdate.fit(bounds, withPadding:0.0))
                    self.animationView()
                })
                
            }
        }
    }
}

extension PlanjourneyRouetDetailsVC:GMSMapViewDelegate{
        func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
            /*  let arr = objJourney?.transitPaths ?? [TransitPaths]();     */          if let stationInfo = marker.userData {//as?  arr {
                   showInfoLabels()//(stationInfo)
               }
               return true
           }
    
    func showInfoLabels(){//(_ stationInfo:  objJourney?.journeyPlannerStationDetail?) {
               let stationNameLabel = UILabel()
               stationNameLabel.text = "Station Name: "//\(stationInfo.fromStationName)"
               let stationNoLabel = UILabel()
               stationNoLabel.text = "Station No: "//\(stationInfo.stationNo)"
               let etaLabel = UILabel()
               etaLabel.text = "ETA: "//\(stationInfo.eta)"
               let stackView = UIStackView(arrangedSubviews: [stationNameLabel, stationNoLabel, etaLabel])
               stackView.axis = .vertical
               stackView.spacing = 5.0 // Adjust the spacing as needed
               stackView.alignment = .leading
               stackView.translatesAutoresizingMaskIntoConstraints = false
    
               view.addSubview(stackView)
    
           }
}
