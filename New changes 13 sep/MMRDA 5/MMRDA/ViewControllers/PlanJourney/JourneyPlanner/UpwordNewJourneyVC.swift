//
//  UpwordNewJourneyVC.swift
//  MMRDA
//
//  Created by meghana.trivedi on 01/06/23.
//

import UIKit

class UpwordNewJourneyVC: BaseVC {
    
    @IBOutlet var viewUpwardBack:UIView!
    @IBOutlet var lblUpward:UILabel!
    @IBOutlet var viewUpwardBottom:UIView!
    @IBOutlet var btnUpward:UIButton!
    
    @IBOutlet var viewDownwardBack:UIView!
    @IBOutlet var lblDownward:UILabel!
    @IBOutlet var viewDownwardBottom:UIView!
    @IBOutlet var btnDownward:UIButton!
    
    @IBOutlet var viewFliterBack:UIView!
    @IBOutlet var imgFliterBack:UIImageView!
    @IBOutlet var btnFliterClose:UIButton!
    @IBOutlet var btnShortTime:UIButton!
    @IBOutlet var btnMinimumFare:UIButton!
    @IBOutlet var btnMinimumTrasfer:UIButton!
    
    @IBOutlet var imgShortTime:UIImageView!
    @IBOutlet var imgMinimumFare:UIImageView!
    @IBOutlet var imgMinimumTrasfer:UIImageView!
    
    @IBOutlet var tblView:UITableView!
    var downward = false
    
    var upwardRoundTrip:[TransitPaths]?
    var upwardRoundJourney:JourneyPlannerStationDetail?
    var newupwordtrip:[JourneyPlannerModel]?
    
    var downwardTripReturn:[TransitPaths]?
    var downwardJourneyReturn:JourneyPlannerStationDetail?
    
    @IBOutlet var viewBookNowBack:UIView!
    @IBOutlet var btnBookNow:UIButton!
    
    var PassThellData:ReturnJourneyPlannerApiModelData?
    
    var FullnameFrom = ""
    var FullnameTo = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.SettingRightButton()
//        self.setRightHomeButton()
        self.setBackButton()
        if downward == true{
            self.navigationItem.title = "\(downwardJourneyReturn?.strFromStationName ?? "") - \(downwardJourneyReturn?.strToStationName ?? "")"
        }else{
            self.navigationItem.title = "\(upwardRoundJourney?.strFromStationName ?? "") - \(upwardRoundJourney?.strToStationName ?? "")"
        }
        //"Dahisar East - Andheri .."
//        self.navigationItem.title = "Plan_Journey".localized()
        
        
//        self.tblView.register(UINib(nibName:"UpwardCell", bundle: nil), forCellReuseIdentifier: "UpwardCell")
        
        self.tblView.register(UINib(nibName:"SuggestedItineraryCell", bundle: nil), forCellReuseIdentifier: "SuggestedItineraryCell")
        self.tblView.backgroundColor = .clear
        
        
        lblUpward.textColor = APP_BLUE_COLOR
        viewUpwardBottom.backgroundColor = APP_BLUE_COLOR
        
        lblDownward.textColor = .black
        viewDownwardBottom.backgroundColor = .clear
        
        
        let barButton = UIBarButtonItem(image: UIImage(named:"Setting"), style:.plain, target: self, action: #selector(FilterSetting))
        barButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = barButton
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        viewFliterBack.addGestureRecognizer(tapGesture)
        
        viewFliterBack.isHidden = true
        imgShortTime.image = UIImage(named: "radioSelected")
        
        viewBookNowBack.isHidden = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        UserDefaults.standard.set("radioUnSelected", forKey: "ImageValue")
    }

}
extension UpwordNewJourneyVC{
    @IBAction func btnUpwardClick(_ sender: UIButton) {
        
        self.tblView.reloadData()
        self.downward = false
        self.viewBookNowBack.isHidden =  true
        
        lblUpward.textColor = APP_BLUE_COLOR
        viewUpwardBottom.backgroundColor = APP_BLUE_COLOR
        
        lblDownward.textColor = .black
        viewDownwardBottom.backgroundColor = .clear
        self.navigationItem.title = "\(upwardRoundJourney?.strFromStationName ?? "") - \(upwardRoundJourney?.strToStationName ?? "")"
    }
    @IBAction func btnDownward(_ sender: UIButton) {
        self.tblView.reloadData()
        self.downward = true
        self.viewBookNowBack.isHidden =  false
        
        lblDownward.textColor = APP_BLUE_COLOR
        viewDownwardBottom.backgroundColor = APP_BLUE_COLOR
        
        lblUpward.textColor = .black
        viewUpwardBottom.backgroundColor = .clear
        
        self.navigationItem.title = "\(downwardJourneyReturn?.strFromStationName ?? "") - \(downwardJourneyReturn?.strToStationName ?? "")"
    }
    
