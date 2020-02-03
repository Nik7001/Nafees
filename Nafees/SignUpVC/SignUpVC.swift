//
//  SignUpVC.swift
//  Nafees
//
//  Created by Apple on 27/01/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    @IBOutlet weak var btnSignup: UIButton!
    
    @IBOutlet weak var txtDriverName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtMobileNo: UITextField!
    
    @IBOutlet weak var txtAddress: UITextField!
    
    @IBOutlet weak var txtCompanyName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var txtDispatcherEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSignup.setCornerRadiousAndBorder(.clear, borderWidth: 0, cornerRadius: btnSignup.frame.size.height/2)

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           self.navigationController?.navigationBar.isHidden = true
        
       }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSignup(_ sender: Any) {
        var arrvalid = NSMutableArray()
        arrvalid = CheckValidation()
        if arrvalid.count == 0{
            WS_SignUP()
        } else {
            PopUpView.addValidationView(arrvalid, strHeader: MessageStringFile.whoopsText(), strSubHeading: MessageStringFile.vInfoNeeded())
            PopUpView.sharedInstance.delegate = nil
        }
        
    }
    
    func hideKeyBoard(){
          txtMobileNo.resignFirstResponder()
          txtPassword.resignFirstResponder()
        txtDriverName.resignFirstResponder()
        txtEmail.resignFirstResponder()
        txtCompanyName.resignFirstResponder()
        txtDispatcherEmail.resignFirstResponder()
        txtAddress.resignFirstResponder()
      }
      //MARK:- Validation >>>>>>>>>>>>>
      func CheckValidation() -> NSMutableArray {
          let arrValidation = NSMutableArray()
          
          if !ValidationsFile.isValidEmail(strEmail: txtEmail.text!) {
              if txtEmail.text!.count > 0{
                  arrValidation.add (MessageStringFile.vValidEmail())
              }
          }
          if txtEmail.text?.count == 0 {
          arrValidation.add(MessageStringFile.vEmail())
          }
          if txtDispatcherEmail.text?.count == 0 {
                 arrValidation.add(MessageStringFile.vEmail())
                 }
          if txtPassword.text?.count == 0 {
          arrValidation.add(MessageStringFile.vPassword())
          }
        if txtDriverName.text?.count == 0 {
                arrValidation.add(MessageStringFile.vValidFullName())
            }
        if txtMobileNo.text?.count == 0 {
            arrValidation.add(MessageStringFile.vEmailPhoneNumber())
            }
        if txtAddress.text?.count == 0 {
            arrValidation.add(MessageStringFile.vAddress())
            }
          return arrValidation
      }
    
    func WS_SignUP(){
    
         if HelperClass.isInternetAvailable {
             SwiftLoader.show(animated: true)
             var param = [String:Any]()
            let strUrl = WebServicesLink.SignUp
            param = ["appid":"com.starwebindia.nafees","name":txtDriverName.text ?? "","driver_id":txtEmail.text ?? "","password":txtPassword.text ?? "" ,"company":txtCompanyName.text ?? "","address":txtAddress.text ?? "","mobile_no":txtMobileNo.text ?? "","dispatcher_email":txtDispatcherEmail.text ?? ""]
             
             print("param >>>>>>>>>>\(param)")
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
                     SwiftLoader.hide()
                     let Status:String = json.GetString(forKey: "result")
                     print("status",Status)
                     if "\(Status)" == "emessage"{
                         PopUpView.addPopUpAlertView(MessageStringFile.whoopsText(), leftBtnTitle: MessageStringFile.okText(), rightBtnTitle: "", firstLblTitle: Status, secondLblTitle: "")
                         PopUpView.sharedInstance.delegate = nil
                     }else{
                         let dict:NSMutableDictionary = NSMutableDictionary(dictionary:json)
                         print("dict >>>>>>>>>>\(dict)")
                         let storyboard = UIStoryboard(name: "Main", bundle: nil)
                         let mainViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                     self.navigationController?.pushViewController(mainViewController, animated: true)
                    self.showAlert(title: "Alert", message: "Driver Added Successfully")
                 }
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
