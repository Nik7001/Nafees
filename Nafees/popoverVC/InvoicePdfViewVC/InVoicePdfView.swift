//
//  InVoicePdfView.swift
//  Nafees
//
//  Created by Apple on 15/01/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import WebKit
class InVoicePdfView: UIViewController {
 var pdfViewdata = String()
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url: URL! = URL(string: pdfViewdata)
        webView.load(URLRequest(url: url))
        // Do any additional setup after loading the view.
    }
 override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    self.navigationController?.navigationBar.isHidden = false
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
