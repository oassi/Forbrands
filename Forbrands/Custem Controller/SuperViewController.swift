//
//  SuperViewController.swift
//  Project
//  edit from git
//  Created by ahmed on 6/10/18.
//  Copyright © 2018 ahmed. All rights reserved.
//

import UIKit

class SuperViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var hasTopNotch: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
    
    //var emptyView:EmptyView?
    
    
    
    //    var AcoountStruct:ProfileStruct?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.mirroringviewDidLoad()
        // enable swipe to pop
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        // Do any additional setup after loading the view.
    }
    
    //    func getProfileRequest(){
    //        _ = WebRequests.setup(controller: self).prepare(query: "profile", method: HTTPMethod.get,isAuthRequired:true).start(){ (response, error) in
    //            do{
    //                let object =  try JSONDecoder().decode(UserObject.self, from: response.data!)
    //                CurrentUser.userInfo = object.user!
    //             } catch let jsonErr {
    //                print("Error serializing  respone json", jsonErr)
    //            }
    //        }
    //    }
    
    func didClickProfileButton(_sender :UIBarButtonItem) {
    }
    
    func didClickRightButton(_sender :UIBarButtonItem) {
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func backButtonAction(_sender :UIBarButtonItem) {
        let isFromOrderNotfication = UserDefaults.standard.bool(forKey: "isNotification")
        if isFromOrderNotfication{
            let vc:TTabBarController = TTabBarController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            UserDefaults.standard.set(false, forKey: "isNotification")
            
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //    func backRootButtonAction(_sender :UIBarButtonItem) {
    //
    //           self.navigationController?.popToRootViewController(animated: true)
    //       }
    
    func ShowMenuAction(_sender :UIBarButtonItem) {
        
    }
    
    func backButtonActionWithdismiss(_sender :UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func backButtonActionToRoot(_sender :UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    func backRootButtonAction(_sender :UIBarButtonItem) {
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    func CheckTable() {
        
    }
    
    
    
} 
