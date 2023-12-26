//
//  NewPlaneJourneyVC.swift
//  MMRDA
//
//  Created by meghana.trivedi on 26/05/23.
//

import UIKit
import CoreLocation
import DropDown

class NewPlaneJourneyVC: BaseVC {
    
    
    var currentIndex = 0
    
    var isReturnJourney = false
    var isArrivalBased = false
    var strHoltTime = ""
    var currentDate = Date()
    var currentTime = Date()
    
    var isMetroTransport = true
    var isCyclingTransport = true
    var isBusTransport = true
    var isAutoTaxiTransport = true
    var walkKM = 0.0
    var cycleKM = 0.0
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter
    }()
    
    
    @IBAction func btnAdvaceSearchClick(_ sender: UIButton) {
        if viewAdvanceSearchBack.isHidden == true{
            imgAdvanceSearch.image = UIImage(named: "minus")
            viewAdvanceSearchBack.isHidden = false
        }else{
            viewAdvanceSearchBack.isHidden = true
            imgAdvanceSearch.image = UIImage(systemName:"plus")
        }
    }
    @IBAction func btnAddViaClick(_ sender: UIButton) {
        if currentIndex < staSearchLocationValue.count {
            staSearchLocationValue[currentIndex].isHidden = false
            currentIndex += 1
        }
    }
    @objc func deleteButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        
        if index > 0 && index < staSearchLocationValue.count {
            staSearchLocationValue[index].isHidden = true
        }
    }
    @IBAction func btnTrasportClick(_ sender: UIButton) {
        
        if let imageView = imgRouteCheckUncheck.first(where: { $0.tag == sender.tag }) {
            if imageView.image == UIImage(named: "RectangleCheckBoxSelected") {
                imageView.image = UIImage(named: "RectangleCheckBoxUnSelected")
                switch sender.tag {
                case 11:
                    imageView.image = UIImage(named: "RectangleCheckBoxSelected")
                    self.isMetroTransport = true
                case 12:
                    self.isBusTransport = false
                case 14:
                    self.isAutoTaxiTransport = false
                case 13:
                    self.isCyclingTransport = false
                default:
                    break
                }
            } else {
                imageView.image = UIImage(named: "RectangleCheckBoxSelected")
                switch sender.tag {
                case 11:
                    self.isMetroTransport = true
                case 12:
                    self.isBusTransport = true
                case 13:
                    self.isCyclingTransport = true
                case 14:
                    self.isAutoTaxiTransport = true
                default:
                    break
                }
            }
        }
    }
    @IBAction func btnWalkingDisataceClick(_ sender: UIButton) {
        self.showDropdownMenu(anchorView: sender, dataSource: ["txtNone".LocalizedString,"0.5 KM", "1 KM","1.5 KM","2 KM","2.5 KM","3 KM"]) { index, item in
            print("Selected item: \(item) at index: \(index)")
            sender.setTitle(item, for: .normal)
            if item.contains(" KM") {
                let km = item.replacingOccurrences(of: " KM", with: "")
                if let distance = Double(km) {
                    self.walkKM = distance
                }
            }
        }
    }
    
    @IBAction func btnCyclingDistanceCklick(_ sender: UIButton) {
        self.showDropdownMenu(anchorView: sender, dataSource: ["txtNone".LocalizedString,"1 KM", "2 KM","3 KM","4 KM","5 KM"]) { index, item in
            print("Selected item: \(item) at index: \(index)")
            sender.setTitle(item, for: .normal)
            if let km = item.replacingOccurrences(of: " KM", with: "") as? String, let distance = Double(km) {
                self.cycleKM = distance
                
            }
        }
    }
    @IBAction func btnRoundTripClick(_ sender: UIButton) {
        
        if imgRoundTripCheckUncheck.image == UIImage(named: "RectangleCheckBoxSelected") {
            imgRoundTripCheckUncheck.image = UIImage(named: "RectangleCheckBoxUnSelected")
            viewHalthTimeBetweenTrips.isHidden = true
            isReturnJourney = false
        } else {
            isReturnJourney = true
            imgRoundTripCheckUncheck.image = UIImage(named: "RectangleCheckBoxSelected")
            viewHalthTimeBetweenTrips.isHidden = false
            btnHaltTimeBetweenTrips.setTitle("00:00", for: .normal)
            // btnHaltTimeBetweenTrips.setTitle(timeFormatter.string(from: currentTime), for: .normal)
        }
    }
    
    @IBAction func btnResetAllClick(_ sender: UIButton) {
        viewAdvanceSearchBack.isHidden = true
        imgRoundTripCheckUncheck.image = UIImage(named: "RectangleCheckBoxUnSelected")
        viewHalthTimeBetweenTrips.isHidden = true
        isReturnJourney = false
        btnFrom .setTitle("select_from_location".localized(), for: .normal)
        btnTo .setTitle("select_to_location".localized(), for: .normal)
        txtDate.text = dateFormatter.string(from: currentDate)
        txtTime.text = timeFormatter.string(from: currentTime)
        btnCyclingDistance.setTitle("txtNone".LocalizedString, for: .normal)
        btnWalkingDistance.setTitle("txtNone".LocalizedString, for: .normal)
        imgAdvanceSearch.image = UIImage(systemName:"plus")
    }
    @IBAction func btnHaltTimeBetweenClick(_ sender: UIButton) {
        print("haltime click")
        
        
        //txtTime.text = timeFormatter.string(from: currentTime)
        //        timePicker.addTarget(self, action: #selector(timePickerValueChanged(_:)), for: .valueChanged)
        //
        //        let alertController = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        //        alertController.view.addSubview(timePicker)
        //
        //        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
        //            // Handle the selected time
        //            let selectedTime = timePicker.date
        //            let dateFormatter = DateFormatter()
        //            dateFormatter.dateFormat = "HH:mm"
        //            let formattedTime = dateFormatter.string(from: selectedTime)
        //            print("Selected Time: \(formattedTime)")
        //            self.btnHaltTimeBetweenTrips.setTitle(formattedTime, for: .normal)
        //            self.strHoltTime = formattedTime
        //        }
        //
        //        alertController.addAction(okAction)
        //
        //        present(alertController, animated: true, completion: nil)
    }
    @objc func timePickerValueChanged(_ sender: UIDatePicker) {
        // Handle value changes in the time picker if needed
        let selectedTime = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let formattedTime = dateFormatter.string(from: selectedTime)
        print("Selected Time: \(formattedTime)")
    }
    @objc func cancelPicker() {
        // Handle the cancel action if needed
        btnHaltTimeBetweenTrips.resignFirstResponder()
    }
    
    @objc func donePicker() {
        
        //        let selectedTime = datePicker.date
        //
        //        // Handle the selected time as per your requirement
        //        // For example, update the text field with the selected time
        //        let dateFormatter = DateFormatter()
        //        dateFormatter.dateFormat = "h:mm a"
        //        let formattedTime = dateFormatter.string(from: selectedTime)
        //        btnHaltTimeBetweenTrips.text = formattedTime
        //
        //        btnHaltTimeBetweenTrips.resignFirstResponder()
    }
    @IBAction func btnActionCurrentClicked(_ sender: UIButton) {
        LocationManager.sharedInstance.getCurrentLocation { success, location in
            if success {
                LocationManager.sharedInstance.getaddessFromLatLong(coords:CLLocationCoordinate2D(latitude: LocationManager.sharedInstance.currentLocation.coordinate.latitude, longitude: LocationManager.sharedInstance.currentLocation.coordinate.longitude)) { address in
                    self.objFrom = planeStation(locationname: address, latitude: LocationManager.sharedInstance.currentLocation.coordinate.latitude, longitude: LocationManager.sharedInstance.currentLocation.coordinate.longitude)
                    self.btnFrom.setTitle( self.objFrom?.locationname, for: .normal)
                }
            }
        }
    }
    @IBOutlet weak var btnSwitch: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnTo: UIButton!
    @IBOutlet weak var btnFrom: UIButton!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var lblNotFound: UILabel!
    
    @IBOutlet weak var btnAddVia: UIButton!
    @IBOutlet weak var viewAdvanceSearchBack: UIView!
    
    @IBOutlet weak var viewNewDateTime: UIView!
    @IBOutlet weak var lblDate_Time: UILabel!
    @IBOutlet var txtDate:UITextField!
    @IBOutlet var txtTime:UITextField!
    @IBOutlet weak var imgCalender: UIImageView!
    @IBOutlet var switchDepatcherArrival:UISwitch!
    @IBOutlet var txtHaltTime:UITextField!
    @IBOutlet var imgAdvanceSearch:UIImageView!
    
    @IBAction func btnAdvanceSearch(_ sender: UIButton) {
    }
    @IBOutlet weak var imgTime: UIImageView!
    
    @IBAction func switchDepatcher_Arrival(_ sender: UISwitch) {
        if sender.isOn {
            self.isArrivalBased = true
        }else{
            self.isArrivalBased = false
        }
    }
    @IBAction func txtTime(_ sender: UITextField) {
    }
    @IBOutlet weak var staViaTitle: UIStackView!
    @IBOutlet var staSearchLocationValue:[UIStackView]!
    @IBOutlet var btnDeletefromStack:[UIButton]!
    @IBOutlet var txtSearchLocation:[UITextField]!
    @IBOutlet var txtLengthOfStayTime:[UITextField]!
    @IBOutlet var imgRouteCheckUncheck:[UIImageView]!
    
    @IBOutlet var imgRoundTripCheckUncheck:UIImageView!
    @IBOutlet weak var btnRoundTrip: UIButton!
    @IBOutlet weak var btnWalkingDistance: UIButton!
    @IBOutlet weak var btnCyclingDistance: UIButton!
    @IBOutlet weak var viewHalthTimeBetweenTrips: UIView!
    
    @IBOutlet weak var btnHaltTimeBetweenTrips: UIButton!
    var objTo:planeStation?
    //    {
    //        didSet {
    //            btnTo.setTitle(objTo?.locationname, for: .normal)
    //        }
    //    }
    var objFrom:planeStation?
    //    {
    //        didSet {
    //            btnFrom.setTitle(objFrom?.locationname, for: .normal)
    //        }
    //    }
    var arrRecentData = [RecentPlaneStation]() {
        didSet {
            self.tableview.reloadData()
        }
    }
    // var arrRecentLocation = [String:any]()
    private var  objViewModel = JourneyPlannerModelView()
    var newApiviewModel = ReturnJourneyPlannerModelView()
    
    var QuickFromstationName = ""
    var QuickToStationName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // self.callBarButtonForHome(isloggedIn:true,leftBarLabelName:"Plan_Journey".LocalizedString, isHomeScreen:false,isDisplaySOS: false)
        
        self.setRightHomeButton()
        self.setBackButton()
        self.navigationItem.title = "Plan_Journey".localized()
        
        self.tableview.register(UINib(nibName:"cellRecentSearch", bundle: nil), forCellReuseIdentifier: "cellRecentSearch")
        self.tableview.rowHeight = UITableView.automaticDimension
        self.tableview.estimatedRowHeight = 50
        
        btnTo.titleLabel?.numberOfLines = 2
        btnFrom.titleLabel?.numberOfLines = 2
        if let savedPerson = UserDefaults.standard.object(forKey: userDefaultKey.journeyPlannerList.rawValue) as? Data {
            if let loadedPerson = try? JSONDecoder().decode([RecentPlaneStation].self, from: savedPerson) {
                arrRecentData = loadedPerson
            }
        }
        
        objViewModel.delegate = self
        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.view.hideToastActivity()
                    self?.view.makeToast(message)
                }
            }
        }
        if QuickFromstationName == "" || QuickToStationName == ""{
            if objFrom?.locationname == nil || objTo?.locationname == nil{
                btnFrom .setTitle("select_from_location".localized(), for: .normal)
                btnTo .setTitle("select_to_location".localized(), for: .normal)
            }else{
                objFrom?.locationname = btnFrom.currentTitle ?? ""
                objTo?.locationname = btnTo.currentTitle ?? ""
            }
            
        }else{
            btnFrom .setTitle(QuickFromstationName, for: .normal)
            btnTo .setTitle(QuickToStationName, for: .normal)
            
            //            objFrom?.locationname = btnFrom.currentTitle ?? ""
            //            objTo?.locationname = btnTo.currentTitle ?? ""
        }
        
        
        viewAdvanceSearchBack.isHidden = true
        viewHalthTimeBetweenTrips.isHidden = true
        for (index, stackView) in staSearchLocationValue.enumerated() {
            if index != 0 {
                stackView.isHidden = true
            }
        }
        
        
        for (index, button) in btnDeletefromStack.enumerated() {
            button.tag = index
            button.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        }
        //        txtDate.delegate = self
        //        txtTime.delegate = self
        //        txtHaltTime.delegate = self
        //        setupDatePicker()
        //        setupTimePicker()
        //        setupHaltTimePicker()
        //
        switchDepatcherArrival.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        
  
        
        
        txtHaltTime.text = "00:00"
        
        txtDate.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed), datePickerMode: .date, Messageget: "txt_error_Date".LocalizedString)
        txtTime.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed), datePickerMode: .time, Messageget: "txt_error_time".LocalizedString)
        txtHaltTime.addInputViewDatePickerForMinits(target: self, selector: #selector(doneButtonPressed), datePickerMode: .time, Messageget: "txt_error_time".LocalizedString)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if QuickFromstationName == "" || QuickToStationName == ""{
            if objFrom?.locationname == nil{
                btnFrom .setTitle("select_from_location".localized(), for: .normal)
            }
            else {
                btnFrom.setTitle(objFrom?.locationname, for: .normal)
            }
            if objTo?.locationname == nil{
                btnTo .setTitle("select_to_location".localized(), for: .normal)
                
            }else{
                //                btnFrom.setTitle(objFrom?.locationname, for: .normal)
                btnTo.setTitle(objTo?.locationname, for: .normal)
                
            }
            
        }else{
            btnFrom .setTitle(QuickFromstationName, for: .normal)
            btnTo .setTitle(QuickToStationName, for: .normal)
            
            //            objFrom?.locationname = btnFrom.currentTitle ?? ""
            //            objTo?.locationname = btnTo.currentTitle ?? ""
        }
        txtTime.text = timeFormatter.string(from: currentTime)
    }
    @objc func doneButtonPressed(textFieldget:UITextField) {
        if  self.txtTime.isFirstResponder {
            let  datePicker = self.txtTime.inputView as! UIDatePicker
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm a"
            self.txtTime.text = dateFormatter.string(from: datePicker.date)
        }else if  self.txtDate.isFirstResponder{
            let  datePicker = self.txtDate.inputView as! UIDatePicker
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            self.txtDate.text = dateFormatter.string(from: datePicker.date)
        }else if  self.txtHaltTime.isFirstResponder {
            let  datePicker = self.txtHaltTime.inputView as! UIDatePicker
            
            let dateFormatter = DateFormatter()
//            dateFormatter.locale = Locale(identifier: "en_GB")

            dateFormatter.dateFormat = "HH:mm"
            self.txtHaltTime.text = dateFormatter.string(from: datePicker.date)
        }
        self.view.endEditing(true)
        //        self.txtTime.resignFirstResponder()
    }
    
    @IBAction func btnActionClicked(_ sender: UIButton) {
        //        let vc =  UIStoryboard.UpwordNewJourneyVC()
        //        self.navigationController?.pushViewController(vc, animated:true)
        
        
        
        
        //        let vc =  UIStoryboard.SuggestedItineraryVC()
        //        self.navigationController?.pushViewController(vc, animated:true)
        
        if sender == btnSearch {
            
            
            if objFrom == nil   {
                objViewModel.inputErrorMessage.value = "tv_validate_from".localized()
            }
            else  if objTo == nil {
                objViewModel.inputErrorMessage.value = "tv_validate_to".localized()
            }else {
                
                //
                
                
                let objplanner = RecentPlaneStation(from_locationname: objFrom?.locationname ?? "", from_latitude: objFrom?.latitude ?? 0, from_longitude: objFrom?.longitude ?? 0, to_locationname: objTo?.locationname ?? "", to_latitude: objTo?.latitude ?? 0, to_longitude: objTo?.longitude ?? 0)
                let obj = self.arrRecentData.first { objdata in
                    return objdata.from_locationname.lowercased() == objFrom?.locationname.lowercased()  && objdata.to_locationname.lowercased() == objTo?.locationname.lowercased()
                }
                
                if obj == nil {
                    arrRecentData.insert(objplanner, at: 0)
                }else {
                    self.arrRecentData.removeAll { objdata in
                        return objdata.from_locationname.lowercased() == objFrom?.locationname.lowercased()  && objdata.to_locationname.lowercased() == objTo?.locationname.lowercased()
                    }
                    arrRecentData.insert(objplanner, at: 0)
                }
                if arrRecentData.count > 5 {
                    arrRecentData.removeLast()
                }
                
                if let encoded = try? JSONEncoder().encode(arrRecentData) {
                    UserDefaults.standard.set(encoded, forKey: userDefaultKey.journeyPlannerList.rawValue)
                    UserDefaults.standard.synchronize()
                }
                
                
                //                let dateFormatter = DateFormatter()
                //                dateFormatter.dateFormat = "hh:mm a"
                //
                //                if let selectedTime = dateFormatter.date(from: txtTime.text ?? "") {
                //                    dateFormatter.dateFormat = "HH:mm"
                //                    let formattedTime = dateFormatter.string(from: selectedTime)
                //                }
                var param = [String:Any]()
                param["intUserID"] = Helper.shared.objloginData?.intUserID
                param["decFromStationLat"] =  "\(objFrom?.latitude ?? 0)"
                param["decFromStationLong"] =   "\(objFrom?.longitude ?? 0)"
                param["decToStationLat"] =  "\(objTo?.latitude ?? 0)"
                param["decToStationLong"] =  "\(objTo?.longitude ?? 0)"
                param["decCyclingRange"] = self.cycleKM
                param["decWalkingRange"] = self.walkKM
                param["isArrivalBased"] = self.isArrivalBased
                param["isAutoTaxiTransport"] = self.isAutoTaxiTransport
                param["isBusTransport"] = self.isBusTransport
                param["isCyclingTransport"] = self.isCyclingTransport
                param["isMetroTransport"] = self.isMetroTransport
                param["isReturnJourney"] = self.isReturnJourney//true
                param["strHoltTime"] = self.strHoltTime
                param["strSelectedTime"] = txtTime.text ?? ""
                
                
                newApiviewModel.getReturnJourneyPlanner(param: param) { data in
                    print(data)
                    if self.isReturnJourney == false{
                        if data.data?[0].upwardTrip?[0].first?.transitPaths?.count ?? 0 <= 0{
                            self.showAlertViewWithMessage("APPTITLE".LocalizedString, message: "txtNoTrip".LocalizedString)
                        }
                        else{
                            let vc =  UIStoryboard.SuggestedItineraryVC()
                            vc.upwardRoundTrip = data.data?[0].upwardTrip?[0].first?.transitPaths as? [TransitPaths]
                            vc.upwardRoundJourney = data.data?[0].upwardTrip?[0].first?.journeyPlannerStationDetail
                            vc.newupwordtrip = data.data?[0].upwardTrip?.first as?[JourneyPlannerModel]

                            if data.data?[0].downwardTrip?.first?.count ?? 0 <= 0{
                                vc.downwardTripReturn =  nil
                                vc.downwardJourneyReturn = nil
                            }else{
                                vc.downwardTripReturn = data.data?[0].downwardTrip?.first?[0].transitPaths as? [TransitPaths]
                                vc.downwardJourneyReturn = data.data?[0].downwardTrip?.first?[0].journeyPlannerStationDetail
                            }
                           
                            vc.PassThellData = data.data?[0]
                            vc.FullnameFrom = self.btnFrom.currentTitle ?? ""
                            vc.FullnameTo =  self.btnTo.currentTitle ?? ""
                            self.navigationController?.pushViewController(vc, animated:true)
                        }
                    }else{
                        if data.data?[0].downwardTrip?.first?[0].transitPaths?.count ?? 0 <= 0{
                            self.showAlertViewWithMessage("APPTITLE".LocalizedString, message: "txtNoTrip".LocalizedString)
                        }else if data.data?[0].downwardTrip?.first?[0].transitPaths?.count ?? 0 <= 0{
                            self.showAlertViewWithMessage("APPTITLE".LocalizedString, message: "txtNoTrip".LocalizedString)
                        }
                        else{
                            let vc =  UIStoryboard.UpwordNewJourneyVC()
                            vc.upwardRoundTrip = data.data?[0].upwardTrip?[0].first?.transitPaths as? [TransitPaths]
                            vc.upwardRoundJourney = data.data?[0].upwardTrip?[0].first?.journeyPlannerStationDetail
                            vc.newupwordtrip = data.data?[0].upwardTrip?.first as?[JourneyPlannerModel]

                            
                            if data.data?[0].downwardTrip?.first?.count ?? 0 <= 0{
                                vc.downwardTripReturn =  nil
                                vc.downwardJourneyReturn = nil
                            }else{
                                vc.downwardTripReturn = data.data?[0].downwardTrip?.first?[0].transitPaths as? [TransitPaths]
                                vc.downwardJourneyReturn = data.data?[0].downwardTrip?.first?[0].journeyPlannerStationDetail
                            }
                            
//                            vc.downwardTripReturn = data.data?[0].downwardTrip?.first?[0].transitPaths as? [TransitPaths]
//                            vc.downwardJourneyReturn = data.data?[0].downwardTrip?.first?[0].journeyPlannerStationDetail
                            vc.PassThellData = data.data?[0]
                            vc.FullnameFrom = self.btnFrom.currentTitle ?? ""
                            vc.FullnameTo =  self.btnTo.currentTitle ?? ""
                            
//                            vc.upwardRoundTrip = data.data?.first?.upwardTrip?.first?[0].transitPaths as? [TransitPaths]
//                            vc.upwardRoundJourney = data.data?.first?.upwardTrip?.first?[0].journeyPlannerStationDetail
//                            vc.newupwordtrip = data.data?.first?.upwardTrip as?[JourneyPlannerModel]
//
//                            vc.downwardTripReturn = data.data?.first?.downwardTrip?.first?[0].transitPaths as? [TransitPaths]
//                            vc.downwardJourneyReturn = data.data?.first?.downwardTrip?.first?[0].journeyPlannerStationDetail
//                            vc.newupwordtrip = data.data?.first?.downwardTrip
//
//                            vc.PassThellData = data.data?.first
//
//                            vc.FullnameFrom = self.btnFrom.currentTitle ?? ""
//                            vc.FullnameTo =  self.btnTo.currentTitle ?? ""
                            self.navigationController?.pushViewController(vc, animated:true)
                        }
                    }
                } errorHandler: { error in
                    print(error)
                }
                
                
//                newApiviewModel.getReturnJourneyPlanner(param: param) { newApiData in
//                    if self.isReturnJourney == false{
//                        if newApiData?.first?.upwardTrip?.first?[0].transitPaths?.count ?? 0 <= 0{
//                            self.showAlertViewWithMessage("APPTITLE".LocalizedString, message: "txtNoTrip".LocalizedString)
//                        }else{
//                            let vc =  UIStoryboard.SuggestedItineraryVC()
//                            vc.upwardRoundTrip = newApiData?.first?.upwardTrip?.first?[0].transitPaths as? [TransitPaths]
//                            vc.upwardRoundJourney = newApiData?.first?.upwardTrip?.first?[0].journeyPlannerStationDetail
//                            vc.newupwordtrip = newApiData?.first?.upwardTrip as?[JourneyPlannerModel]
//
//                            vc.downwardTripReturn = newApiData?.first?.downwardTrip?.first?[0].transitPaths as? [TransitPaths]
//                            vc.downwardJourneyReturn = newApiData?.first?.downwardTrip?.first?[0].journeyPlannerStationDetail
//                            vc.PassThellData = newApiData?.first
//                            vc.FullnameFrom = self.btnFrom.currentTitle ?? ""
//                            vc.FullnameTo =  self.btnTo.currentTitle ?? ""
//                            self.navigationController?.pushViewController(vc, animated:true)
//                        }
//                    }else{
//                        if newApiData?.first?.upwardTrip?.first?[0].transitPaths?.count ?? 0 <= 0{
//                            self.showAlertViewWithMessage("APPTITLE".LocalizedString, message: "txtNoTrip".LocalizedString)
//                        }else if newApiData?.first?.downwardTrip?.first?[0].transitPaths?.count ?? 0 <= 0{
//                            self.showAlertViewWithMessage("APPTITLE".LocalizedString, message: "txtNoTrip".LocalizedString)
//                        }
//                        else{
//                            let vc =  UIStoryboard.UpwordNewJourneyVC()
//                            vc.upwardRoundTrip = newApiData?.first?.upwardTrip?.first?[0].transitPaths as? [TransitPaths]
//                            vc.upwardRoundJourney = newApiData?.first?.upwardTrip?.first?[0].journeyPlannerStationDetail
//                            vc.newupwordtrip = newApiData?.first?.upwardTrip as?[JourneyPlannerModel]
//
//                            vc.downwardTripReturn = newApiData?.first?.downwardTrip?.first?[0].transitPaths as? [TransitPaths]
//                            vc.downwardJourneyReturn = newApiData?.first?.downwardTrip?.first?[0].journeyPlannerStationDetail
//                            vc.newupwordtrip = newApiData?.first?.downwardTrip
//
//                            vc.PassThellData = newApiData?.first
//
//                            vc.FullnameFrom = self.btnFrom.currentTitle ?? ""
//                            vc.FullnameTo =  self.btnTo.currentTitle ?? ""
//                            self.navigationController?.pushViewController(vc, animated:true)
//                        }
//                    }
//
//
//
//
//                }
                
                
                //                var param = [String:Any]()
                //                                param["intUserID"] = Helper.shared.objloginData?.intUserID
                //                                param["decFromStationLat"] =  "\(objFrom?.latitude ?? 0)"
                //                                param["decFromStationLong"] =   "\(objFrom?.longitude ?? 0)"
                //                                param["decToStationLat"] =  "\(objTo?.latitude ?? 0)"
                //                                param["decToStationLong"] =  "\(objTo?.longitude ?? 0)"
                //                                param["strStationName"] =  ""
                //                objViewModel.getJourneyPlanner(param: param) { array in
                //                    let vc =  UIStoryboard.JourneyPlannerStationListingVC()
                //                    vc.objStation = objplanner
                //                    vc.arrData = array ?? [JourneyPlannerModel]()
                //                    self.navigationController?.pushViewController(vc, animated:true)
                //                }
            }
            
            
        }else if sender == btnSwitch {
            
            if objFrom == nil  && objTo == nil {
                self.objViewModel.inputErrorMessage.value = "please_select_from_and_to_stations_to_swipe".localized()
                return
            }
            btnFrom .setTitle(nil, for: .normal)
            btnTo .setTitle(nil, for: .normal)
            let obj1 = objFrom
            let obj2 = objTo
            if let obj = obj1 {
                btnTo .setTitle(obj.locationname, for: .normal)
                objTo = obj
            }
            if let obj = obj2 {
                btnFrom .setTitle(obj.locationname, for: .normal)
                objFrom = obj
            }
        }
        else {
            
            let vc = UIStoryboard.ChooseOrginVC()
            vc.arrRecentData = arrRecentData
            //            UserDefaults.standard.set(arrRecentData, forKey: "arrRecentData")
            vc.objParent = self
            if sender.tag == 2{
                vc.titleName = btnTo.currentTitle ?? ""
            }else{
                vc.titleName = btnFrom.currentTitle ?? ""
            }
            vc.completionBlock = { obj in
                sender .setTitle(obj.locationname, for: .normal)
                if sender == self.btnFrom {
                    self.objFrom = obj
                }else if sender == self.btnTo {
                    self.objTo = obj
                }
                
            }
            self.navigationController?.pushViewController(vc, animated:true)
        }
    }
}

