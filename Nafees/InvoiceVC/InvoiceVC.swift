//
//  InvoiceVC.swift
//  Nafees
//
//  Created by Apple on 13/01/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class InvoiceVC: UIViewController {
     var InvoiceArray = NSMutableArray()
     var strUrl = String()
     var docController: UIDocumentInteractionController!
    
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        WS_GetInvoice()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    self.navigationController?.navigationBar.isHidden = true
    }

    @IBAction func btnBack(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        let leftViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        leftViewController.dailyVC = nvc
        let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
        slideMenuController.delegate = mainViewController
        UIApplication.shared.windows.first?.rootViewController = slideMenuController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    func WS_GetInvoice(){
    
         if HelperClass.isInternetAvailable {
            
            let userdict = AppUserDefault.getUserDetails()
             let userId = userdict.GetInt(forKey: "id")
             SwiftLoader.show(animated: true)
             var param = [String:Any]()
             strUrl = WebServicesLink.getInvoice
            param = ["appid":"com.starwebindia.nafees","userid":userId]
             print("strUrl >>>>>>>>>>\(strUrl)")
             WebService.createRequestAndGetResponse(strUrl, methodType: .POST, andHeaderDict:[:], andParameterDict:param, onCompletion: { (dictResponse,error,reply,statusCode) in
                 SwiftLoader.hide()
                 print("dictResponse >>>\(String(describing: dictResponse))")
                 print("error >>>\(String(describing: error))")
                 print("reply >>>\(String(describing: reply))")
                 print("statuscode >>>\(String(describing: statusCode))")
                 
                 let json = dictResponse! as[String: Any] as NSDictionary
                 print("json>>>>\(json)")
                 var msg = ""
                 msg = json.GetString(forKey: WebServiceConstant.msg)
                 if msg == "" {
                     msg = MessageStringFile.serverError()
                 }
                 if json.count > 0{
                   
                    self.InvoiceArray = json.GetNSMutableArray(forKey: "invoice")
                     print("InvoiceArray",self.InvoiceArray)
                 
                    self.tblView.reloadData()
                 }else{
                 PopUpView.addPopUpAlertView(MessageStringFile.whoopsText(), leftBtnTitle: MessageStringFile.okText(), rightBtnTitle: "", firstLblTitle: "Wrong Details", secondLblTitle: "")
                     PopUpView.sharedInstance.delegate = nil
                 }
             })
         } else {
             PopUpView.addPopUpAlertView(MessageStringFile.whoopsText(), leftBtnTitle:MessageStringFile.okText() , rightBtnTitle:"" , firstLblTitle: MessageStringFile.networkReachability(), secondLblTitle: "")
             PopUpView.sharedInstance.delegate = nil
         }
     }

}

extension InvoiceVC : UITableViewDelegate,UITableViewDataSource,UIDocumentInteractionControllerDelegate{
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
          return 1
      }
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return  InvoiceArray.count
         
      }
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
          return 60
      }
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceCell", for: indexPath) as! InvoiceCell
        let dict:NSMutableDictionary = self.InvoiceArray.getNSMutableDictionary(atIndex: indexPath.row)
            cell.lblInvoiceName.text = dict.GetString(forKey: "title")
          return cell
      }
      
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let dict:NSMutableDictionary = self.InvoiceArray.getNSMutableDictionary(atIndex: indexPath.row)
        
       let path = WebServicesLink.baseUrl + dict.GetString(forKey: "path")
        let newUrl = path.replacingOccurrences(of: "mobileapp/", with: "", options: NSString.CompareOptions.literal, range:nil)
        print("pathhhh",newUrl)
       
       let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "InVoicePdfView") as? InVoicePdfView
       vc?.pdfURl = newUrl
      self.navigationController?.pushViewController(vc!, animated: true)
       
    }
    
    
    
}
class InvoiceCell: UITableViewCell {
    
    @IBOutlet weak var btnInvoice: UIButton!
    @IBOutlet weak var lblInvoiceName: UILabel!
}