    @objc func FilterSetting(){
        viewFliterBack.isHidden = false
    }
    @IBAction func btnFliterCloseClick(_ sender: UIButton) {
       
        viewFliterBack.isHidden = true
    }
    @IBAction func btnShortTimeClick(_ sender: UIButton) {
        imgShortTime.image = UIImage(named: "radioSelected")
        imgMinimumFare.image = UIImage(named: "radioUnSelected")
        imgMinimumTrasfer.image = UIImage(named: "radioUnSelected")
    }
    @IBAction func btnMinimumFareClick(_ sender: UIButton) {
        imgMinimumFare.image = UIImage(named: "radioSelected")
        imgShortTime.image = UIImage(named: "radioUnSelected")
        imgMinimumTrasfer.image = UIImage(named: "radioUnSelected")
    }
    @IBAction func btnMinimumTrasferClick(_ sender: UIButton) {
        imgMinimumTrasfer.image = UIImage(named: "radioSelected")
        imgShortTime.image = UIImage(named: "radioUnSelected")
        imgMinimumFare.image = UIImage(named: "radioUnSelected")
    }
    @IBAction func btnCancelclick(_ sender: UIButton) {
        viewFliterBack.isHidden = true
    }
    @IBAction func btnApplyclick(_ sender: UIButton) {
        viewFliterBack.isHidden = true
    }
    @objc func viewTapped() {
        viewFliterBack.isHidden = true
        }
    @IBAction func btnBookNowClick(_ sender: UIButton) {
        print("Book now click")
        let vc = UIStoryboard.PaymentVC()
        vc?.objJourney = newupwordtrip?.first
        vc?.downfare = downwardJourneyReturn?.fare ?? 0.0
        vc?.fromType  = .JourneyPlanner
        vc?.isfromUpwoedNewJourneyVcPass = true
        vc?.isfromSuggestedItineratyVCPass = false
        self.navigationController?.pushViewController(vc!, animated:true)
    }
    
    func formattedDateString(from dateString: String, inputFormat: String, outputFormat: String) -> String? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = inputFormat
            guard let date = dateFormatter.date(from: dateString) else {
                return nil
            }
    
            dateFormatter.dateFormat = outputFormat
            return dateFormatter.string(from: date)
        }
}

extension UpwordNewJourneyVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if downward == true{
            if downwardJourneyReturn == nil{
                return 0
            }else{
                return newupwordtrip?.count ?? 0
            }
           
        }else{
            if upwardRoundJourney == nil {
                return 0
            }else{
                return newupwordtrip?.count ?? 0
            }
        }