extension NewPlaneJourneyVC:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell : FavouriteHeaderCell = tableView.dequeueReusableCell(withIdentifier: "FavouriteHeaderCell") as! FavouriteHeaderCell
        cell.tag = section
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.lblHeaderName.text = "recentsearch".LocalizedString
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        lblNotFound.isHidden = true
        if arrRecentData.count < 1 {
            lblNotFound.isHidden = false
        }
        return arrRecentData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellRecentSearch", for: indexPath) as! cellRecentSearch
        let objdata = arrRecentData[indexPath.row]
        cell.lblFromStation.text = objdata.from_locationname
        cell.lblToStation.text = objdata.to_locationname
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let objData = arrRecentData[indexPath.row]
        
        btnFrom.setTitle(objData.from_locationname, for: .normal)
        btnTo.setTitle(objData.to_locationname, for: .normal)
        
        objFrom = planeStation(locationname: objData.from_locationname, latitude: objData.from_latitude, longitude:objData.from_longitude)
        objTo = planeStation(locationname:objData.to_locationname, latitude: objData.to_latitude, longitude:objData.to_longitude)
        
        
    }
}
extension NewPlaneJourneyVC:ViewcontrollerSendBackDelegate {
    func getInformatioBack<T>(_ handleData: inout T) {
        //        if let data = handleData as? [favouriteList] {
        //            arrfavList = data
        //        }
        //        if let data = handleData as? [Predictions] {
        //            arrPreditction = data
        //        }
        //        if let data = handleData as? [attractionSearchDisplay] {
        //            arrSearchDsiplayData = data
        //        }
    }
}
extension UIViewController{
    func showDropdownMenu(anchorView: UIView, dataSource: [String], selectionAction: @escaping (Int, String) -> Void) {
        let dropDown = DropDown()
        dropDown.anchorView = anchorView
        dropDown.dataSource = dataSource
        dropDown.selectionAction = selectionAction
        dropDown.show()
        // let backgroundImage = UIImage(named: "FeedAddBack")
        //  dropDown.backgroundColor = UIColor(patternImage: backgroundImage!)
        // dropDown.width = 140
    }
}
//extension  NewPlaneJourneyVC:UITextFieldDelegate{
//
//
//    func setupDatePicker() {
//            let datePicker = UIDatePicker()
//            datePicker.datePickerMode = .date
//            datePicker.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
//            txtDate.inputView = datePicker
//
//            let currentDate = Date()
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateStyle = .medium
//        txtDate.text = dateFormatter.string(from: currentDate)
//        }
//    @objc func handleDatePicker(_ datePicker: UIDatePicker) {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateStyle = .medium
//        txtDate.text = dateFormatter.string(from: datePicker.date)
//        }
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//            if textField == txtDate {
//                // Show the date picker when the text field is being edited
//                let datePicker = textField.inputView as? UIDatePicker
//                datePicker?.date = dateFormatter.date(from: textField.text ?? "") ?? Date()
//            }
//        }
//}
//extension NewPlaneJourneyVC {
//    var dateFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        return formatter
//    }
//}


