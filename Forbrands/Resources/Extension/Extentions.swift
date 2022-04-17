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
  
    var stringByRemovingWhitespaces: String {
            return components(separatedBy: .whitespaces).joined()
        }
 
    
}


extension UIImageView {
    func sd_custom(url: String, defultImage:UIImage? = nil){
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
    
    
    
    func showAlert(title: String, message:String, okAction: String = "Ok".localized, completion: ((UIAlertAction) -> Void)? = nil ) {
        let banner = Banner(title: title, subtitle: message, image: nil, backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        banner.textColor = .black
        banner.dismissesOnTap = true
        banner.show(duration: 5.0)
    }
    func showActionsheet(viewController: UIViewController,tint:String? = "", title: String, message: String,titleColor:String? = "", actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: Int) -> Void) {
        
        var alertStyle = UIAlertController.Style.actionSheet
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            alertStyle = UIAlertController.Style.alert
        }
        
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        alertViewController.setTint(color: "003B87".color)
        
        for (index, (title, style)) in actions.enumerated() {
            let alertAction = UIAlertAction(title: title, style: style) { (_) in
                completion(index)
            }
            alertViewController.addAction(alertAction)
        }
        viewController.present(alertViewController, animated: true, completion: nil)
    }
    
    
    func askForQuit(title: String, message:String, okAction: String = "Ok".localized, _ completion:@escaping (_ canQuit: Bool) -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okAction, style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            completion(true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel".localized, style: UIAlertAction.Style.cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            completion(false)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //Set tint color of UIAlertController
    func setTint(color: UIColor) {
        self.view.tintColor = color
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
    
    func showGif(imgName:String, loopCount:Int, mainView:UIView) {
        var imageview: UIImageView?
        //mainView.backgroundColor = .clear
        do {
            let gif = try UIImage(gifName: imgName)
            
            // Use -1 for infinite loop
            imageview = UIImageView(gifImage: gif, loopCount: loopCount)
            imageview?.frame = mainView.bounds
            imageview?.contentMode = .scaleAspectFit
            //self.imageview.delegate = self
            mainView.addSubview(imageview ?? UIImageView())
            
        } catch let error as NSError{
            print(error)
        }
        imageview?.startAnimatingGif()
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


extension UserDefaults {
    func object<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = self.value(forKey: key) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }

    func set<T: Codable>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        self.set(data, forKey: key)
    }
}

extension Notification.Name {
    static let didReceiveData = Notification.Name("didReceiveData")
    static let didCartCount = Notification.Name("didCartCount")

}
extension UIViewController {
    func removeCharacters(_ parameters:String,characters : String) -> String {
        let stringValue = parameters.replacingOccurrences(of: characters, with: "").stringByRemovingWhitespaces
       return stringValue
    }
    
}

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}
