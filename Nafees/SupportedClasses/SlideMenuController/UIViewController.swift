//
//  UIViewControllerExtension.swift
//  SlideMenuControllerSwift
//
//  

import UIKit

extension UIViewController {
    
    func setNavigationBarItem() {
        
        self.addLeftBarButtonWithImage(UIImage(named: "Menu")!)

        //self.addRightBarButtonWithImage(UIImage(named: "rightIcon")!)
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addLeftGestures()
        self.slideMenuController()?.addRightGestures()
        
   navigationController?.navigationBar.setBackgroundImage( #colorLiteral(red: 0.1703902781, green: 0.4800947905, blue: 0.745217979, alpha: 1).as1ptImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIColor.white.as1ptImage()
    }
    
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
    }
}
extension UIColor {
    
    /// Converts this `UIColor` instance to a 1x1 `UIImage` instance and returns it.
    ///
    /// - Returns: `self` as a 1x1 `UIImage`.
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}