//        return arrUpword.transitPathsReturnUpwardTrip?.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestedItineraryCell", for: indexPath) as! SuggestedItineraryCell
        
        
        let newupwordtrip = newupwordtrip?[indexPath.row].journeyPlannerStationDetail
        print(newupwordtrip)
        cell.leftSideSpace.constant = 30
        cell.leftSideStationSpace.constant = 30
        if downward == true{
            cell.btnRadio.setBackgroundImage(UIImage(named: "radioUnSelected"), for: .normal)
            cell.lblStationName.text = "\(downwardJourneyReturn?.strFromStationName ?? "") - \(downwardJourneyReturn?.strToStationName ?? "")"
            cell.lblDurationTime.text = downwardJourneyReturn?.strDuration ?? ""
            cell.lblDate.text = downwardJourneyReturn?.strCurrentDate ?? ""
            cell.lblChange.text  =  "\(downwardJourneyReturn?.intPlatformChange ?? 0)"
            
            let fromStationArrivalDate = downwardJourneyReturn?.fromStationArrival ?? ""
            print(fromStationArrivalDate)
            let formattedDateArrival = formattedDateString(from: fromStationArrivalDate, inputFormat: "yyyy-MM-dd HH:mm:ss", outputFormat: "HH:mm:ss")

            let fromStationDepartureDate = downwardJourneyReturn?.toStationDepature ?? ""
            print(fromStationDepartureDate)
            let formattedDateDeparture = formattedDateString(from: fromStationDepartureDate, inputFormat: "yyyy-MM-dd HH:mm:ss", outputFormat: "HH:mm:ss")

            cell.twoTime.text = (formattedDateArrival ?? "") + " - " + (formattedDateDeparture ?? "")
//
            cell.obj = downwardJourneyReturn
            cell.btnRadio.tag = indexPath.row
            cell.radioClick = { [weak self] index in
                print(index)
                cell.btnRadio.setBackgroundImage(UIImage(named: "radioSelected"), for: .normal)
                print("downward radio selected")
            }
        }
        else{
            
            cell.lblStationName.text = "\(upwardRoundJourney?.strFromStationName ?? "") - \(upwardRoundJourney?.strToStationName ?? "")"
            cell.lblDurationTime.text = upwardRoundJourney?.strDuration ?? ""
            cell.lblDate.text = upwardRoundJourney?.strCurrentDate ?? ""
            cell.lblChange.text  =  "\(upwardRoundJourney?.intPlatformChange ?? 0)"
            
            let fromStationArrivalDate = upwardRoundJourney?.fromStationArrival ?? ""
            print(fromStationArrivalDate)
            let formattedDateArrival = formattedDateString(from: fromStationArrivalDate, inputFormat: "yyyy-MM-dd HH:mm:ss", outputFormat: "HH:mm:ss")

            let fromStationDepartureDate = upwardRoundJourney?.toStationDepature ?? ""
            print(fromStationDepartureDate)
            let formattedDateDeparture = formattedDateString(from: fromStationDepartureDate, inputFormat: "yyyy-MM-dd HH:mm:ss", outputFormat: "HH:mm:ss")

            cell.twoTime.text = (formattedDateArrival ?? "") + " - " + (formattedDateDeparture ?? "")
//
            cell.obj = upwardRoundJourney
            
            cell.btnRadio.tag = indexPath.row
            if let loadedString = UserDefaults.standard.string(forKey: "ImageValue") {
                print(loadedString)
                cell.btnRadio.setBackgroundImage(UIImage(named: loadedString), for: .normal)
            }
            
            cell.radioClick = { [weak self] index in
                print(index)
                if cell.btnRadio.currentImage == UIImage(named: "radioSelected"){
                    cell.btnRadio.setBackgroundImage(UIImage(named: "radioUnSelected"), for: .normal)
                    UserDefaults.standard.set("radioUnSelected", forKey: "ImageValue")

                }else{
                    cell.btnRadio.setBackgroundImage(UIImage(named: "radioSelected"), for: .normal)
                    UserDefaults.standard.set("radioSelected", forKey: "ImageValue")
                }
//                cell.btnRadio.setBackgroundImage(UIImage(named: "radioSelected"), for: .normal)
                DispatchQueue.main.asyncAfter(deadline:.now() + 0.2) {
                    self?.lblDownward.textColor = APP_BLUE_COLOR
                    self?.viewDownwardBottom.backgroundColor = APP_BLUE_COLOR
                    
                    self?.lblUpward.textColor = .black
                    self?.viewUpwardBottom.backgroundColor = .clear
                    
                    self?.tblView.reloadData()
                    self?.downward = true
                    self?.viewBookNowBack.isHidden = false
                }
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if downward == true{
           
                let vc = UIStoryboard.PlanjourneyRouetDetailsVC()
                //        vc.objStation = objStation
        print(PassThellData)
        if downward == true{
            vc.objJourney = PassThellData?.downwardTrip?.first?[0]
            vc.PassFullnameFrom = FullnameTo
            vc.PassFullnameTo = FullnameFrom
        }else{
            vc.objJourney = PassThellData?.upwardTrip?.first?[0]
            vc.PassFullnameFrom = FullnameFrom
            vc.PassFullnameTo = FullnameTo
        }//self.newupwordtrip?.first
                vc.isFromFareCalVCValue = false
                vc.isfromUpwoedNewJourneyVc = true
                vc.isfromSuggestedItineratyVC = false
       
        vc.downwardget = downward
                self.navigationController?.pushViewController(vc, animated:true)
           
//        }else{
//
//        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    
    
}
extension UIViewController{
    class GlobalDateFormatter {
        static let shared = GlobalDateFormatter()
        
        let dateFormatter: DateFormatter
        let timeFormatter: DateFormatter
        
        private init() {
            dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            
            timeFormatter = DateFormatter()
            timeFormatter.timeStyle = .medium
        }
    }

}
