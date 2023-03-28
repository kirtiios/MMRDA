//
//  SOSContact.swift
//  MMRDA
//
//  Created by Sandip Patel on 02/09/22.
//

import Foundation


class SOSContact: NSObject, NSCoding,NSSecureCoding{
    static var supportsSecureCoding: Bool = true
    
    open var SOSContact_ContactId : String = ""
    open var SOSContact_Name : String = ""
    open var SOSContact_Phone : String = ""
    
    init(contactId : String ,name: String, phone: String) {
        self.SOSContact_ContactId = contactId
        self.SOSContact_Name = name
        self.SOSContact_Phone = phone
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.SOSContact_ContactId = aDecoder.decodeObject(forKey: "contactid") as? String ?? ""
        self.SOSContact_Name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        self.SOSContact_Phone = aDecoder.decodeObject(forKey: "phone") as? String ?? ""
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(SOSContact_ContactId, forKey: "contactid")
        aCoder.encode(SOSContact_Name, forKey: "name")
        aCoder.encode(SOSContact_Phone, forKey: "phone")
    }
}
