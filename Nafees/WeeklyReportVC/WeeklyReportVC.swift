//
//  WeeklyReportVC.swift
//  Nafees
//
//  Created by Apple on 13/01/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class WeeklyReportVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
      self.setNavigationBarItem()
        self.title = "WEEKLY REPORT"
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
