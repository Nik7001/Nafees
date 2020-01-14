//
//  WebSeviceConstant.swift


import Foundation
import UIKit

class WebServicesLink: NSObject {
    
    static let  BaseUrl = "http://nafees.co/crm/mobileapp/"
   
    class var baseUrl: String {
        get {
            if let dict = UserDefaults.standard.dictionary(forKey: AppUserDefault.baseUrlData) {
                let dictData = dict as NSDictionary
                let baseUrl = dictData.GetString(forKey: "baseurl")
                if baseUrl.Length > 0 {
                    return baseUrl
                }
            }
            return WebServicesLink.BaseUrl.replacingOccurrences(of: "baseurl", with: "")
        }
    }
    
    func getToken() -> [String: AnyObject]{
        let dict : NSDictionary = AppUserDefault.getUserDetails()//
        let tkn  = HelperClass.checkObjectInDictionary(dictH: dict, strObject: "token")
        if tkn != ""{
           
            let header = ["token": tkn]
            // "content_type":"application/x-www-form-urlencoded"
            return header as [String : AnyObject]
        }
        return  [ : ]
    }
    
    func getProfileImage()-> String{
        var imgStr = String()
        let dict:NSDictionary = AppUserDefault.getBaseUrlData()!
        
        imgStr = dict.GetString(forKey:  "picture")
        return imgStr
    }
    
    
    class var login: String {
        get {
            return (baseUrl + "loginUser")
        }
    }
    class var getReportEntryData: String {
        get {
            return (baseUrl + "getReportEntryData")
        }
    }
    class var creditreports: String {
           get {
               return (baseUrl + "credit-reports")
           }
       }
    
   
   
    class var ForgotPassword: String {
        get {
            return (baseUrl + "customer/api_forgot_password?")
        }
    }
    
    class var addFavAddress: String {
        get {
            return (baseUrl + "address/api_add?")
        }
    }
    
    class var GetFavAddress: String {
        get {
            return (baseUrl + "address/api_view?")
        }
    }
    
    class var DeleteFavAddress: String {
        get {
            return (baseUrl + "address/api_delete?")
        }
    }
    class var log_out: String {
        get {
            return (baseUrl + "customer/customer/api_logout?")
        }
    }
    
    class var category_list: String {
        get {
            return (baseUrl + "reward/api_all_category?")
        }
    }
    class var redeem_list: String {
        get {
            return (baseUrl + "reward/reward/api_redim?")
        }

    }
    class var redeem_history: String {
        get {
            return (baseUrl + "reward/api_redim_history?")
        }
    }
    class var all_notification: String {
        get {
            return (baseUrl + "push/api_all?")
        }
    }
    class var upload_ticket: String {
        get {
            return (baseUrl + "reward/api_add_ticket?")
        }
    }
    
    
}
class WebServiceConstant: NSObject {
    static let status = "success"
     static let Error = "FAIL"
    static let success = "success"
    static let msg = "message"
    static let result = "result"
    static let baseurl = "base_url"
    static let customer = "customer"
    static let email = "email"
    static let mobile_number = "mobile_number"
    static let password = "password"
    static let confirm_Password = "confirmPassword"
   
    static let newpassword = "new"
    static let oldpassword = "current"
    static let repassword = "re"
    static let user_type = "user_type"
    static let picture = "picture"
    static let birthmonth = "birthmonth"
    static let point = "point"
    static let aboutApp = "about"
    static let user_id = "user_id"
    static let id = "id"
    /*social_key,social_type*/
    static let socialType = "social"
    static let profile_image = "picture"
    static let profile_id = "profileID"
    static let first_name = "fname"
    static let last_name = "lname"
   
   
    
    //Jdata_dod
    static let device_type = "device"
    static let app_version = "app_version"
    static let os_version = "os_version"
    static let network_type = "network_type"
    static let network_provider = "network_provider"
    
    static let name = "name"
    static let address = "address"
    static let latitude = "latitude"
    static let longitude = "longitude"
    static let addressID    = "addressID"
    static let productID = "productID"
    
}

struct WS_Status {
    static let success:  UInt = 200
    static let error204: UInt = 204
    static let error401: UInt = 401
    static let error422: UInt = 422
}

