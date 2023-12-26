//
//  GrivanceDetailsListingVC.swift
//  MMRDA
//
//  Created by meghana.trivedi on 28/03/23.
//

import UIKit
import SDWebImage

class GrivanceDetailsListingVC: BaseVC {
    
   
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblIncidentDate: UILabel!
    @IBOutlet weak var lblRoute: UILabel!
    
    @IBOutlet weak var imgLine1: UIImageView!
    @IBOutlet weak var txtFiledDate: UILabel!
    @IBOutlet weak var txtSubcatgory: UILabel!
    @IBOutlet weak var txtCategory: UILabel!
    @IBOutlet weak var txtGrivanceNO: UILabel!
    
    @IBOutlet weak var lblOpenDate: UILabel!
    @IBOutlet weak var lblOpenStatus: UILabel!
    @IBOutlet weak var lblProgressDate: UILabel!
    @IBOutlet weak var lblInProgressStatus: UILabel!
    @IBOutlet weak var lblCloseStatus: UILabel!
    @IBOutlet weak var lblCloseDate: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblAttachment: UILabel!
    @IBOutlet weak var stackviewProgress: UIStackView!
    
    @IBOutlet var viewIsueHistory:UIStackView!
    @IBOutlet var lblIsueHistoryTitle:UILabel!
    @IBOutlet var tblIssueHistory:UITableView!
    @IBOutlet var viewIsueHistoryHeight:NSLayoutConstraint!
    
    @IBOutlet var ViewBTNBackView:UIStackView!
    @IBOutlet var btnReject:UIButton!
    @IBOutlet var btnAccept:UIButton!
    
    @IBOutlet var viewPostCommentBackView:UIView!
    @IBOutlet var txtComment:UITextView!
    @IBOutlet var btnPostComment:UIButton!
    @IBOutlet var viewStatusBack:UIView!
    
    @IBOutlet var tblStatusDetails:UITableView!
    @IBOutlet var tblStatusDetailsHeight:NSLayoutConstraint!
    
    @IBOutlet var popupMainBackView:UIView!
    @IBOutlet var popupBackView:UIView!
    @IBOutlet var popupTopImg:UIImageView!
    @IBOutlet var popupTitleLabel:UILabel!
    @IBOutlet var popupbtnNo:UIButton!
    @IBOutlet var popupbtnYes:UIButton!
    @IBOutlet var scrollView: UIScrollView!

    
    var intStatusID = 0
    var getGrivanceObj: grivanceList?
//    {
//        didSet {
//            if getGrivanceObj == nil{
////                self.lblNoData.isHidden = false
//                self.tblIssueHistory.isHidden = true
//            }else{
////                self.lblNoData.isHidden = true
//                self.tblIssueHistory.isHidden = false
//            }
//            tblIssueHistory.reloadData()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.callBarButtonForHome(isloggedIn:true,leftBarLabelName:getGrivanceObj?.strComplainCode ?? "", isHomeScreen:false,isDisplaySOS: false)
        setUPUI()
        self.title = getGrivanceObj?.strComplainCode ?? ""
        self.setBackButton()
        self.setRightHomeButton()
//        let barButton = UIBarButtonItem(image: UIImage(named:"Home"), style:.plain, target: self, action: #selector(gotoHome))
//        barButton.tintColor = UIColor.white
//        self.navigationItem.rightBarButtonItem = barButton
        
        
        tblIssueHistory.tableFooterView = UIView()
        tblStatusDetails.tableFooterView = UIView()
        
       // tblIssueHistory.reloadData()
        
        scrollView.delegate = self

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let objData = getGrivanceObj
        txtGrivanceNO.text = objData?.strComplainCode
        txtCategory.text = objData?.strModeName
        txtSubcatgory.text = objData?.strItemName
        txtFiledDate.text = objData?.dteCreatedOn
       lblStatus.text = objData?.strComplainStatus
//        lblOpenDate.text = objData?.dteCreatedOn
        
       // stackviewProgress.isHidden = false
      //  lblCloseDate.superview?.superview?.isHidden = true
        //lblProgressDate.superview?.superview?.isHidden = true
        
        lblDescription.text = objData?.strDescription
        lblRoute.text = objData?.strDetails
        lblIncidentDate.text =  objData?.dteCreatedOn
        lblAttachment.text = objData?.strFileName
        //imgLine1.isHidden = true
        viewStatusBack.backgroundColor = UIColor(hexString: objData?.strStatusColour ?? "FFE923")
        lblStatus.textColor = .black
        
        if let date =  objData?.dteComplainCloseDateTime {
//            lblCloseDate.superview?.superview?.isHidden = true
//            lblCloseDate.text = date
//            imgLine2.isHidden = true
//           imgLine1.isHidden = true
        }
        if let date =  objData?.dteComplainInProgressDateTime {
//            lblProgressDate.superview?.superview?.isHidden = true
//           lblProgressDate.text = date
            //imgLine1.isHidden = true
        }
        ViewBTNBackView.isHidden = true
        if objData?.intComplainStatusID == 6{
            ViewBTNBackView.isHidden = false
        }
        if objData?.intComplainStatusID == 3{
            viewPostCommentBackView.isHidden = true
        }
//        viewIsueHistoryHeight.constant = CGFloat(getGrivanceObj?.comments?.count ?? 0) * 70 + 20
//        tblStatusDetailsHeight.constant = CGFloat(getGrivanceObj?.statusTrack?.count ?? 0) * 60
//        tblIssueHistory.reloadData()
//        tblIssueHistory.layoutIfNeeded()
//
//        tblStatusDetails.reloadData()
//        tblStatusDetails.layoutIfNeeded()
//        tblStatusDetails.layoutIfNeeded()
        popupMainBackView.isHidden = true
        
