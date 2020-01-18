//
//  ReportDetailVC.swift
//  Nafees
//
//  Created by Apple on 18/01/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import PDFGenerator
class ReportDetailVC: UIViewController,UIDocumentInteractionControllerDelegate {
    
   
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var viewTruck: UIView!
    
    @IBOutlet weak var viewCity: UIView!
    
    @IBOutlet weak var viewTime: UIView!
    
    @IBOutlet weak var lblOrderNo: UILabel!
    @IBOutlet weak var viewGrossTotal: UIView!
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTruckNo: UILabel!
    
    @IBOutlet weak var lblDriver: UILabel!
    
    @IBOutlet weak var lblCity: UILabel!
    
    @IBOutlet weak var lblSite: UILabel!
    
    @IBOutlet weak var lblWaitingTime: UILabel!
    
    @IBOutlet weak var lblWaitingReason: UILabel!
     fileprivate var outputAsData: Bool = false
    var ReportId = Int()
    var arrReport = NSArray()
    var grossAmout = 0.0
    var waitingAmout = 0.0
    
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblGst: UILabel!
    
    @IBOutlet weak var lblGross: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         WS_GetReports()
        lblOrderNo.setCornerRadiousAndBorder(.lightGray, borderWidth: 0.8, cornerRadius:4)
        viewCity.setCornerRadiousAndBorder(.lightGray, borderWidth: 0.8, cornerRadius:4)
        
        viewTime.setCornerRadiousAndBorder(.lightGray, borderWidth: 0.8, cornerRadius:4)
        
         viewTruck.setCornerRadiousAndBorder(.lightGray, borderWidth: 0.8, cornerRadius:4)
        
          viewGrossTotal.setCornerRadiousAndBorder(.lightGray, borderWidth: 0.8, cornerRadius:4)
        
        
        
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
    
    @IBAction func btnPDf(_ sender: Any) {
        //generatePDF()
        createPdfFromView(aView: viewMain, saveToDocumentsWithFileName: "Invoice.Pdf")
    }
  
    
    
    @IBAction func btnPrinter(_ sender: Any) {
        let printInfo = UIPrintInfo(dictionary:nil)
              printInfo.outputType = UIPrintInfo.OutputType.general
                  printInfo.jobName = "Invoice"

                  // Set up print controller
              let printController = UIPrintInteractionController.shared
                  printController.printInfo = printInfo
                  printController.printingItem = self.viewMain.toImage()
              printController.present(from: self.viewMain.frame, in: self.viewMain, animated: true, completionHandler: nil)
    }
    
    
    func createPdfFromView(aView: UIView, saveToDocumentsWithFileName fileName: String)
      {
          let pdfData = NSMutableData()
          UIGraphicsBeginPDFContextToData(pdfData, aView.bounds, nil)
          UIGraphicsBeginPDFPage()

          guard let pdfContext = UIGraphicsGetCurrentContext() else { return }

          aView.layer.render(in: pdfContext)
          UIGraphicsEndPDFContext()

          if let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
              let documentsFileName = documentDirectories + "/" + fileName
              debugPrint(documentsFileName)
              pdfData.write(toFile: documentsFileName, atomically: true)
           let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: documentsFileName))
                            dc.delegate = self
                            dc.presentPreview(animated: true)
                            
                          // let vc = self.storyboard?.instantiateViewController(withIdentifier: "InVoicePdfView") as! InVoicePdfView
                           //     vc.pdfViewdata = pdfPath
                          // self.navigationController?.pushViewController(vc, animated: true)
                        
          }
      }
    
    
   
   func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self//or use return self.navigationController for fetching app navigation bar colour
    
    }
    
    
    func WS_GetReports(){
    
         if HelperClass.isInternetAvailable {
             SwiftLoader.show(animated: true)
             var param = [String:Any]()
            let strUrl = WebServicesLink.getReportDetail
            param = ["appid":"com.starwebindia.nafees","reportid":ReportId]
             print("strUrl >>>>>>>>>>\(strUrl)")
            print("param",param)
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
                    self.arrReport = json.GetNSMutableArray(forKey: "report")
                    print("arrReport",self.arrReport)
                    for newdict in self.arrReport{
                    let dict:NSMutableDictionary = newdict as! NSMutableDictionary
                        self.lblOrderNo.text = "#" + dict.GetString(forKey: "order_no")
                        self.lblCity.text = dict.GetString(forKey: "city")
                        self.lblSite.text = dict.GetString(forKey: "site")
                        self.lblDate.text = dict.GetString(forKey: "report_date")
                        self.lblTruckNo.text = dict.GetString(forKey: "truck_no")
                        self.lblWaitingTime.text = dict.GetString(forKey: "waiting_time") + "" + "Min."
                        self.lblWaitingReason.text = dict.GetString(forKey: "waiting_reason")
                        self.waitingAmout = Double(dict.GetString(forKey: "waiting_time_amount")) ?? 0
                        self.grossAmout += Double(dict.GetString(forKey: "site_amount")) ?? 0
                        self.lblDriver.text = "TEST"
                    }
                    var sum = 0.0
                    sum +=  self.grossAmout + Double(self.waitingAmout)
                    let value = self.calculatePercentage(value: sum ,percentageVal: 13)
                   let pi: Double = value
                    self.lblGst.text = "$" + String(format:"%.2f", pi)
                print(value)
                  self.lblGross.text = "$" + "\(sum)"
                var TotalSum = 0.0
                TotalSum +=  sum + pi
                self.lblTotal.text = "$" + String(format:"%.2f", TotalSum)
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
    
    public func calculatePercentage(value:Double,percentageVal:Double)->Double{
           let val = value * percentageVal
           return val / 100.0
       }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
