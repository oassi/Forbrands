//
//  TTabBarController.swift
//  Jina
//
//  Created by  musbah on 7/26/20.
//  Copyright © 2020  musbah. All rights reserved.
//

import UIKit

class TTabBarController: UITabBarController {
  

    let vc1 = HomeVC().navigationController()
    let vc2 = StoresVC().navigationController()
    let vc3 = CardVC().navigationController()
    let vc4 = MyAccountVC().navigationController()
    
    // Seller
    let vc5 = StoresSellerVC().navigationController()
    let vc6 = MyOrderVC().navigationController()
    let vc7 = MyAccountVC().navigationController()
//    let vc6 = OrderSellerVC().navigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = .white
        tabBar.tintColor = UIColor(named: "primary")
        selectedIndex = 0
        //Customer
        vc1.tabBarItem = UITabBarItem(title: "Home".localized, image: #imageLiteral(resourceName: "home"),  selectedImage: #imageLiteral(resourceName: "homeSelected"))
        vc2.tabBarItem = UITabBarItem(title: "Stores".localized, image: #imageLiteral(resourceName: "store"), selectedImage: #imageLiteral(resourceName: "storeSelected"))
        vc3.tabBarItem = UITabBarItem(title: "Card".localized, image: #imageLiteral(resourceName: "cart"), selectedImage: #imageLiteral(resourceName: "cartSelected"))
        vc4.tabBarItem = UITabBarItem(title: "My Account".localized, image: #imageLiteral(resourceName: "profile"), selectedImage: #imageLiteral(resourceName: "profileSelected"))
        
    
        self.tabBarController?.selectedIndex = 1
        
        // Seller
        vc5.tabBarItem = UITabBarItem(title: "My Stores".localized, image: #imageLiteral(resourceName: "home"),  selectedImage: #imageLiteral(resourceName: "homeSelected"))
        vc6.tabBarItem = UITabBarItem(title: "Order".localized, image: #imageLiteral(resourceName: "cart"), selectedImage: #imageLiteral(resourceName: "cartSelected"))
        vc7.tabBarItem = UITabBarItem(title: "My Account".localized, image: #imageLiteral(resourceName: "profile"), selectedImage: #imageLiteral(resourceName: "profileSelected"))
        if(CurrentUser.typeSelect == userType.User){
            viewControllers = [vc1,vc2,vc3,vc4]
        }else{
            viewControllers = [vc5,vc6,vc7]
        }
        
        
      
        
        let normalAttributes = [NSAttributedString.Key.font: UIFont.DinNextLtW23Regular(ofSize: 11)]
        let selectedAttributes = [NSAttributedString.Key.font: UIFont.DinNextLtW23Regular(ofSize: 11)]

        UITabBarItem.appearance().setTitleTextAttributes(normalAttributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, for: .selected)
        
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        
        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()
            appearance.shadowImage = nil
            appearance.shadowColor = nil
            appearance.backgroundColor = .white
            tabBar.isTranslucent = true
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributes
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributes
            tabBar.standardAppearance = appearance
            
        }

    }
    
   
  
}
