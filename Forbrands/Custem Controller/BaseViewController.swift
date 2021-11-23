//
//  BaseViewController.swift
//  HelpHandStore
//
//  Created by ahmed on 3/2/20.
//  Copyright © 2020 ahmed. All rights reserved.
//

import UIKit

    class BaseViewController: UIViewController {
        
//        var emptyView:EmptyView?

        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // enable swipe to pop
//            self.navigationController?.interactivePopGestureRecognizer?.delegate = self
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

            // swipe to Show side menu
    //        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
    //        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
    //        self.view.addGestureRecognizer(swipeRight)
            
        }
        
    //    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer){
    //        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
    //            switch swipeGesture.direction{
    //            case UISwipeGestureRecognizer.Direction.right:
    //                //write your logic for right swipe
    //                print("Swiped right")
    //                SlideMune.showSideMenuVC(self)
    //
    //            case UISwipeGestureRecognizer.Direction.left:
    //                //write your logic for left swipe
    //                print("Swiped left")
    //
    //            default:
    //                break
    //            }
    //        }
    //    }


        @IBAction func ShowMenuAction(_sender :UIViewController) {
            return
            
        }
        
        @objc func didClickRightButton(_sender :UIBarButtonItem) {
        }
        
        
        func didClickMenuButton(_sender :UIBarButtonItem) {
//            SlideMune.showSideMenuVC(self)
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
        
        
        func backRootButtonAction(_sender :UIBarButtonItem) {
                  
                   self.navigationController?.popToRootViewController(animated: true)
               }
        
        
        
           func backButtonActionToRoot(_sender :UIBarButtonItem) {
               self.navigationController?.popToRootViewController(animated: true)
              }
        
      
        
      
        
        
    }