        txtComment.delegate = self
        txtComment.text = "Comment..."
        txtComment.textColor = .lightGray
        
        DispatchQueue.main.async {
            self.viewIsueHistoryHeight.constant = self.tblIssueHistory.contentSize.height
            self.tblIssueHistory.layoutIfNeeded()
        }
    }
    
    
}
extension GrivanceDetailsListingVC:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
}
extension GrivanceDetailsListingVC:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if txtComment.textColor == UIColor.lightGray {
            txtComment.text = nil
            txtComment.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if txtComment.text.isEmpty {
            txtComment.text = "Comment..."
            txtComment.textColor = .lightGray
        }
    }
}

extension GrivanceDetailsListingVC{
    func setUPUI(){
        tblIssueHistory.register(UINib(nibName: "IssueHistoryCell", bundle: nil), forCellReuseIdentifier: "IssueHistoryCell")
        
        tblStatusDetails.register(UINib(nibName: "statusTrackCell", bundle: nil), forCellReuseIdentifier: "statusTrackCell")
        
    }
}
extension GrivanceDetailsListingVC{
    @IBAction func btnRejectClick(_ sender: UIButton) {
        popupTitleLabel.text = "btnGrevienceRejectTxt".LocalizedString
        popupTopImg.image = UIImage(named: "Reject")
        popupMainBackView.isHidden = false
        intStatusID = 4
    }
    @IBAction func btnAcceptClick(_ sender: UIButton) {
        popupTitleLabel.text = "btnGrevienceAcceptTxt".LocalizedString
        popupTopImg.image = UIImage(named: "Success")
        popupMainBackView.isHidden = false
        intStatusID = 3
    }
    @IBAction func btnPostCommentClick(_ sender: UIButton) {
        if txtComment.text == ""{
            self.showAlertViewWithMessage("", message: "txtGrevienceComment".LocalizedString)
        }else{
            if intStatusID == 0 {
                getRouteListAccept()
            }
        }
    }
    @IBAction func btnPopupNoClick(_ sender: UIButton) {
        popupMainBackView.isHidden = true
    }
    @IBAction func btnPopupYesClick(_ sender: UIButton) {
        getRouteListAccept()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.intStatusID = 0
        }
    }
}
extension GrivanceDetailsListingVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblIssueHistory{
            return getGrivanceObj?.comments?.count ?? 0
        }else{
            return getGrivanceObj?.statusTrack?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cell for row count.......\(getGrivanceObj?.comments?.count ?? 0)")
        if tableView == tblIssueHistory{
            print("Else part count.......\(getGrivanceObj?.comments?.count ?? 0)")
            let cell = tableView.dequeueReusableCell(withIdentifier: "IssueHistoryCell", for: indexPath) as! IssueHistoryCell
            let data = getGrivanceObj?.comments?[indexPath.row]
            
            cell.lblProfileNm.text = data?.strUserName
            cell.lblProfileDate.text = data?.dteCommentCreatedOn
            cell.lblProfileDescription.text = "\("description".LocalizedString): \(data?.strRemarks ?? " - ")"
            
            if let strURl = URL(string:(data?.strProfileUrl ?? "").addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? "") {
                cell.imgProfile.sd_setImage(with: strURl, placeholderImage: UIImage(named: "Profile"), context:nil)
            }else {
                cell.imgProfile.image = UIImage(named: "Profile")
            }
            
      
            
            return cell
        }else  {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "statusTrackCell", for: indexPath) as! statusTrackCell
            let data = getGrivanceObj?.statusTrack?[indexPath.row]
            cell.lblStatusDate.text = data?.dteStatusCreatedOn
            cell.lblStatusTitle.text =   data?.strStatusName
            
            if getGrivanceObj?.statusTrack?.count == indexPath.row-1{
                cell.imgLine.isHidden = true
            }
            
            return cell
        }
       
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
}
extension GrivanceDetailsListingVC{
    func getRouteListAccept(){
        var param = [String:Any]()
        param["intStatusID"] = self.intStatusID
        param["strRemark"]  = txtComment.text
        param["intComplainID"] = getGrivanceObj?.intComplainID
        param["intUserID"] = Helper.shared.objloginData?.intUserID
        
        ApiRequest.shared.requestPostMethod(strurl: apiName.UpdateComplainStatus_Accept, params:param, showProgress: true, completion: { suces, data, error in
            do {
                print(data)
                let obj = try JSONDecoder().decode(AbstractResponseModel<(ModelAcceptComplainStatus)>.self, from: data)
                if obj.issuccess ?? false {
                    self.showAlertViewWithMessageAndActionHandler("", message: obj.message ?? "", actionHandler: {
                        self.navigationController?.popViewController(animated: true)
                    })
                }else {
                    if let message = obj.message {
                        self.showAlertViewWithMessage("", message: message)
                        DispatchQueue.main.async {
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                    }
                }
               
            }catch {
                print(error)
            }
        })
    }

}
