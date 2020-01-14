//
//  DailyReportVC.swift
//  Nafees
//
//  Created by Apple on 13/01/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class DailyReportVC: UIViewController,UITextFieldDelegate,UIPopoverPresentationControllerDelegate {

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
    var toolBar = UIToolbar()
    var datePicker  = UIDatePicker()
    var imagePicker: ImagePicker!
    let regularFont = UIFont.systemFont(ofSize: 16)
    let boldFont = UIFont.boldSystemFont(ofSize: 16)
    override func viewDidLoad() {
        super.viewDidLoad()
       setCornerRadious()
        imgHieghtConst.constant = 0
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        btnCalender.setTitle(formatter.string(from: Date()), for: .normal)
         self.imagePicker = ImagePicker(presentationController: self, delegate: self)
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
        site()
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
        WaitingTime()
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
    }
    
    //MARK:- Functions >>>>>>>>>>>>>
    func hideKeyBoard(){
        txtOrderNumber.resignFirstResponder()
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
             formatter.dateFormat = "dd-MM-yyyy"
              btnCalender.setTitle(formatter.string(from: datePicker.date), for: .normal)
        btnCalender.setTitleColor(.black, for: .normal)
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
    }

    @objc func cancelDatePicker(){
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
        let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
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
     let fruits = ["Cherry", "Apricots", "Banana", "Blueberry", "Orange", "Apple", "Grapes", "Guava", "Mango", "Cherries", "Damson", "Grapefruit", "Pluot", "Plums", "Kiwi", "Peach", "Pear", "Pomegranate", "Starfruit", "Watermelon", "Pineapples"]
     let picker = YBTextPicker.init(with: fruits, appearance: blueAppearance,
                                    onCompletion: { (selectedIndexes, selectedValues) in
                                     if selectedValues.count > 0{
                                         
                                         var values = [String]()
                                         for index in selectedIndexes{
                                             values.append(fruits[index])
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
        let fruits = ["Cherry", "Apricots", "Banana", "Blueberry", "Orange", "Apple", "Grapes", "Guava", "Mango", "Cherries", "Damson", "Grapefruit", "Pluot", "Plums", "Kiwi", "Peach", "Pear", "Pomegranate", "Starfruit", "Watermelon", "Pineapples"]
        let picker = YBTextPicker.init(with: fruits, appearance: blueAppearance,
                                       onCompletion: { (selectedIndexes, selectedValues) in
                                        if selectedValues.count > 0{
                                            
                                            var values = [String]()
                                            for index in selectedIndexes{
                                                values.append(fruits[index])
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
    
    func WaitingTime(){
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
        let fruits = ["Cherry", "Apricots", "Banana", "Blueberry", "Orange", "Apple", "Grapes", "Guava", "Mango", "Cherries", "Damson", "Grapefruit", "Pluot", "Plums", "Kiwi", "Peach", "Pear", "Pomegranate", "Starfruit", "Watermelon", "Pineapples"]
        let picker = YBTextPicker.init(with: fruits, appearance: blueAppearance,
                                       onCompletion: { (selectedIndexes, selectedValues) in
                                        if selectedValues.count > 0{
                                            
                                            var values = [String]()
                                            for index in selectedIndexes{
                                                values.append(fruits[index])
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
    func site(){
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
        let fruits = ["Cherry", "Apricots", "Banana", "Blueberry", "Orange", "Apple", "Grapes", "Guava", "Mango", "Cherries", "Damson", "Grapefruit", "Pluot", "Plums", "Kiwi", "Peach", "Pear", "Pomegranate", "Starfruit", "Watermelon", "Pineapples"]
        let picker = YBTextPicker.init(with: fruits, appearance: blueAppearance,
                                       onCompletion: { (selectedIndexes, selectedValues) in
                                        if selectedValues.count > 0{
                                            
                                            var values = [String]()
                                            for index in selectedIndexes{
                                                values.append(fruits[index])
                                            }
                                   self.btnSite.setTitle(values.joined(separator: ", "), for: .normal)
                                       self.btnSite.setTitleColor(.black, for: .normal)
                                            
                                        }else{
                                             self.btnCity.setTitle("City", for: .normal)
                                                                                self.btnCity.setTitleColor(.lightGray, for: .normal)
                                                                                  self.btnRate.setTitle("City", for: .normal)
                                                                                                                       self.btnRate.setTitleColor(.lightGray, for: .normal)
                                                                                  self.btnSite.setTitle("City", for: .normal)
                                                                                                                                          self.btnSite.setTitleColor(.lightGray, for: .normal)
                                        }
        },
                                       onCancel: {
                                        print("Cancelled")
                                           self.btnCity.setTitle("City", for: .normal)
                                      self.btnCity.setTitleColor(.lightGray, for: .normal)
                                        self.btnRate.setTitle("City", for: .normal)
                                                                             self.btnRate.setTitleColor(.lightGray, for: .normal)
                                        self.btnSite.setTitle("City", for: .normal)
                                                                                                self.btnSite.setTitleColor(.lightGray, for: .normal)
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
}
extension DailyReportVC: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        self.imge.image = image
        btnpickImage.setTitle("Change Image", for: .normal)
        imgHieghtConst.constant = 200
    }
}
