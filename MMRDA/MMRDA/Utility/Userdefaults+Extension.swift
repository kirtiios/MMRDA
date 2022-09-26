//
//  Userdefaults+Extension.swift
//  MMRDA
//
//  Created by Sandip Patel on 22/08/22.
//

import Foundation

enum userDefaultKey : String {
    case isLoggedIn
    case logedUserData
    case logedRememberMe
    case isMpinEnable
    case stationList
}

extension UserDefaults {
    
    // MARK: - User Defaults
    func decode<T : Codable>(for type : T.Type, using key : String) -> T? {
        let defaults = UserDefaults.standard
        guard let data = defaults.object(forKey: key) as? Data else {return nil}
        let decodedObject = try? PropertyListDecoder().decode(type, from: data)
        return decodedObject
    }
    
    func encode<T : Codable>(for type : T, using key : String) {
        let defaults = UserDefaults.standard
        let encodedData = try? PropertyListEncoder().encode(type)
        defaults.set(encodedData, forKey: key)
        defaults.synchronize()
    }
    
    /**
     sets/adds object to NSUserDefaults
     
     - parameter aObject: object to be stored
     - parameter defaultName: key for object
     */
    class func setObject(_ value: AnyObject?, forKey defaultName: String) {
        UserDefaults.standard.set(value, forKey: defaultName)
        UserDefaults.standard.synchronize()
    }
    
    /**
     gives stored object in NSUserDefaults for a key
     
     - parameter defaultName: key for object
     
     - returns: stored object for key
     */
    class func objectForKey(_ defaultName: String) -> AnyObject? {
        return UserDefaults.standard.object(forKey: defaultName) as AnyObject?
    }
    
    /**
     removes object from NSUserDefault stored for a given key
     
     - parameter defaultName: key for object
     */
    class func removeObjectForKey(_ defaultName: String) {
        UserDefaults.standard.removeObject(forKey: defaultName)
        UserDefaults.standard.synchronize()
    }
    
    //MARK: Check Login
    func setLoggedIn(value: Bool) {
        set(value, forKey: userDefaultKey.isLoggedIn.rawValue)
    }
    
    func isLoggedIn()-> Bool {
        return bool(forKey: userDefaultKey.isLoggedIn.rawValue)
    }
}

