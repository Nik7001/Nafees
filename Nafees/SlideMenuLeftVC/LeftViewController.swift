//
//  LeftViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit

enum LeftMenu: Int {
    
    case Daily = 0
    case Weekly
    case Invoice
    case Logout
 }

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class LeftViewController : UIViewController, LeftMenuProtocol,PopUpViewDelegate {
    var Email = String()
   
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var menus = ["Daily Report", "Weekly Report","Invoice","Logout"]
   
    var menuImg = ["16-daily-report", "16-weekly-report","16-invoice","32-logout"]
   
    var dailyVC: UIViewController!
    var WeekVC: UIViewController!
    var InvoiceVC: UIViewController!
    var LogoutVC: UIViewController!
   
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
       // let dict =  AppUserDefault.getUserDetails()
               //    print("",dict)
        //let num = dict.GetInt(forKey: "num")
        
        
//        let dict =  AppUserDefault.getUserDetails()
//        print("dict111",dict)
//        Email = dict.GetString(forKey: "email")
//        labelFullname.text = dict.GetString(forKey: "fname")
//        let urlstring = dict.GetString(forKey: "picture")
//        imgProfile.sd_setImage(with: URL(string:urlstring), placeholderImage: UIImage(named: "profileimg"))
      
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let DAILY = storyboard.instantiateViewController(withIdentifier: "DailyReportVC") as! DailyReportVC
        self.dailyVC = UINavigationController(rootViewController: DAILY)
       
        let week = storyboard.instantiateViewController(withIdentifier: "WeeklyReportVC") as! WeeklyReportVC
        self.WeekVC = UINavigationController(rootViewController: week)

        let Invoice = storyboard.instantiateViewController(withIdentifier: "InvoiceVC") as! InvoiceVC
        self.InvoiceVC = UINavigationController(rootViewController: Invoice)
        let logoutVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.LogoutVC = UINavigationController(rootViewController: logoutVC)
        

    }
    override func viewWillAppear(_ animated: Bool) {
        let dict =  AppUserDefault.getUserDetails()
        print("sidemenudict",dict)
        
       // let urlstring = dict.GetString(forKey:"picture")
        //imgProfile.sd_setImage(with: URL(string:urlstring), placeholderImage: UIImage(named: "profileimg"))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
//    @objc func methodReceveNoification(notification: Notification){
//        print("notification\(notification)")
//    self.slideMenuController()?.changeMainViewController(self.notificatioVC, close: true)
//        
//    }
//    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.imgProfile.layoutIfNeeded()
      
    }
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .Daily:
        self.slideMenuController()?.changeMainViewController(self.dailyVC, close: true)
            
        case .Weekly:
        self.slideMenuController()?.changeMainViewController(self.WeekVC, close: true)
        case .Invoice:
    self.slideMenuController()?.changeMainViewController(self.InvoiceVC, close: true)
        case .Logout:
        PopUpView.addPopUpAlertView(MessageStringFile.confirmText(), leftBtnTitle: MessageStringFile.noText(), rightBtnTitle: MessageStringFile.yesText(), firstLblTitle: "Are you sure, you want to logout ?", secondLblTitle: "")
            PopUpView.sharedInstance.delegate = self
        //
           break;
        }
    }
    //MARK:- POPUP
    func clickOnPopUpLeftButton() {
        
    }
    
    func clickOnPopUpRightButton() {
         // AppUserDefault.setUserLoginStatus(status: 0)
           AppUserDefault.setUserLoginStatus(status: 0)
          AppUserDefault.removeAll(key:AppUserDefault.dictUserDetils)
       // WS_Logout()
        self.slideMenuController()?.changeMainViewController(self.LogoutVC, close: true)
         let logoutVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            if let navigationController =  UIApplication.shared.windows.first?.rootViewController as? UINavigationController {
            navigationController.pushViewController(logoutVC, animated: true)
        }
    }
    
