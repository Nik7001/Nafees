//
//  AppDelegate.swift
//  Nafees
//
//  Created by Apple on 12/01/20.
//  Copyright © 2020 Apple. All rights reserved.
//

/*example userid = 1, password = 123xyz

result=>-1; Wrong User ID Or Password.
result=>1; successfully login
otherwise; some error

GET ENRTY DATA API :
            url : http://nafees.co/crm/mobileapp/getReportEntryData
            post : appid

SAVE REPORT API :
            url : http://nafees.co/crm/mobileapp/saveDailyReport
            post : appid,userid,driver_id,report_date,truck_no,order_no,city,site,site_amount,waiting_reason,waiting_time,waiting_time_amount,latitude,longitude,location,filename

example    userid = 1,driver_id = xyz123, report_date = 2020-01-13, truck_no = 123456, order_no = 123asd, city = SANDIRASKO, site = 123456, site_amount = 450, waiting_reason = terminal shut down, waiting_time = 60, waiting_time_amount = 10, latitude = 22.7744, longitude = 47.1144, location = sadar colony, sandiras, pincode 234556

if image add then send to filename in post;filename is image file

result=>0; Order number is already existed.
result=>1; Saved daily report.
result=>-1; Failed to save daily report.
otherwise; some error

GET REPORT API :
            url : http://nafees.co/crm/mobileapp/getReports
            post : appid,userid,from_date,to_date

example userid = 1, from_date = 2020-01-13, to_date = 2020-01-20

GET INVOICE API :
            url : http://nafees.co/crm/mobileapp/getInvoice
            post : appid,userid

example userid = 1*/


import UIKit
import CoreData
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var deviceTokenString: String?
    
     var reachability:Reachability?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
          IQKeyboardManager.shared.enable = true
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Nafees")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

