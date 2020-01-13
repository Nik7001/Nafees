//

//  TransitSTLAppUserDefaults.swift
//

//
import Foundation
import UIKit

class AppUserDefault: NSObject {
  static let defaultVar = UserDefaults.standard
    static let baseUrlData = "baseUrlData"
    static let dictUserDetils = "dictUserDetils"
    static let dictSocialUserDetils = "dictSocialUserDetils"
    static let loginStatus = "loginStatus"
    static let loginType = "loginType"
    
    class func setBaseUrlData(dict:NSDictionary) {
        
        defaultVar.removeObject(forKey: baseUrlData)
        let data = NSKeyedArchiver.archivedData(withRootObject: dict)
        defaultVar.set(data, forKey: baseUrlData)
    }
    
    class func getBaseUrlData() -> NSDictionary? {
        let data = defaultVar.object(forKey: baseUrlData) as! NSData
        return NSKeyedUnarchiver.unarchiveObject(with: data as Data) as? NSDictionary
    }
    
   
    class func setUserLoginStatus(status: Int?) {
        if status == 1 {
            defaultVar.set(1, forKey: loginStatus)
        } else {
            defaultVar.removeObject(forKey: loginStatus)
        }
    }
    
    
    class var isUserLogin: Bool {
        get {
            if defaultVar.integer(forKey: loginStatus) != 0 {
                return true
            }
            return false
        }
    }
    
    class func setUserDetails(dict:NSMutableDictionary) {
        defaultVar.removeObject(forKey: self.dictUserDetils)
        let data = NSKeyedArchiver.archivedData(withRootObject: dict)
        defaultVar.set(data, forKey: self.dictUserDetils)
    }
    
    
    
    
    class func getUserDetails() -> NSMutableDictionary {
    let data = defaultVar.object(forKey: self.dictUserDetils)
        if data != nil {
            return NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! NSMutableDictionary
        }
        return NSMutableDictionary()
    }
    
    class func setSocialUserDetails(dict:NSMutableDictionary) {
        defaultVar.removeObject(forKey: self.dictSocialUserDetils)
        let data = NSKeyedArchiver.archivedData(withRootObject: dict)
        defaultVar.set(data, forKey: self.dictSocialUserDetils)
    }
    
    class func getSocailUserDetails() -> NSMutableDictionary {
        let data = defaultVar.object(forKey: self.dictSocialUserDetils)
        if data != nil {
            return NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! NSMutableDictionary
        }
        return NSMutableDictionary()
    }
    
    
    class func removeAll(key:String) {
        defaultVar.removeObject(forKey: key)
    }
}