extension UITextField {
    
    func addInputViewDatePicker(target: Any, selector: Selector , datePickerMode:UIDatePicker.Mode,Messageget:String) {
        
        let screenWidth = UIScreen.main.bounds.width
        
        //Add DatePicker as inputView
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        
        datePicker.datePickerMode = datePickerMode
        datePicker.minimumDate = Date()
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        
        
        self.inputView = datePicker
        
        //Add Tool Bar as input AccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)
        
        self.inputAccessoryView = toolBar
    }
    
    func addInputViewDatePickerForMinits(target: Any, selector: Selector , datePickerMode:UIDatePicker.Mode,Messageget:String) {
        
        let screenWidth = UIScreen.main.bounds.width
        
        //Add DatePicker as inputView
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        datePicker.datePickerMode = datePickerMode
        datePicker.locale = Locale(identifier: "en_GB")

        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
//        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
//        datePicker.locale = Locale(identifier: "en_US_POSIX") // Change the identifier if needed

     
        
        
        self.inputView = datePicker
        
        //Add Tool Bar as input AccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)
        
        self.inputAccessoryView = toolBar
    }
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        let currentDate = Date()
        
        if selectedDate < currentDate {
            let alert = UIAlertController(title: "APPTITLE".LocalizedString, message: "txt_error_time".LocalizedString, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func cancelPressed() {
        self.resignFirstResponder()
    }
}
