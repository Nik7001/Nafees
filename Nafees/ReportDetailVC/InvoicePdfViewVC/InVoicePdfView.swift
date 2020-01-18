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
             let url = URL(fileURLWithPath: pdfViewdata)
                    let req = NSMutableURLRequest(url: url)
                          req.timeoutInterval = 60.0
                          req.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
                          webView.load(req as URLRequest)
                   DispatchQueue.main.async {
                              let pdfData = try? Data.init(contentsOf: url)
                              let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
                              let pdfNameFromUrl = "invoice.pdf"
                              let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
                              do {
                                  try pdfData?.write(to: actualPath, options: .atomic)
                                  print("pdf successfully saved!")
                              } catch {
                                  print("Pdf could not be saved")
                              }
                          }
            }
            
        }
    
 override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    self.navigationController?.navigationBar.isHidden = true
    
    }
    @IBAction func btnBack(_ sender: Any) {
        
        if pdfViewdata == ""{
            self.navigationController?.popViewController(animated: true)
        }else{
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
