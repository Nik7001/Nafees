//
//  InVoicePdfView.swift
//  Nafees
//
//  Created by Apple on 15/01/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import WebKit
import PDFKit
class InVoicePdfView: UIViewController {
    var pdfViewdata = String()
    var pdfURl = String()
    
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if pdfViewdata == ""{
         let url: URL! = URL(string: pdfURl)
         print("urrrr",url ?? "")
         webView.load(URLRequest(url: url))
        }else{
            if let pdf = Bundle.main.url(forResource: pdfViewdata, withExtension: "pdf", subdirectory: nil, localization: nil)  {
            let req = NSURLRequest(url: pdf)
            webView.load(req as URLRequest)
            }
            
        }
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