//    //MARK:- WSservices >>>>>>>>>>>>
//    func WS_Logout() {
//        if HelperClass.isInternetAvailable {
//            SwiftLoader.show(animated: true)
//
//
//            let strUrl = WebServicesLink.log_out
//
//            var param = [String:Any]()
//
//            param = [WebServiceConstant.email:Email,WebServiceConstant.device_type:appDelegate.deviceTokenString ?? ""]
//            print("param >>>>>>>>>>\(param)")
//            print("param >>>>>>>>>>\(strUrl)")
//
//            WebService.createRequestAndGetResponse(strUrl, methodType: .POST, andHeaderDict:[:], andParameterDict: param, onCompletion: { (dictResponse,error,reply,statusCode) in
//                print("dictResponse >>>\(String(describing: dictResponse))")
//                print("error >>>\(String(describing: error))")
//                print("reply >>>\(String(describing: reply))")
//                print("statuscode >>>\(String(describing: statusCode))")
//                SwiftLoader.hide()
//                let json = dictResponse! as[String: Any] as NSDictionary
//                print("json>>>>\(json)")
//
//                var msg = ""
//                msg = json.GetString(forKey: WebServiceConstant.msg)
//                if msg == "" {
//                    msg = MessageStringFile.serverError()
//                }
//                if json.count > 0 {
//
//                    if statusCode == WS_Status.success {
//                        if json.GetString(forKey: WebServiceConstant.status) == "SUCCESS" {
//                            let dict:NSMutableDictionary = json.GetNSMutableDictionary(forKey: WebServiceConstant.result)
//                            print("dict >>>>>>>>>>\(dict)")
//                                AppUserDefault.setUserLoginStatus(status: 0)
//                            //AppUserDefault.removeAll(key:AppUserDefault.dictUserDetils)
//                        self.slideMenuController()?.changeMainViewController(self.logoutVC, close: true)
//                            let logoutVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                        if let navigationController = appDelegate.window?.rootViewController as? UINavigationController {
//                    navigationController.pushViewController(logoutVC, animated: true)
//                            }
//                            SwiftLoader.hide()
//
//
//
//                        } else if json.GetString(forKey: WebServiceConstant.status) == "FAIL" {
//
//                            let Errormsg = json.GetString(forKey:"ERROR")
//
//                            print("dict >>>>>>>>>>\(Errormsg)")
//                            PopUpView.addPopUpAlertView(MessageStringFile.whoopsText(), leftBtnTitle: MessageStringFile.okText(), rightBtnTitle: "", firstLblTitle: Errormsg, secondLblTitle: "")
//                            PopUpView.sharedInstance.delegate = nil
//                            //  let vc = self.storyboard?.instantiateViewController(withIdentifier: "SingUpViewController") as! SingUpViewController
//                            // vc.preDictSocialLogin = self.dictSocialLogin
//                            //self.navigationController?.pushViewController(vc, animated: true)
//                        } else {
//                            PopUpView.addPopUpAlertView(MessageStringFile.whoopsText(), leftBtnTitle: MessageStringFile.okText(), rightBtnTitle: "", firstLblTitle: msg, secondLblTitle: "")
//                            PopUpView.sharedInstance.delegate = nil
//                        }
//                    } else {
//                        PopUpView.addPopUpAlertView(MessageStringFile.whoopsText(), leftBtnTitle: MessageStringFile.okText(), rightBtnTitle: "", firstLblTitle: msg, secondLblTitle: "")
//                        PopUpView.sharedInstance.delegate = nil
//                    }
//                } else {
//                    PopUpView.addPopUpAlertView(MessageStringFile.whoopsText(), leftBtnTitle: MessageStringFile.okText(), rightBtnTitle: "", firstLblTitle: msg, secondLblTitle: "")
//                    PopUpView.sharedInstance.delegate = nil
//                }
//            })
//        } else {
//            PopUpView.addPopUpAlertView(MessageStringFile.whoopsText(), leftBtnTitle:MessageStringFile.okText() , rightBtnTitle:"" , firstLblTitle: MessageStringFile.networkReachability(), secondLblTitle: "")
//            PopUpView.sharedInstance.delegate = nil
//        }
//    }
  
}

extension LeftViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .Daily, .Weekly,.Invoice,.Logout:
                return 48
            }
        }
        return 48
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
           

        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
}

extension LeftViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuImg.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .Daily, .Weekly,.Invoice,.Logout:
                let cell = tableView.dequeueReusableCell(withIdentifier: "BaseTableViewCell", for: indexPath) as! BaseTableViewCell
               
                cell.lblName?.text = menus[indexPath.row]
                cell.imgIcon.image = UIImage(named: menuImg[indexPath.row])
               
                return cell
            }
        }
        return UITableViewCell()
    }
    
}
