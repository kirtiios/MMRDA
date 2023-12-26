//
//  SuggestedItineraryVC.swift
//  MMRDA
//
//  Created by meghana.trivedi on 02/06/23.
//

import UIKit

class SuggestedItineraryVC: BaseVC {
    
    @IBOutlet var tblView:UITableView!
    @IBOutlet var lblTitle:UILabel!
    
    
    @IBOutlet var viewFliterBack:UIView!
    @IBOutlet var imgFliterBack:UIImageView!
    @IBOutlet var btnFliterClose:UIButton!
    @IBOutlet var btnShortTime:UIButton!
    @IBOutlet var btnMinimumFare:UIButton!
    @IBOutlet var btnMinimumTrasfer:UIButton!
    
    @IBOutlet var imgShortTime:UIImageView!
    @IBOutlet var imgMinimumFare:UIImageView!
    @IBOutlet var imgMinimumTrasfer:UIImageView!
    
    
    var upwardRoundTrip:[TransitPaths]?
        
    var upwardRoundJourney:JourneyPlannerStationDetail?
    var arrUpWard:[JourneyPlannerModel]?
    
    
    var downwardTripReturn:[TransitPaths]?
    var downwardJourneyReturn:JourneyPlannerStationDetail?
    
    
    var FullnameFrom = ""
    var FullnameTo = ""
    
    var PassThellData:ReturnJourneyPlannerApiModelData?
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        SettingRightButton()
//        self.setRightHomeButton()
        
        let barButton = UIBarButtonItem(image: UIImage(named:"Setting"), style:.plain, target: self, action: #selector(FilterSetting))
        barButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = barButton
        self.setBackButton()
      
            self.navigationItem.title = "\(upwardRoundJourney?.strToStationName ?? "") - \(upwardRoundJourney?.strFromStationName ?? "")"
        
//        self.navigationItem.title = "Plan_Journey".localized()
        
        
        self.tblView.register(UINib(nibName:"SuggestedItineraryCell", bundle: nil), forCellReuseIdentifier: "SuggestedItineraryCell")
        self.tblView.backgroundColor = .clear

        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        viewFliterBack.addGestureRecognizer(tapGesture)
        
        viewFliterBack.isHidden = true
        imgShortTime.image = UIImage(named: "radioSelected")
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        print(upwardRoundJourney)
    }
   
}
extension SuggestedItineraryVC{
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
    func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        viewFliterBack.isHidden = true
    }
    func formattedDateString(from dateString: String, inputFormat: String, outputFormat: String) -> String? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = inputFormat
            guard let date = dateFormatter.date(from: dateString) else {
                return nil // Return nil if the input format does not match the provided date string
            }
    
            dateFormatter.dateFormat = outputFormat
            return dateFormatter.string(from: date)
        }
}
extension SuggestedItineraryVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUpWard?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestedItineraryCell", for: indexPath) as! SuggestedItineraryCell
        
       
        cell.btnRadio.isHidden = true
        let newupwordtrip = arrUpWard?[indexPath.row].journeyPlannerStationDetail
        cell.lblStationName.text = "\(newupwordtrip?.strFromStationName ?? "") -  \(newupwordtrip?.strToStationName ?? "")"
        cell.lblDurationTime.text = newupwordtrip?.strDuration ?? ""
        cell.lblDate.text = newupwordtrip?.strCurrentDate ?? ""
        cell.lblChange.text  =  "\(newupwordtrip?.intPlatformChange ?? 0)"
        cell.leftSideSpace.constant = 15
        cell.obj = upwardRoundJourney
        cell.objTeraslistPath = upwardRoundTrip
        let fromStationArrivalDate = newupwordtrip?.fromStationArrival ?? ""
        print(fromStationArrivalDate)
//        let formattedDateArrival = formattedDateString(from: fromStationArrivalDate, inputFormat: "MM/dd/yyyy HH:mm:ss", outputFormat: "h:mm a")
        
        let formattedDateArrival = formattedDateString(from: fromStationArrivalDate, inputFormat: "yyyy-MM-dd HH:mm:ss", outputFormat: "HH:mm:ss")
       
        
        let fromStationDepartureDate = newupwordtrip?.toStationDepature ?? ""
        print(fromStationDepartureDate)
        let formattedDateDeparture = formattedDateString(from: fromStationDepartureDate, inputFormat: "yyyy-MM-dd HH:mm:ss", outputFormat: "HH:mm:ss")

        cell.twoTime.text = (formattedDateArrival ?? "") + " - " + (formattedDateDeparture ?? "")
        
      //  cell.obj = upwardRoundJourney
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.PlanjourneyRouetDetailsVC()
//        vc.objStation = objStation
      
        vc.indexrow = indexPath.row
        vc.objparent = self
        vc.objJourney = arrUpWard?[indexPath.row]
        vc.isFromFareCalVCValue = false
        vc.isfromSuggestedItineratyVC = true
        vc.isfromUpwoedNewJourneyVc = false
        vc.PassFullnameFrom = FullnameFrom
        vc.PassFullnameTo = FullnameTo
    
        self.navigationController?.pushViewController(vc, animated:true)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
}
