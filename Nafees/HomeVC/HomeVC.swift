//
//  HomeVC.swift
//  Nafees
//
//  Created by Apple on 12/01/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class HomeVC: UIViewController,SlideMenuControllerDelegate {

    @IBOutlet weak var btnInvoice: GradientButton!
    @IBOutlet weak var BtnDaily: GradientButton!
    @IBOutlet weak var btnWeek: GradientButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnWeek.setCornerRadiousAndBorder(.lightGray, borderWidth: 0.2, cornerRadius: 4)
          btnInvoice.setCornerRadiousAndBorder(.lightGray, borderWidth: 0.2, cornerRadius: 4)
          BtnDaily.setCornerRadiousAndBorder(.lightGray, borderWidth: 0.2, cornerRadius: 4)
    
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
                  super.viewWillAppear(animated)
             self.setNavigationBarItem()
               self.title = "HOME"
           }
    
    @IBAction func btnWeekly(_ sender: Any) {
    }
    
    @IBAction func btnInvoice(_ sender: Any) {
    }
    
    @IBAction func btnDailyReport(_ sender: Any) {
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
