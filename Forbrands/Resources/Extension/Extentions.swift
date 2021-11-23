//
//  Extentions.swift
//  Forbrands
//
//  Created by osamaaassi on 04/08/2021.
//

import Foundation
import UIKit
import SDWebImage
import BRYXBanner
extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    var color: UIColor {
        let hex = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return UIColor.clear
        }
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
}


extension UIImageView {
    func sd_custom(url: String, defultImage:UIImage? = nil){
//        self.sd_setShowActivityIndicatorView(true)
//        self.sd_setIndicatorStyle(.gray)
        let imageView = UIImageView(image: UIImage(named: "invite"))
        
        imageView.image = imageView.image?.imageWithColor(color1: "DDDDDD".color)
        
        self.sd_setImage(with: URL(string: url), placeholderImage: defultImage)
    }
    
}
extension UIImage {
    
    func imageWithColor(color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color1.setFill()
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}

extension UIViewController {
    
    static func loadFromNib() -> Self {
            func instantiateFromNib<T: UIViewController>() -> T {
                return T.init(nibName: String(describing: T.self), bundle: nil)
            }
            return instantiateFromNib()
        }
    
    func showAlert(title: String, message:String, okAction: String = "Ok".localized, completion: ((UIAlertAction) -> Void)? = nil ) {
        let banner = Banner(title: title, subtitle: message, image: nil, backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        banner.textColor = .black
        banner.show(duration: 3.0)
    }
    
    //with completion
    func showAlertWithCancel(title: String, message:String, okAction: String = "Ok".localized, completion: ((UIAlertAction) -> Void)? = nil ) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okAction, style: .destructive, handler: completion))
        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .default))
        let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.backgroundColor = UIColor(named: "white")

        alert.view.tintColor = UIColor(named: "alert") 

        
        present(alert, animated: true, completion: nil)
    }
    
    //with completion
    func showAlertWithCancelAndDefault(title: String, message:String, okAction: String = "Ok".localized, completion: ((UIAlertAction) -> Void)? = nil ) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okAction, style: .default, handler: completion))
        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .default))
        present(alert, animated: true, completion: nil)
    }
    
     func estimateFrameForText(_ text: String) -> CGRect {
            let size = CGSize(width: 200, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.DinNextLtW23Regular(ofSize: 16)], context: nil)

        }
    
}

extension UIViewController {
    
func navigationController() -> UINavigationController {
        
        //let navController = NavigationController(navigationBarClass: NavigationBar.self, toolbarClass: nil)
        let navController = CustomNavigationBar(rootViewController: self)
        // config
        //navController.navigation.configuration.isEnabled = true
        
        //navController.viewControllers = [self]
        return navController
    }
}

extension UITableView{
    
    func registerCell(id: String) {
        self.register(UINib(nibName: id, bundle: nil), forCellReuseIdentifier: id)
    }
}
extension UICollectionView {
    func dequeue<T: UICollectionViewCell>(cellForItemAt indexPath: IndexPath) -> T {
    return self.dequeueReusableCell(withReuseIdentifier: "\(T.self)", for: indexPath) as! T
    }
}
