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
class WeeklyReportVC: UIViewController {
     fileprivate var outputAsData: Bool = false
    @IBOutlet var viewMain: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    self.navigationController?.navigationBar.isHidden = true
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
    
    
    @IBAction func btnPrinter(_ sender: Any) {
      
    }
    
    @IBAction func btnPdf(_ sender: Any) {
        generatePDF()
    }
    
   func generatePDF() {
     
      do {
        
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

        let fileURL:URL = documentsURL.appendingPathComponent("note.pdf")

        do {
            try FileManager.default.createDirectory(atPath: fileURL.path, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            NSLog("Unable to create directory \(error.debugDescription)")
        }

        UIGraphicsBeginPDFContextToFile(fileURL.appendingPathComponent("note.pdf").path, CGRect.zero, nil);
            if outputAsData {
            let data = try PDFGenerator.generated(by: [viewMain])
            try data.write(to: URL(fileURLWithPath: fileURL))
                 } else {
                     try PDFGenerator.generate([viewMain], to: fileURL)
                 }
                 openPDFViewer(fileURL)
             } catch let e {
                 print(e)
             }
    
   }
       fileprivate func openPDFViewer(_ pdfPath: String) {
           print("pdfPath",pdfPath)
          let vc = self.storyboard?.instantiateViewController(withIdentifier: "InVoicePdfView") as! InVoicePdfView
               vc.pdfViewdata = pdfPath
           self.navigationController?.pushViewController(vc, animated: true)
           
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

