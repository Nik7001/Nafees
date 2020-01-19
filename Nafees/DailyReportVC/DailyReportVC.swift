//
//  DailyReportVC.swift
//  Nafees
//
//  Created by Apple on 13/01/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
class DailyReportVC: UIViewController,UITextFieldDelegate,UISearchBarDelegate{

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var viewShowCity: UIView!
    @IBOutlet weak var btnViewHide: UIButton!
    @IBOutlet weak var viewText: UIView!
    @IBOutlet weak var txtOrderNumber: UITextField!
    @IBOutlet weak var btnSubmit: GradientButton!
    @IBOutlet weak var btnpickImage: UIButton!
    @IBOutlet weak var imgHieghtConst: NSLayoutConstraint!
    @IBOutlet weak var imge: UIImageView!
    @IBOutlet weak var btnTime: UIButton!
    @IBOutlet weak var btnWaitingTImeR: UIButton!
    @IBOutlet weak var btnRate: UIButton!
    @IBOutlet weak var btnCity: UIButton!
    @IBOutlet weak var btnSite: UIButton!
    @IBOutlet weak var btnTruck: UIButton!
    @IBOutlet weak var btnCalender: UIButton!
    
    let locationManager = LocationManager()
    var latitude  = String()
    var longitude  = String()
    var location  = String()
    var zipcode  = String()
    var img = UIImage()
    var toolBar = UIToolbar()
    var datePicker  = UIDatePicker()
    var imagePicker: ImagePicker!
    let regularFont = UIFont.systemFont(ofSize: 16)
    let boldFont = UIFont.boldSystemFont(ofSize: 16)
    var strUrl = String()
    var WaitinAmount = String()
    var ButtonType = ""
    var waitingeasonArray = NSMutableArray()
    var waiting_timeArray = NSArray()
    var siteArray = NSArray()
        var arrFiltered = NSArray()
         var arrSiteFiltered = NSArray()
       var searchActive : Bool = false
    var truckArray = NSMutableArray()
    var arrTruck = [String]()
    var arrTime = [String]()
    var arrwaitingTime = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
       setCornerRadious()
        imgHieghtConst.constant = 0
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        btnCalender.setTitle(formatter.string(from: Date()), for: .normal)
         self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        WS_GetReport()
        
        tblView.delegate = self
        tblView.dataSource = self
        
        viewShowCity.isHidden = true
        btnViewHide.isHidden = true
              btnCity.setTitleColor(.lightGray, for: .normal)
               btnRate.setTitleColor(.lightGray, for: .normal)
               btnSite.setTitleColor(.lightGray, for: .normal)
            btnCity.setTitle("City", for:.normal)
            btnRate.setTitle("Rate", for:.normal)
            btnSite.setTitle("Site", for:.normal)
         searchBar.delegate = self
       self.setCurrentLocation()
        // Do any additional setup after loading the view.
    }
