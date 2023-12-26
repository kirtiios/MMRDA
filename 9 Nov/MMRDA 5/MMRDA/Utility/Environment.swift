import Foundation

struct Environment {
    
    enum Keys: String {
        case DOMAIN_URL = "DOMAIN_URL"
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary
        else {
            fatalError("Plist file not found")
        }
        
        return dict
    }()
    
    private static subscript<T>(_ key: Environment.Keys) -> T? {
        return infoDictionary[key.rawValue] as? T
    }
    
    static var DOMAIN_URL: String {
        return "https://webapi.mmmocl.co.in/api/"
       // return "https://mmrdaapibeta.infinium.management/api/"
      //  return  "https://mmrdaapidev.amnex.com/api/" //(self[.DOMAIN_URL] ?? "") .replacingOccurrences(of: "\\", with: "")
    }
    

}
