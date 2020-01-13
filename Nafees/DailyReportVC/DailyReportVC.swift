//
//  DailyReportVC.swift
//  Nafees
//
//  Created by Apple on 13/01/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class DailyReportVC: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setCornerRadious()
        imgHieghtConst.constant = 0
        // Do any additional setup after loading the view.
    }
override func viewWillAppear(_ animated: Bool) {
                 super.viewWillAppear(animated)
            self.setNavigationBarItem()
              self.title = "DAILY REPORT"
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
        
    }
    
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCalendr(_ sender: Any) {
         hideKeyBoard()
    }
    
    @IBAction func btnTruckNumber(_ sender: Any) {
         hideKeyBoard()
    }
    
    @IBAction func btnSite(_ sender: Any) {
         hideKeyBoard()
    }
    
    @IBAction func btnCity(_ sender: Any) {
         hideKeyBoard()
    }
    
    @IBAction func btnRate(_ sender: Any) {
         hideKeyBoard()
    }
    
    @IBAction func btnTimeReason(_ sender: Any) {
         hideKeyBoard()
    }
    
    @IBAction func btnTime(_ sender: Any) {
         hideKeyBoard()
    }
    
    @IBAction func btnPickImage(_ sender: Any) {
         hideKeyBoard()
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
         hideKeyBoard()
    }
    
    //MARK:- Functions >>>>>>>>>>>>>
    func hideKeyBoard(){
        txtOrderNumber.resignFirstResponder()
       
    }
    
}