override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    self.navigationController?.navigationBar.isHidden = true
        }

    func setCornerRadious(){
        viewText.setCornerRadiousAndBorder(.systemTeal, borderWidth: 1.0, cornerRadius: viewText.frame.size.height/2)
        btnCity.setCornerRadiousAndBorder(.systemTeal, borderWidth: 1.0, cornerRadius: btnCity.frame.size.height/2)
        btnRate.setCornerRadiousAndBorder(.systemTeal, borderWidth: 1.0, cornerRadius: btnRate.frame.size.height/2)
        btnSite.setCornerRadiousAndBorder(.systemTeal, borderWidth: 1.0, cornerRadius: btnSite.frame.size.height/2)
        btnTime.setCornerRadiousAndBorder(.systemTeal, borderWidth: 1.0, cornerRadius: btnTime.frame.size.height/2)
        btnTruck.setCornerRadiousAndBorder(.systemTeal, borderWidth: 1.0, cornerRadius: btnTruck.frame.size.height/2)
        btnSubmit.setCornerRadiousAndBorder(.systemTeal, borderWidth: 1.0, cornerRadius: btnSubmit.frame.size.height/2)
        
        btnWaitingTImeR.setCornerRadiousAndBorder(.systemTeal, borderWidth: 1.0, cornerRadius: btnWaitingTImeR.frame.size.height/2)
        btnCalender.setCornerRadiousAndBorder(.systemTeal, borderWidth: 1.0, cornerRadius: btnCalender.frame.size.height/2)
        btnpickImage.setCornerRadiousAndBorder(.systemTeal, borderWidth: 1.0, cornerRadius: btnpickImage.frame.size.height/2)
         viewShowCity.setCornerRadiousAndBorder(.lightGray, borderWidth: 1.0, cornerRadius: 4)
        
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        viewShowCity.isHidden = true
        btnViewHide.isHidden = true
        btnCity.setTitleColor(.lightGray, for: .normal)
                     btnRate.setTitleColor(.lightGray, for: .normal)
                     btnSite.setTitleColor(.lightGray, for: .normal)
                  btnCity.setTitle("City", for:.normal)
                  btnRate.setTitle("Rate", for:.normal)
                  btnSite.setTitle("Site", for:.normal)
        self.searchBar.resignFirstResponder()
         searchActive = false
        searchBar.text = ""
    }
    
    @IBAction func btnOk(_ sender: Any) {
        viewShowCity.isHidden = true
        btnViewHide.isHidden = true
        self.searchBar.resignFirstResponder()
        btnCity.setTitleColor(.lightGray, for: .normal)
                     btnRate.setTitleColor(.lightGray, for: .normal)
                     btnSite.setTitleColor(.lightGray, for: .normal)
                  btnCity.setTitle("City", for:.normal)
                  btnRate.setTitle("Rate", for:.normal)
                  btnSite.setTitle("Site", for:.normal)
         searchActive = false
        searchBar.text = ""
    }
    
    @IBAction func btnHide(_ sender: Any) {
        viewShowCity.isHidden = true
        btnViewHide.isHidden = true
        self.searchBar.resignFirstResponder()
         searchActive = false
        searchBar.text = ""
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
    
     private func setCurrentLocation() {
            
            guard let exposedLocation = self.locationManager.exposedLocation else {
                print("*** Error in \(#function): exposedLocation is nil")
                return
            }
            
            self.locationManager.getPlace(for: exposedLocation) { placemark in
                guard let placemark = placemark else { return }
                
                var output = "Our location is:"
                if let country = placemark.country {
                    output = output + "\n\(country)"
                }
                if let state = placemark.administrativeArea {
                    output = output + "\n\(state)"
                }
                if let town = placemark.locality {
                    output = output + "\n\(town)"
                }
                if let zipcode = placemark.postalCode {
                 self.zipcode = zipcode
                }
                self.location = output
                self.latitude = "\(placemark.location!.coordinate.latitude)"
                self.longitude = "\(placemark.location!.coordinate.longitude)"
                print("location",self.location)
                print("latitude",self.latitude)
                print("longitude",self.longitude)
            }
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
            if  ButtonType == "WaitingTime"{
            if searchText != "" {
                let searchPredicate = NSPredicate(format: "time CONTAINS[C] %@", searchBar.text!)
                arrFiltered = (waiting_timeArray as
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
            else{
                if searchText != "" {
                    let searchPredicate = NSPredicate(format: "site CONTAINS[C] %@", searchBar.text!)
                    arrSiteFiltered = (siteArray as
                        NSArray).filtered(using: searchPredicate) as NSArray
                    
                    if(arrSiteFiltered.count == 0){
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
           
        }
    private func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
           searchActive = true;
       }
    
    @IBAction func btnCalendr(_ sender: Any) {
       showDatePicker()
         hideKeyBoard()
    }
    
    @IBAction func btnTruckNumber(_ sender: Any) {
         hideKeyBoard()
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
       truckNumberSelect()
    }
    
    @IBAction func btnSite(_ sender: Any) {
         hideKeyBoard()
        
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
        viewShowCity.isHidden = false
        btnViewHide.isHidden = false
        ButtonType = ""
        tblView.reloadData()
       
    }
    
    @IBAction func btnCity(_ sender: Any) {
       
    }
    
    @IBAction func btnRate(_ sender: Any) {
       
      
    }
    
    @IBAction func btnTimeReason(_ sender: Any) {
         hideKeyBoard()
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
        WaitingTimeReasion()
    }
    
    @IBAction func btnTime(_ sender: Any) {
         hideKeyBoard()
       
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
        ButtonType = "WaitingTime"
        viewShowCity.isHidden = false
        btnViewHide.isHidden = false
          tblView.reloadData()
    }
    
    @IBAction func btnPickImage(_ sender: Any) {
         hideKeyBoard()
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
        self.imagePicker.present(from: sender as! UIView)
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
         hideKeyBoard()
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
        
       if btnSite.currentTitle == "Site"{
        showAlert(title: "Alert", message: "Select Site")
            
        }
        else if btnRate.currentTitle == "Rate"{
         showAlert(title: "Alert", message: "Select Rate")
            
        }
        else if btnCity.currentTitle == "City"{
          showAlert(title: "Alert", message: "Select City")
                   
            }
        else if btnTruck.currentTitle == "Truck No."{
         showAlert(title: "Alert", message: "Select Truck No.")
        }
        else if txtOrderNumber.text == ""{
              showAlert(title: "Alert", message: "Select OrderNo.")
       }
       else{
         WS_SaveDailyReport()
        }
    }
    
    //MARK:- Functions >>>>>>>>>>>>>
    func hideKeyBoard(){
        txtOrderNumber.resignFirstResponder()
        self.searchBar.resignFirstResponder()
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
        }
    }

    @objc func onDoneButtonClick() {
        let formatter = DateFormatter()
             formatter.dateFormat = "yyyy-MM-dd"
              btnCalender.setTitle(formatter.string(from: datePicker.date), for: .normal)
        btnCalender.setTitleColor(.black, for: .normal)
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
    }

    @objc func cancelDatePicker(){
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
        let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
         btnCalender.setTitle(formatter.string(from:Date()), for: .normal)
       self.view.endEditing(true)
     }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
    }
    
    func truckNumberSelect(){
    let blueAppearance = YBTextPickerAppearanceManager.init(
         pickerTitle         : "Truck No.",
         titleFont           : boldFont,
         titleTextColor      : .black,
         titleBackground     : .clear,
         searchBarFont       : regularFont,
         searchBarPlaceholder: "Search",
         closeButtonTitle    : "Cancel",
         closeButtonColor    : .darkGray,
         closeButtonFont     : regularFont,
         doneButtonTitle     : "Done",
         doneButtonColor     : UIColor.systemBlue,
         doneButtonFont      : boldFont,
         itemColor           : .black,
         itemFont            : regularFont
     )
    
        let picker = YBTextPicker.init(with: arrTruck , appearance: blueAppearance,
                                    onCompletion: { (selectedIndexes, selectedValues) in
                                     if selectedValues.count > 0{
                                         
                                         var values = [String]()
                                         for index in selectedIndexes{
                                            values.append(self.arrTruck[index])
                                         }
                                self.btnTruck.setTitle(values.joined(separator: ", "), for: .normal)
                                    self.btnTruck.setTitleColor(.black, for: .normal)
                                         
                                     }else{
                                         self.btnTruck.setTitle("Truck No.", for: .normal)
                                        self.btnTruck.setTitleColor(.lightGray, for: .normal)
                                     }
     },
                                    onCancel: {
                                     print("Cancelled")
                                        self.btnTruck.setTitle("Truck No.", for: .normal)
                                   self.btnTruck.setTitleColor(.lightGray, for: .normal)
     }
     )
     
     if let title = btnTruck.title(for: .normal){
         if title.contains(","){
             picker.preSelectedValues = title.components(separatedBy: ", ")
         }
     }
     picker.allowMultipleSelection = false
     
     picker.show(withAnimation: .Fade)
    }
    
    func WaitingTimeReasion(){
       let blueAppearance = YBTextPickerAppearanceManager.init(
            pickerTitle         : "Waiting Time Reason",
            titleFont           : boldFont,
            titleTextColor      : .black,
            titleBackground     : .clear,
            searchBarFont       : regularFont,
            searchBarPlaceholder: "Search",
            closeButtonTitle    : "Cancel",
            closeButtonColor    : .darkGray,
            closeButtonFont     : regularFont,
            doneButtonTitle     : "Done",
            doneButtonColor     : UIColor.systemBlue,
            doneButtonFont      : boldFont,
            itemColor           : .black,
            itemFont            : regularFont
        )
        
        let picker = YBTextPicker.init(with: arrwaitingTime, appearance: blueAppearance,
                                       onCompletion: { (selectedIndexes, selectedValues) in
                                        if selectedValues.count > 0{
                                            
                                            var values = [String]()
                                            for index in selectedIndexes{
                                                values.append(self.arrwaitingTime[index])
                                            }
                                   self.btnWaitingTImeR.setTitle(values.joined(separator: ", "), for: .normal)
                                       self.btnWaitingTImeR.setTitleColor(.black, for: .normal)
                                            
                                        }else{
                                            self.btnWaitingTImeR.setTitle("Waiting Time Reason", for: .normal)
                                           self.btnWaitingTImeR.setTitleColor(.lightGray, for: .normal)
                                        }
        },
                                       onCancel: {
                                        print("Cancelled")
                                           self.btnWaitingTImeR.setTitle("Waiting Time Reason", for: .normal)
                                       self.btnWaitingTImeR.setTitleColor(.lightGray, for: .normal)
        }
        )
        
        if let title = btnTruck.title(for: .normal){
            if title.contains(","){
                picker.preSelectedValues = title.components(separatedBy: ", ")
            }
        }
        picker.allowMultipleSelection = false
        
        picker.show(withAnimation: .Fade)
       }
    
    func WS_GetReport(){
    
         if HelperClass.isInternetAvailable {
             SwiftLoader.show(animated: true)
             var param = [String:Any]()
             strUrl = WebServicesLink.getReportEntryData
            
             print("strUrl >>>>>>>>>>\(strUrl)")
             param = ["appid":"com.starwebindia.nafees"]
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
                   
                    self.siteArray = json.GetNSMutableArray(forKey: "site")
                    self.truckArray = json.GetNSMutableArray(forKey: "truck")
                    self.waitingeasonArray = json.GetNSMutableArray(forKey: "waiting_reason")
                     self.waiting_timeArray = json.GetNSMutableArray(forKey: "waiting_time")
                   
                if self.truckArray.count>0{
                        for dict in self.truckArray {
                        let newdict:NSMutableDictionary = dict as! NSMutableDictionary
                        self.arrTruck.append(newdict.GetString(forKey: "truck_no"))
                        print("arrTruck",self.arrTruck)
                        }
                                               
                    }
                if self.waitingeasonArray.count>0{
                    for dict in self.waitingeasonArray {
                        let newdict:NSMutableDictionary = dict as! NSMutableDictionary
                            self.arrwaitingTime.append(newdict.GetString(forKey: "w_reason"))
                            print("arrwaitingTime",self.arrwaitingTime)
                    }
                                                                      
                }
            if self.waiting_timeArray.count>0{
                for dict in self.waiting_timeArray {
                let newdict:NSMutableDictionary = dict as! NSMutableDictionary
                self.arrTime.append(newdict.GetString(forKey: "time") + " " + "Minutes")
                print("arrTime",self.arrTime)
                }
            }
            else{
            PopUpView.addPopUpAlertView(MessageStringFile.whoopsText(), leftBtnTitle: MessageStringFile.okText(), rightBtnTitle: "", firstLblTitle: "Wrong Details", secondLblTitle: "")
            PopUpView.sharedInstance.delegate = nil
        }
                    print("waiting_time",self.waiting_timeArray)
                    print("waitingreasontime",self.waitingeasonArray)
                    print("truckArray",self.truckArray)
                     print("siteArray",self.siteArray)
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
    
    func WS_SaveDailyReport(){
        if HelperClass.isInternetAvailable {
            SwiftLoader.show(animated: true)
            let imageData  = img.jpegData(compressionQuality: 0.5)
          
         let userdict = AppUserDefault.getUserDetails()
                     let driverId = userdict.GetString(forKey: "driver_id")
                      let userId = userdict.GetInt(forKey: "id")
                    
                      var param = [String:Any]()
                          
            let strUrl = WebServicesLink.saveDailyReport
            
              param = ["appid":"com.starwebindia.nafees","userid":userId,"driver_id":driverId,"report_date":btnCalender.currentTitle!,"truck_no":btnTruck.currentTitle!,"order_no":txtOrderNumber.text ?? "","city":btnCity.currentTitle!,"site":btnSite.currentTitle!,"site_amount":btnRate.currentTitle!,"waiting_reason":btnWaitingTImeR.currentTitle!,"waiting_time":btnTime.currentTitle!,"waiting_time_amount":WaitinAmount,"latitude":latitude,"longitude":longitude,"location":location,"pincode":zipcode]
                          
                print("param >>>>>>>>>>\(param)")
                           // print("param >>>>>>>>>>\(strUrl)")
           // param = [WebServiceConstant.email:txtemail.text!,WebServiceConstant.first_name:txtname.text!,WebServiceConstant.last_name:txtlname.text!,WebServiceConstant.birthmonth:txtbirthmonth.text! ,"token":"Arnasoftech","Content-Type":"file"]
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in param {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                if let data = imageData{
                    multipartFormData.append(data, withName: "filename", fileName: "image.jpg", mimeType: "image/png")
                }
            }, usingThreshold: UInt64.init(), to: strUrl, method: .post, headers:[:]) { (result) in
                switch result{
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let status = response.response?.statusCode {
                            switch(status){
                            case 200:
                                let alert = UIAlertController(title: "Success", message: "SavedReports", preferredStyle: .alert)
                                self.present(alert, animated: true, completion: nil)
                                let when = DispatchTime.now() + 5
                                DispatchQueue.main.asyncAfter(deadline: when){
                                    // your code with delay
                                    alert.dismiss(animated: true, completion: nil)
                                     SwiftLoader.hide()
                                }
                                if let result = response.result.value {
                                    SwiftLoader.hide()
                                    print("result",result)
                                    let dict : NSDictionary = result as! NSDictionary
                                    let Status:Int = dict.GetInt(forKey: "result")
                                        print("status",Status)
                                    if "\(Status)" == "1"{
                                   self.btnWaitingTImeR.setTitle("Waiting Time Reason", for: .normal)
                                                          self.btnWaitingTImeR.setTitleColor(.lightGray, for: .normal)
                                                          self.btnCity.setTitle("City", for: .normal)
                                                          self.btnCity.setTitleColor(.lightGray, for: .normal)
                                                          self.btnRate.setTitle("Rate", for: .normal)
                                                          self.btnRate.setTitleColor(.lightGray, for: .normal)
                                                          self.btnSite.setTitle("Site", for: .normal)
                                                          self.btnSite.setTitleColor(.lightGray, for: .normal)
                                                          self.btnTime.setTitle("Site", for: .normal)
                                                          self.btnTime.setTitleColor(.lightGray, for: .normal)
                                                          self.txtOrderNumber.text = ""
                                                          self.txtOrderNumber.placeholder = "Order No."
                                  
                                    }
                                    else{
                                        let alert = UIAlertController(title: "Failed", message: "Missing Some Information", preferredStyle: .alert)
                                                self.present(alert, animated: true, completion: nil)
                                                    let when = DispatchTime.now() + 5
                                                DispatchQueue.main.asyncAfter(deadline: when){
                                                                          // your code with delay
                                        alert.dismiss(animated: true, completion: nil)
                                        }
                                        
                                    }
                                }
                            default:
                                print("error with response status: \(status)")
                            }
                        }
                    }
                case .failure(let error):
                    print("Error in upload: \(error.localizedDescription)")
                   
                }
            }
         
        }
        else {
            PopUpView.addPopUpAlertView(MessageStringFile.whoopsText(), leftBtnTitle:MessageStringFile.okText() , rightBtnTitle:"" , firstLblTitle: MessageStringFile.networkReachability(), secondLblTitle: "")
            PopUpView.sharedInstance.delegate = nil
        }
    }
    
    
    
 /* func WS_SaveDailyReport(){
    
         if HelperClass.isInternetAvailable {
            
            let userdict = AppUserDefault.getUserDetails()
            let driverId = userdict.GetString(forKey: "driver_id")
             let userId = userdict.GetInt(forKey: "id")
             
             SwiftLoader.show(animated: true)
             var param = [String:Any]()
             strUrl = WebServicesLink.saveDailyReport
            
            param = ["appid":"com.starwebindia.nafees","userid":userId,"driver_id":driverId,"report_date":btnCalender.currentTitle!,"truck_no":btnTruck.currentTitle!,"order_no":txtOrderNumber.text ?? "","city":btnCity.currentTitle!,"site":btnSite.currentTitle!,"site_amount":btnRate.currentTitle!,"waiting_reason":btnWaitingTImeR.currentTitle!,"waiting_time":btnTime.currentTitle!,"waiting_time_amount":WaitinAmount,"latitude":latitude,"longitude":longitude,"location":location,"pincode":zipcode,"filename":img.jpegData(compressionQuality:0)!]
           
             print("strUrl >>>>>>>>>>\(strUrl)")
            print("Param >>>>>>>>>>",param)
             
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
                     let Status:Int = json.GetInt(forKey: "result")
                    if "\(Status)" == "-1"{
                                PopUpView.addPopUpAlertView(MessageStringFile.whoopsText(), leftBtnTitle: MessageStringFile.okText(), rightBtnTitle: "", firstLblTitle: "Wrong Information", secondLblTitle: "")
                                               PopUpView.sharedInstance.delegate = nil
                                           }else{
                   PopUpView.addPopUpAlertView("Success", leftBtnTitle: MessageStringFile.okText(), rightBtnTitle: "", firstLblTitle: "SavedReports", secondLblTitle: "")
                   PopUpView.sharedInstance.delegate = nil
                        self.btnWaitingTImeR.setTitle("Waiting Time Reason", for: .normal)
                        self.btnWaitingTImeR.setTitleColor(.lightGray, for: .normal)
                        self.btnCity.setTitle("City", for: .normal)
                        self.btnCity.setTitleColor(.lightGray, for: .normal)
                        self.btnRate.setTitle("Rate", for: .normal)
                        self.btnRate.setTitleColor(.lightGray, for: .normal)
                        self.btnSite.setTitle("Site", for: .normal)
                        self.btnSite.setTitleColor(.lightGray, for: .normal)
                        self.btnTime.setTitle("Site", for: .normal)
                        self.btnTime.setTitleColor(.lightGray, for: .normal)
                        self.txtOrderNumber.text = ""
                        self.txtOrderNumber.placeholder = "Order No."
                    }
                    
                 }
           else{
                 PopUpView.addPopUpAlertView(MessageStringFile.whoopsText(), leftBtnTitle: MessageStringFile.okText(), rightBtnTitle: "", firstLblTitle: "Wrong Details", secondLblTitle: "")
                     PopUpView.sharedInstance.delegate = nil
                 }
             })
         } else {
             PopUpView.addPopUpAlertView(MessageStringFile.whoopsText(), leftBtnTitle:MessageStringFile.okText() , rightBtnTitle:"" , firstLblTitle: MessageStringFile.networkReachability(), secondLblTitle: "")
             PopUpView.sharedInstance.delegate = nil
         }
     }*/
    
    
}
extension DailyReportVC: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        img = image!
        self.imge.image = image
        btnpickImage.setTitle("Change Image", for: .normal)
        imgHieghtConst.constant = 200
    }
}
class siteCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    
}
extension DailyReportVC : UITableViewDelegate,UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  ButtonType == "WaitingTime"{
            if (searchActive){
                      return  arrFiltered.count
                   }
                   return waiting_timeArray.count
        }else{
            if (searchActive){
               return  arrSiteFiltered.count
            }
            return siteArray.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 58
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "siteCell", for: indexPath) as! siteCell
        if  ButtonType == "WaitingTime"{
        let dict:NSMutableDictionary = self.waiting_timeArray.getNSMutableDictionary(atIndex: indexPath.row)
        if(searchActive){
             let dict:NSMutableDictionary = self.arrFiltered.getNSMutableDictionary(atIndex: indexPath.row)
             cell.lblName.text = dict.GetString(forKey: "time")
            WaitinAmount = dict.GetString(forKey: "cost")
        }else{
            cell.lblName.text = dict.GetString(forKey: "time")
            
        }
        }else{
            let dict:NSMutableDictionary = self.siteArray.getNSMutableDictionary(atIndex: indexPath.row)
                   if(searchActive){
                        let dict:NSMutableDictionary = self.arrSiteFiltered.getNSMutableDictionary(atIndex: indexPath.row)
                        cell.lblName.text = dict.GetString(forKey: "site")
                   }else{
                       cell.lblName.text = dict.GetString(forKey: "site")
                   }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
         if  ButtonType == "WaitingTime"{
        if(searchActive){
             let dict:NSMutableDictionary = self.arrFiltered.getNSMutableDictionary(atIndex: indexPath.row)
                    btnTime.setTitle(dict.GetString(forKey: "time") + " " + "Minutes", for: .normal)
                                           btnTime.setTitleColor(.black, for: .normal)
             WaitinAmount = dict.GetString(forKey: "cost")
                           
        }else{
             let dict:NSMutableDictionary = self.waiting_timeArray.getNSMutableDictionary(atIndex: indexPath.row)
                btnTime.setTitle(dict.GetString(forKey: "time") + " " + "Minutes", for: .normal)
                btnTime.setTitleColor(.black, for: .normal)
             WaitinAmount = dict.GetString(forKey: "cost")
            }
            
         }else{
            if(searchActive){
                        let dict:NSMutableDictionary = self.arrSiteFiltered.getNSMutableDictionary(atIndex: indexPath.row)
                             btnSite.setTitle(dict.GetString(forKey: "site"), for: .normal)
                             btnRate.setTitle(dict.GetString(forKey: "amount"), for: .normal)
                             btnCity.setTitle(dict.GetString(forKey: "city"), for: .normal)
                             btnCity.setTitleColor(.black, for: .normal)
                             btnRate.setTitleColor(.black, for: .normal)
                             btnSite.setTitleColor(.black, for: .normal)
                   }else{
                 let dict:NSMutableDictionary = self.siteArray.getNSMutableDictionary(atIndex: indexPath.row)
                                                        btnSite.setTitle(dict.GetString(forKey: "site"), for: .normal)
                                                        btnRate.setTitle(dict.GetString(forKey: "amount"), for: .normal)
                                                        btnCity.setTitle(dict.GetString(forKey: "city"), for: .normal)
                                                        btnCity.setTitleColor(.black, for: .normal)
                                                        btnRate.setTitleColor(.black, for: .normal)
                                                        btnSite.setTitleColor(.black, for: .normal)
                          
                       }
        }
        tableView.reloadData()
        viewShowCity.isHidden = true
        btnViewHide.isHidden = true
         searchActive = false
        searchBar.text = ""
       
    }
}
extension UIViewController {
  func showAlert(title: String, message: String) {
    let alertController = UIAlertController(title: title, message:
      message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
    }))
    self.present(alertController, animated: true, completion: nil)
  }
}
