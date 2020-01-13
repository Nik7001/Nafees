//
//  UIButtonExtension.swift


import UIKit

extension UIButton {
    
    func shrinkOnTap() {
        self.addTarget(self, action: #selector(shrink(_:)), for: .touchDown);
        self.addTarget(self, action: #selector(expand(_:)), for: .touchUpInside);
    }
    
    @objc fileprivate func shrink(_ sender: UIButton!) {
        UIView.animate(withDuration: 0.15, animations: {
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8);
        })
    }
    
    @objc fileprivate func expand(_ sender: UIButton!) {
        UIView.animate(withDuration: 0.15, animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1);
        })
    }
    
    var CurrentTitle: String {
        get {
            if let title = self.currentTitle {
                return title
            }
            return ""
        }
    }
    func changeImageColor(strImageName:String , imageColor : UIColor){
        let origImage = UIImage(named: strImageName)
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        self.setImage(tintedImage, for: .normal)
        self.tintColor = imageColor
    }
    func setBtnCornner(){
        
    }
}
