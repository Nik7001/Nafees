//
//  WeeklyReportVC.swift
//  Nafees
//
//  Created by Apple on 13/01/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import PDFKit
import PDFGenerator
class WeeklyReportVC: UIViewController,UISearchBarDelegate,UIDocumentInteractionControllerDelegate {
   
    @IBOutlet weak var lblTotalPay: UILabel!
    @IBOutlet weak var lblHst: UILabel!
    @IBOutlet weak var lblWaitingCost: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblHieghtConst: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnEndStart: UIButton!
    @IBOutlet weak var btnWeekStart: UIButton!
   var toolBar = UIToolbar()
   var datePicker  = UIDatePicker()
    var arrWeek = NSArray()
    var arrFiltered = NSArray()
    var buttonType = ""
    var TotalPay = 0.0
    var Waiting_Amount = 0.0
    var Hst = 0.0
    var searchActive : Bool = false
    fileprivate var outputAsData: Bool = false
    @IBOutlet var viewMain: UIView!
    var printPDF = Data()
    override func viewDidLoad() {
        super.viewDidLoad()
        btnWeekStart.setCornerRadiousAndBorder(.systemBlue, borderWidth: 1, cornerRadius: btnWeekStart.frame.size.height/2)
        btnEndStart.setCornerRadiousAndBorder(.systemBlue, borderWidth: 1, cornerRadius: btnEndStart.frame.size.height/2)
        searchBar.setCornerRadiousAndBorder(.systemBlue, borderWidth: 1, cornerRadius: searchBar.frame.size.height/2)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        btnWeekStart.setTitle(formatter.string(from: Calendar.current.date(byAdding: .day, value: -6, to: Date())!), for: .normal)
        btnEndStart.setTitle(formatter.string(from:Date()), for: .normal)
        lblDate.text = formatter.string(from: Date())
        searchBar.delegate = self
        // Do any additional setup after loading the view.
        WS_GetReports()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    self.navigationController?.navigationBar.isHidden = true
        }
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
        DispatchQueue.main.async(execute: { () -> Void in
            self.tblView.reloadData()
            self.view.layoutIfNeeded()
            self.tblHieghtConst.constant = self.tblView.contentSize.height
           
               })
               
       }
    override func viewDidLayoutSubviews() {
        DispatchQueue.main.async(execute: { () -> Void in
                   self.tblView.reloadData()
                   self.view.layoutIfNeeded()
                   self.tblHieghtConst.constant = self.tblView.contentSize.height
                  
                      })
    }

    @IBAction func BtnBack(_ sender: Any) {
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
    
    
    ////// SearchBar Delegate
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchActive = false;
            self.searchBar.resignFirstResponder()
            DispatchQueue.main.async(execute: {
                self.tblView.reloadData()
            })
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    //        searchBar.text = ""
    //        searchActive = false;
            self.searchBar.resignFirstResponder()
    //        DispatchQueue.main.async(execute: {
    //            self.tblfavContact.reloadData()
    //        })
            
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                if searchText != "" {
                    let searchPredicate = NSPredicate(format: "report_date CONTAINS[C] %@", searchBar.text!)
                    arrFiltered = (arrWeek as
                        NSArray).filtered(using: searchPredicate) as NSArray
                    if(arrFiltered.count == 0){
                        searchActive = true;
                    } else {
                        searchActive = true;
                    }
                } else {
                    searchActive = false;
                }
                
                DispatchQueue.main.async(execute: {
                    self.tblView.reloadData()
                })
        }
    private func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
           searchActive = true;
       }
    
   func showDatePicker() {
        datePicker = UIDatePicker.init()
        datePicker.backgroundColor = UIColor.white

        datePicker.autoresizingMask = .flexibleWidth
        datePicker.datePickerMode = .date

        datePicker.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
        datePicker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(datePicker)

        toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .blackTranslucent
        toolBar.backgroundColor = UIColor.systemBlue
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        cancelBarButton.tintColor = UIColor.white
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: #selector(onDoneButtonClick))
        doneBarButton.tintColor = UIColor.white
        toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)
        toolBar.sizeToFit()
        self.view.addSubview(toolBar)
    }

    @objc func dateChanged(_ sender: UIDatePicker?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        if let date = sender?.date {
            print("Picked the date \(dateFormatter.string(from: date))")
//            if  buttonType == "week"{
//                btnWeekStart.setTitle(dateFormatter.string(from: date), for: .normal)
//            }
//            else{
//                btnEndStart.setTitle(dateFormatter.string(from: date), for: .normal)
//            }
           
        }
    }

    @objc func onDoneButtonClick() {
        let formatter = DateFormatter()
             formatter.dateFormat = "yyyy-MM-dd"
        if  buttonType == "week"{
                       btnWeekStart.setTitle(formatter.string(from: datePicker.date), for: .normal)
                   }
                   else{
                       btnEndStart.setTitle(formatter.string(from: datePicker.date), for: .normal)
                   }
        WS_GetReports()
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
        self.searchBar.resignFirstResponder()
    }

    @objc func cancelDatePicker(){
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
        let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
        if  buttonType == "week"{
                              
                   btnWeekStart.setTitle(formatter.string(from: Calendar.current.date(byAdding: .day, value: -6, to: Date())!), for: .normal)
                          }
                          else{
                       btnEndStart.setTitle(formatter.string(from:Date()), for: .normal)
                          }
        WS_GetReports()
       self.view.endEditing(true)
     }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
        self.searchBar.resignFirstResponder()
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
    
    @IBAction func btnPdf(_ sender: Any) {
        //generatePDF()
        createPdfFromView(aView: viewMain, saveToDocumentsWithFileName: "invoice.pdf")
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
    
    
    
    
   func generatePDF() {
     
     do {
         let dst = getDestinationPath(1)
         if outputAsData {
             let data = try PDFGenerator.generated(by: [viewMain])
             try data.write(to: URL(fileURLWithPath: dst))
         } else {
             try PDFGenerator.generate([viewMain], to: dst)
         }
        openPDFViewer(dst)
        }
      catch let e {
         print(e)
     }
    
   }
    fileprivate func getDestinationPath(_ number: Int) -> String {
        return NSTemporaryDirectory() + "/sample\(number).pdf"
    }
       fileprivate func openPDFViewer(_ pdfPath: String) {
           print("pdfPath",pdfPath)
        //  let vc = self.storyboard?.instantiateViewController(withIdentifier: "InVoicePdfView") as! InVoicePdfView
         //   vc.pdfViewdata = pdfPath
       // self.navigationController?.pushViewController(vc, animated: true)
        let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: pdfPath))
                   dc.delegate = self
                   dc.presentPreview(animated: true)
                   
                 // let vc = self.storyboard?.instantiateViewController(withIdentifier: "InVoicePdfView") as! InVoicePdfView
                  //     vc.pdfViewdata = pdfPath
                 // self.navigationController?.pushViewController(vc, animated: true)
                   
               }
           func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
               return self//or use return self.navigationController for fetching app navigation bar colour
           }

    @IBAction func btnWeekStart(_ sender: Any) {
        buttonType = "week"
        showDatePicker()
        searchActive = false
        searchBar.text = ""
        self.searchBar.resignFirstResponder()
    }
    
    @IBAction func btnEndWeek(_ sender: Any) {
         buttonType = ""
        showDatePicker()
        searchBar.text = ""
        searchActive = false
        self.searchBar.resignFirstResponder()
        
    }
    
    
  func WS_GetReports(){
    
         if HelperClass.isInternetAvailable {
            
            let userdict = AppUserDefault.getUserDetails()
             let userId = userdict.GetInt(forKey: "id")
             SwiftLoader.show(animated: true)
             var param = [String:Any]()
            let strUrl = WebServicesLink.getReports
           // param = ["appid":"com.starwebindia.nafees","userid":userId]
            param = ["appid":"com.starwebindia.nafees","userid":userId,"from_date":btnWeekStart.currentTitle!,"to_date":btnEndStart.currentTitle!]
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
                   
                    self.arrWeek = json.GetNSMutableArray(forKey: "reports")
                     print("arrWeek",self.arrWeek)
                    DispatchQueue.main.async(execute: { () -> Void in
                               self.tblView.reloadData()
                               self.view.layoutIfNeeded()
                               self.tblHieghtConst.constant = self.tblView.contentSize.height
                                  })
                    for newdict in self.arrWeek{
                        let dict:NSMutableDictionary = newdict as! NSMutableDictionary
                        self.TotalPay += Double(dict.GetString(forKey: "site_amount")) ?? 0
                        print("waiting_time_amount",dict.GetString(forKey: "waiting_time_amount"))
                        self.Waiting_Amount += Double(dict.GetString(forKey: "waiting_time_amount")) ?? 0
                        self.lblTotalPay.text = "$" + "\(self.TotalPay)"
                        self.lblWaitingCost.text = "$" + "\(self.Waiting_Amount)"
                        print("WaitingCost",self.Waiting_Amount)
                    }
                    var sum = 0.0
                    sum += self.TotalPay + Double(self.Waiting_Amount)
                    self.lblTotalPay.text = "$" + "\(sum)"
                    print("SUUUm",sum)
                    let value = self.calculatePercentage(value: Double(sum),percentageVal: 13)
                    let pi: Double = value
                     self.lblHst.text = "$" + String(format:"%.2f", pi)
                      print(value)
                    var TotalSum = 0.0
                     TotalSum += self.TotalPay + Double(self.Waiting_Amount) + pi
                    self.lblTotalPay.text = "$" + String(format:"%.2f", TotalSum)
                    
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
    
    
    
    
}



extension WeeklyReportVC : UITableViewDelegate,UITableViewDataSource{
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
          return 1
      }
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive){
           return arrFiltered.count
        }
          return  arrWeek.count
    }
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
          return 50
      }
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "weekInvoiceCell", for: indexPath) as! weekInvoiceCell
        if(searchActive){
            let dict:NSMutableDictionary = self.arrFiltered.getNSMutableDictionary(atIndex: indexPath.row)
                   cell.lblDate.text = dict.GetString(forKey: "report_date")
                   cell.lblCity.text = dict.GetString(forKey: "city")
                   cell.lblSite.text = dict.GetString(forKey: "site")
                   cell.lblRate.text = "$" + dict.GetString(forKey: "site_amount")
                   cell.lblOrderNo.text = dict.GetString(forKey: "order_no")
               
               }else{
                  let dict:NSMutableDictionary = self.arrWeek.getNSMutableDictionary(atIndex: indexPath.row)
                         cell.lblDate.text = dict.GetString(forKey: "report_date")
                         cell.lblCity.text = dict.GetString(forKey: "city")
                         cell.lblSite.text = dict.GetString(forKey: "site")
                         cell.lblRate.text = "$" + dict.GetString(forKey: "site_amount")
                         cell.lblOrderNo.text = dict.GetString(forKey: "order_no")
               }
       
          return cell
      }
      
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let dict:NSMutableDictionary = self.arrWeek.getNSMutableDictionary(atIndex: indexPath.row)
       let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReportDetailVC") as? ReportDetailVC
        vc?.ReportId = dict.GetInt(forKey: "id")
       self.navigationController?.pushViewController(vc!, animated: true)
       
    }
    
    
    
}


class weekInvoiceCell: UITableViewCell {
    
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblSite: UILabel!
    @IBOutlet weak var lblOrderNo: UILabel!
    @IBOutlet weak var lblDate: UILabel!
}

extension UIView {
 func toImage() -> UIImage {
    UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)

    drawHierarchy(in: self.bounds, afterScreenUpdates: true)

    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
 }
}
