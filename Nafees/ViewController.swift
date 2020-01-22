//
//  ViewController.swift
//  Nafees
//
//  Created by Apple on 12/01/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var viewUser: UIView!
    @IBOutlet weak var txtUserName: UITextField!
    
   
    @IBOutlet weak var viewBack: Gradientview!
    
    @IBOutlet weak var btnLogin: GradientButton!
    @IBOutlet weak var viewPassword: UIView!
     var strUrl = String()
    
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewUser.setCornerRadiousAndBorder(.systemBlue, borderWidth: 0.5, cornerRadius: viewUser.frame.size.height/2)
        viewPassword.setCornerRadiousAndBorder(.systemBlue, borderWidth: 0.5, cornerRadius: viewPassword.frame.size.height/2)
        
        btnLogin.setCornerRadiousAndBorder(.clear, borderWidth: 0.5, cornerRadius: btnLogin.frame.size.height/2)
      //  txtUserName.text = "test@gmail.com"
      //  txtPassword.text = "test"
        
        //txtUserName.text = "fmklcc@hotmail.com"
        // txtPassword.text = "Nafees@421"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSignIn(_ sender: Any) {
        var arrvalid = NSMutableArray()
                     arrvalid = CheckValidation()
                     if arrvalid.count == 0{
                         WS_Login()
                     } else {
                         PopUpView.addValidationView(arrvalid, strHeader: MessageStringFile.whoopsText(), strSubHeading: MessageStringFile.vInfoNeeded())
                         PopUpView.sharedInstance.delegate = nil
                     }
    }
    
    //MARK:- Functions >>>>>>>>>>>>>
    func hideKeyBoard(){
        txtUserName.resignFirstResponder()
        txtPassword.resignFirstResponder()
    }
    //MARK:- Validation >>>>>>>>>>>>>
    func CheckValidation() -> NSMutableArray {
        let arrValidation = NSMutableArray()
        
        if !ValidationsFile.isValidEmail(strEmail: txtUserName.text!) {
            if txtUserName.text!.count > 0{
                arrValidation.add (MessageStringFile.vValidEmail())
            }
        }
        if txtUserName.text?.count == 0 {
        arrValidation.add(MessageStringFile.vEmail())
        }
        if txtPassword.text?.count == 0 {
        arrValidation.add(MessageStringFile.vPassword())
        }
        return arrValidation
    }
    
    func WS_Login(){
       
            if HelperClass.isInternetAvailable {
                SwiftLoader.show(animated: true)
                var param = [String:Any]()
                strUrl = WebServicesLink.login
                
                param = ["userid":txtUserName.text!,"password":txtPassword.text!,"appid":"com.starwebindia.nafees"]
                
                
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
                        let Status:Int = json.GetInt(forKey: "result")
                        print("status",Status)
                        if "\(Status)" == "-1"{
                            PopUpView.addPopUpAlertView(MessageStringFile.whoopsText(), leftBtnTitle: MessageStringFile.okText(), rightBtnTitle: "", firstLblTitle: "Wrong UserName or Password", secondLblTitle: "")
                            PopUpView.sharedInstance.delegate = nil
                        }else{
                            let dict:NSMutableDictionary = NSMutableDictionary(dictionary:json)
                            print("dict >>>>>>>>>>\(dict)")
                            AppUserDefault.setUserDetails(dict: dict )
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
@IBDesignable
class GradientButton: UIButton {
    let gradientLayer = CAGradientLayer()
    
    @IBInspectable
    var topGradientColor: UIColor? {
        didSet {
            setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
        }
    }
    
    @IBInspectable
    var bottomGradientColor: UIColor? {
        didSet {
            setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
        }
    }
    
    private func setGradient(topGradientColor: UIColor?, bottomGradientColor: UIColor?) {
        if let topGradientColor = topGradientColor, let bottomGradientColor = bottomGradientColor {
            gradientLayer.frame = bounds
            gradientLayer.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
            gradientLayer.borderColor = layer.borderColor
            gradientLayer.borderWidth = layer.borderWidth
            gradientLayer.cornerRadius = layer.cornerRadius
            layer.insertSublayer(gradientLayer, at: 0)
        } else {
            gradientLayer.removeFromSuperlayer()
        }
       
    }
}
@IBDesignable
class Gradientview: UIView {
    let gradientLayer = CAGradientLayer()
    
    @IBInspectable
    var topGradientColor: UIColor? {
        didSet {
            setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
        }
    }
    
    @IBInspectable
    var bottomGradientColor: UIColor? {
        didSet {
            setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
        }
    }
    
    private func setGradient(topGradientColor: UIColor?, bottomGradientColor: UIColor?) {
        
        
        if let topGradientColor = topGradientColor, let bottomGradientColor = bottomGradientColor {
            gradientLayer.frame = bounds
            gradientLayer.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
            gradientLayer.borderColor = layer.borderColor
            gradientLayer.borderWidth = layer.borderWidth
            gradientLayer.cornerRadius = layer.cornerRadius
            layer.insertSublayer(gradientLayer, at: 0)
        } else {
            gradientLayer.removeFromSuperlayer()
        }
    }
}

