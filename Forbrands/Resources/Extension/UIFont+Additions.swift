//
//  UIFont+Additions.swift
//  Tawseel
//
//  Created by Musbah on 8/30/19.
//  Copyright © 2019 Musbah. All rights reserved.
//

import Foundation
import UIKit


extension UIFont {
 
    
  
    static func CairoBold(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Cairo-Bold", size: ofSize)!
    }
    
    static func CairoReqular(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Cairo-Regular", size: ofSize)!
    }
    
    static func CairoSemiBold(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Cairo-SemiBold", size: ofSize)!
    }
    static func DinNextLtW23Regular(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "DINNextLTW23-Regular", size: ofSize)!
    }
//    static func DINNextLTArabic(ofSize: CGFloat) -> UIFont {
//        return UIFont(name: "DINNextLTW23-Regular", size: ofSize)!
//    }
    
    static func RobotoBold(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Bold", size: ofSize)!
    }
    static func RobotoMedium(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Medium", size: ofSize)!
    }
    static func RobotoRegular(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Regular", size: ofSize)!
    }
  
}


