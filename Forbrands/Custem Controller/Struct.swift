//
//  Struct.swift
//  Forbrands
//
//  Created by osamaaassi on 11/08/2021.
//

import Foundation
import AVFoundation
import UIKit
enum userType: String {
    case User = "user"
    case Seller = "seller"
}
struct CurrentUser  {
 static var typeSelect : userType?  {
        set(typeSelect) {
            UserDefaults.standard.set(typeSelect?.rawValue, forKey: "typeSelect")
        }
        get {
            guard let typeSelect = UserDefaults.standard.value(forKey: "typeSelect") as? String else {
                return nil
            }
            return userType(rawValue: typeSelect)
            
        }
        
    }

}
struct SocialNetworkUrl {
    let scheme: String
    let page: String

    func openPage() {
        let schemeUrl = NSURL(string: scheme)!
        if UIApplication.shared.canOpenURL(schemeUrl as URL) {
            UIApplication.shared.open(schemeUrl as URL)
        } else {
            UIApplication.shared.open(NSURL(string: page)! as URL)
        }
    }
}
