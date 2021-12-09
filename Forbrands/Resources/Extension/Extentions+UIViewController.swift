//
//  Extentions + UIViewController.swift
//
//
//  Created by  Ahmed’s MacBook Pro on 3/24/21.
// API

import Foundation
import UIKit
import PopupDialog
import KRProgressHUD

public var tintpopupColor = UIColor.red
public var hud = UIView()
public var loadingCircle = UIImageView()

extension UIViewController{
    
    // MARK: - Alert Dialog PopUp
    
    
    /*!
     Displays the default dialog without image, just as the system dialog
     Use: https://github.com/Orderella/PopupDialog
     */
    
    /// Method shows alert dialog float banner .
    /// - Parameters:
    ///   - title: Title of the alert
    ///   - message: Message of the alert
    ///   - okayButtonCompletionHandler: Handles action for "OK" button, if not used alert will be dismissed
    func showCustomDialog(title:String,message:String,animated: Bool = true,okayButtonCompletionHandler: @escaping () -> Void) {

        /*
         Dialog Default View Appearance Settings
         Customize popup style
         */
        
        let dialogAppearance = PopupDialogDefaultView.appearance()
        dialogAppearance.backgroundColor      = .white
        dialogAppearance.titleFont            = .boldSystemFont(ofSize: 14)
        dialogAppearance.titleColor           = UIColor(white: 0.4, alpha: 1)
        dialogAppearance.titleTextAlignment   = .center
        dialogAppearance.messageFont          = .systemFont(ofSize: 14)
        dialogAppearance.messageColor         = UIColor(white: 0.6, alpha: 1)
        dialogAppearance.messageTextAlignment = .center

        
        // Prepare the popup
        let title = title
        let message = message

        // Create the dialog
        let popup = PopupDialog(title: title,
                                message: message,
                                buttonAlignment: .horizontal,
                                transitionStyle: .zoomIn,
                                tapGestureDismissal: true,
                                panGestureDismissal: true,
                                hideStatusBar: true) {
        }
        
        /*
         Button Appearance Settings
         Customize button style
         */
        
        let buttonAppearance = DefaultButton.appearance()

        // Default button
        buttonAppearance.titleFont      = .systemFont(ofSize: 14)
        buttonAppearance.titleColor     = tintpopupColor
        buttonAppearance.buttonColor    = .clear
        buttonAppearance.separatorColor = UIColor(white: 0.9, alpha: 1)

        // Below, only the differences are highlighted

        // Cancel button
        CancelButton.appearance().titleColor = .lightGray

        
        // Create first button
        let buttonOne = CancelButton(title: "Cancel".localized) {
           
        }

        // Create second button
        let buttonTwo = DefaultButton(title: "Ok".localized) {
            okayButtonCompletionHandler()
        }

        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])

        // Present dialog
        self.present(popup, animated: animated, completion: nil)
    }
    
    
    
    /*
     Displays the default dialog with an image on top
     Use: https://github.com/Orderella/PopupDialog
     */
    
    /// Method shows alert dialog float banner .
    /// - Parameters:
    ///   - title: Title of the alert
    ///   - message: Message of the alert
    ///   - img: Image of the alert
    func showImageDialog(title:String,message:String,img:UIImage? = UIImage(named: "colorful"),animated: Bool = true,okayButtonCompletionHandler: @escaping () -> Void) {
        
        /*
         Dialog Default View Appearance Settings
         Customize popup style
         */
        
        let dialogAppearance = PopupDialogDefaultView.appearance()
        dialogAppearance.backgroundColor      = .white
        dialogAppearance.titleFont            = .boldSystemFont(ofSize: 20)
        dialogAppearance.titleColor           =  UIColor.black
        dialogAppearance.titleTextAlignment   = .center
        dialogAppearance.messageFont          = .systemFont(ofSize: 17)
        dialogAppearance.messageColor         = UIColor(white: 0.3, alpha: 1)
        dialogAppearance.messageTextAlignment = .center

        /*
         Button Appearance Settings
         Customize button style
         */
        
        let buttonAppearance = DefaultButton.appearance()

        // Default button
        buttonAppearance.titleFont      = .systemFont(ofSize: 17)
        buttonAppearance.titleColor     = tintpopupColor
        buttonAppearance.buttonColor    = .clear
        buttonAppearance.separatorColor = UIColor(white: 0.9, alpha: 1)
        CancelButton.appearance().titleFont = .systemFont(ofSize: 17)
        CancelButton.appearance().titleColor = "555555".color

        // Prepare the popup assets
        let title = title
        let message = message
        let image = img

        // Create the dialog
        let popup = PopupDialog(title: title, message: message, image: image, preferredWidth: 580)

        // Create first button
        let buttonOne = CancelButton(title: "Cancel".localized) {
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: "Ok".localized) {
            okayButtonCompletionHandler()
            
        }

        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])

        // Present dialog
        self.present(popup, animated: animated, completion: nil)

        
    }
    
    /*
     Displays alert logOut with title,Description and Image
     Use: https://github.com/Orderella/PopupDialog
     */
    
  
        
  
    
    /*
     Show Indicator
     Use: https://github.com/krimpedance/KRProgressHUD
     */
    
    /// Method Show Indicator .
    /// - Parameters:
    ///   - maskType:Type of KRProgressHUD's background view,default is clear.
    ///   - withMessage:True/False to show Indicator with label,default is false.
    ///   - backGroundIndicator: Style of KRProgressHUD color backGround,deafult is white
    ///   - colorIndicator: KRActivityIndicatorView colors,deafult is balck&lightGray
    func showIndicator(maskType:KRProgressHUDMaskType = .clear,withMessage:Bool = false,backGroundIndicator:KRProgressHUDStyle = .custom(background: "EEEEEE".color, text: .clear, icon: nil),colorIndicator:[UIColor] = [.black, .lightGray]){
       // self.view.isUserInteractionEnabled = false
        KRProgressHUD.set(maskType: maskType)
        KRProgressHUD.set(style: backGroundIndicator)
        KRProgressHUD.set(activityIndicatorViewColors: colorIndicator)
        KRProgressHUD.set(font: .systemFont(ofSize: 14))
        DispatchQueue.global(qos: .default).async(execute: {
           // time-consuming task
           DispatchQueue.main.async(execute: {
               if withMessage{
                   KRProgressHUD.show(withMessage: "Loading...".localized)
               }else{
                   KRProgressHUD.show()
               }
           })
       })
    }
    

    
    // MARK:- DatePicker
    
    func showDatePicker(mode:UIDatePicker.Mode,title:String,message:String,minimumDate:Date? = nil,maximumDate:Date? = nil,okayButtonCompletionHandler:@escaping((String) -> Void)){
        
        let alertStyle: UIAlertController.Style = .actionSheet
        var date: String = ""
        let alert = UIAlertController(style: alertStyle, title:title , message: message)
        alert.addDatePicker(mode: mode, date: Date(), minimumDate: minimumDate, maximumDate: maximumDate) { datePicker in
            print("DatePicker is:\(datePicker)")
            let stringDate = "\(datePicker)"
            date = stringDate
        }
        alert.addAction(title: "Done".localized, style: .cancel) { (_) in
            okayButtonCompletionHandler(date)
        }
        alert.show()
    }
    
    /*
     Hide Indicator
     Use: https://github.com/krimpedance/KRProgressHUD
     */
    
    /// Method Hide Indicator .

    func hideIndicator(){
        self.view.isUserInteractionEnabled = true
        DispatchQueue.global(qos: .default).async(execute: {
            // time-consuming task
            DispatchQueue.main.async(execute: {
                KRProgressHUD.dismiss()
            })
        })
    }
    
    
    // MARK: - SHOW/HIDE LOADING HUD
    
    func showHUD() {
        hud.frame = CGRect(x:0, y:0,
                           width:view.frame.size.width,
                           height: view.frame.size.height)
        hud.backgroundColor = .black
        hud.alpha = 0.4
        view.addSubview(hud)
        
        loadingCircle.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        loadingCircle.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
        loadingCircle.image = UIImage(named: "image")
        loadingCircle.contentMode = .scaleAspectFit
        loadingCircle.clipsToBounds = true
        //loadingCircle.rotate()
        animateLoadingCircle(imageView: loadingCircle, time: 0.8)
        view.addSubview(loadingCircle)
    }
    
    func animateLoadingCircle(imageView: UIImageView, time: Double) {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Double.pi * 2
        rotationAnimation.duration = time
        rotationAnimation.repeatCount = .infinity
        imageView.layer.add(rotationAnimation, forKey: nil)
    }
    
    // Hide HUD()
    
    func hideHUD() {
        hud.removeFromSuperview()
        loadingCircle.removeFromSuperview()
    }
    
    /// Method instantiate  viewController .
    /// - Parameters:
    ///   - id: NamewithIdentifier  of viewController
    
    func instantiate (id : String) -> UIViewController{
        return (storyboard?.instantiateViewController(withIdentifier: id))!
    }

    /**
     Method load nib viewController
    */
    
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }

    /// Dismisses the keyboard when user taps anywhere on the screen
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    /// Dismiss the keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
        toucheArround()
    }
    
    /// Disables swipe gesture feature to pop VC
    func disableGesturePopup(){
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    /// Sense the touch and call dismiss Keyboard action
    @objc func toucheArround(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    /// Method use UIActivityViewController to share type  .
    /// - Parameters:
    ///   - msg: Title  share
    ///   - image: Image share
    ///   - url: Url share
    func showShareActivity(msg:String?, image:UIImage?, url:String?, sourceRect:CGRect?){
        var objectsToShare = [AnyObject]()

        if let url = url {
            objectsToShare = [url as AnyObject]
        }

        if let image = image {
            objectsToShare = [image as AnyObject]
        }

        if let msg = msg {
            objectsToShare = [msg as AnyObject]
        }

        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        if UIDevice.current.userInterfaceIdiom == .pad {
            activityVC.popoverPresentationController?.sourceView = self.view
            activityVC.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY,width: 0,height: 0)
        }

        activityVC.modalPresentationStyle = .popover
        activityVC.popoverPresentationController?.sourceView = topViewController().view
        if let sourceRect = sourceRect {
            activityVC.popoverPresentationController?.sourceRect = sourceRect
        }
        /// Remove   AirDrop Share
        if floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1 {
            activityVC.excludedActivityTypes = [.airDrop]
        }
        DispatchQueue.main.async(execute: { [self] in
            self.topViewController().present(activityVC, animated: true, completion: nil)

        })
    }
    

    // func navigationController() -> UINavigationController {

         //let navController = NavigationController(navigationBarClass: NavigationBar.self, toolbarClass: nil)
         // let navController = CustomNavigationBar(rootViewController: self)
         // config
         //navController.navigation.configuration.isEnabled = true

         //navController.viewControllers = [self]
         //return navController
    // }
    

    func topViewController()-> UIViewController{
        var topViewController:UIViewController = UIApplication.shared.keyWindow!.rootViewController!

        while ((topViewController.presentedViewController) != nil) {
            topViewController = topViewController.presentedViewController!;
        }

        return topViewController
    }
    
    
    /// Method shows  alert with "OK" button, action on "OK" can be defined where you use it.
        /// - Parameters:
        ///   - title: Title of the alert
        ///   - message: Message of the alert
        ///   - buttonTitle: Title of the button
        ///   - okayButtonCompletionHandler: Handles action for "OK" button, if not used alert will be dismissed
        func showOkAlert(withTitle title: String, message : String, buttonTitle: String = "OK".localized,  style: UIAlertController.Style? = .alert, okayButtonCompletionHandler: (() -> Void)? = nil) {
            
            
            
           // Utility.vibrateFeedBack()
            let alertController = UIAlertController(title: title, message: message, preferredStyle: style!)
            let OKAction = UIAlertAction(title: buttonTitle, style: .default) { action in
                guard let completionHandler = okayButtonCompletionHandler?() else { return }
                completionHandler
            }
            
            alertController.setTint(color: tintpopupColor)
            alertController.addAction(OKAction)
            
            if style == UIAlertController.Style.actionSheet {
                let cancelButton = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: { (action) -> Void in
                    
                })
                
                alertController.addAction(cancelButton)
            }
            DispatchQueue.main.async {
                self.present(alertController, animated: true, completion: nil)
            }
        }

 
}

