//
//  GrivanceListingVC.swift
//  MMRDA
//
//  Created by Sandip Patel on 01/09/22.
//

import UIKit

class GrivanceListingVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    private var objViewModel = GrivanceViewModel()
    var arrData:[grivanceList]? {
        didSet {
            tblView.reloadData()
        }
    }
    var currentOpenIndex = -1
    override func viewDidLoad() {
        super.viewDidLoad()

        objViewModel.inputErrorMessage.bind { [weak self] in
            if let message = $0,message.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertViewWithMessage("", message:message)
                }
            }
        }
        NotificationCenter.default.addObserver(forName: Notification.GrivanceUpdated, object: nil, queue: .main) { notification in
            self.objViewModel.getGrivanceList { arr in
                self.arrData = arr
            }
        }
        self.objViewModel.getGrivanceList { arr in
            self.arrData = arr
        }
        // Do any additional setup after loading the view.
    }
    

   
}



extension GrivanceListingVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"GrivanceCell") as? GrivanceCell else  { return UITableViewCell() }
        let objData = arrData?[indexPath.row]
        cell.txtGrivanceNO.text = objData?.strComplainCode
        cell.txtCategory.text = objData?.strModeName
        cell.txtSubcatgory.text = objData?.strItemName
        cell.txtFiledDate.text = objData?.dteCreatedOn
        cell.lblStatus.text = objData?.strComplainStatus
        cell.lblOpenDate.text = objData?.dteCreatedOn
        
        cell.stackviewProgress.isHidden = true
        cell.lblCloseDate.superview?.superview?.isHidden = true
        cell.lblProgressDate.superview?.superview?.isHidden = true
        
        cell.lblDescription.text = objData?.strDescription
        cell.lblRoute.text = objData?.strDetails
        cell.lblIncidentDate.text =  objData?.dteCreatedOn
        cell.lblAttachment.text = objData?.strFileName
        cell.imgLine1.isHidden = true
        
        if let date =  objData?.dteComplainCloseDateTime {
            cell.lblCloseDate.superview?.superview?.isHidden = false
            cell.lblCloseDate.text = date
            cell.imgLine2.isHidden = false
        }
        if let date =  objData?.dteComplainInProgressDateTime {
            cell.lblProgressDate.superview?.superview?.isHidden = false
            cell.lblProgressDate.text = date
            cell.imgLine1.isHidden = false
        }
         
        
        if indexPath.row == currentOpenIndex {
            cell.stackviewProgress.isHidden = false
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if currentOpenIndex ==  indexPath.row {
            currentOpenIndex = -1
        }else {
            currentOpenIndex = indexPath.row
        }
        self.tblView.reloadData()
        
     }
}
