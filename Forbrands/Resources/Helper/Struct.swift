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
    case Guest = "guest"
}

enum AssetsColor : String   {
   case primary = "primary"
   case penkApp = "penkApp"
   case primaryDarkApp = "primaryDarkApp"
   case NavyblueApp = "NavyblueApp"
   case redApp = "redApp"
   case greenApp = "greenApp"

}

struct SizeProduct:Codable{
    var id : Int?
    var size : String?
    
}
struct CurrentUser  {
    
    static var colorSelect : AssetsColor?  {
       
         set(colorSelect) {
               UserDefaults.standard.set(colorSelect?.rawValue, forKey: "colorSelect")
           }
           get {
               guard let colorSelect = UserDefaults.standard.value(forKey: "colorSelect") as? String else {
                   return nil
               }
               return AssetsColor(rawValue: colorSelect)
               
           }
           
       }
    
    
    
    static var userInfo : UserData?  {
        set {
            guard newValue != nil else {
                UserDefaults.standard.removeObject(forKey: "CurrentUser");
                return;
            }
            let encodedData = try? PropertyListEncoder().encode(newValue)
            UserDefaults.standard.set(encodedData, forKey:"CurrentUser")
            UserDefaults.standard.synchronize();
        }
        get {
            if let data = UserDefaults.standard.value(forKey:"CurrentUser") as? Data {
                return try? PropertyListDecoder().decode(UserData.self, from:data)

            }
            return nil
        }
    }
    static var userTrader : StoreTrader?  {
        set {
            guard newValue != nil else {
                UserDefaults.standard.removeObject(forKey: "userTrader");
                return;
            }
            let encodedData = try? PropertyListEncoder().encode(newValue)
            UserDefaults.standard.set(encodedData, forKey:"userTrader")
            UserDefaults.standard.synchronize();
        }
        get {
            if let data = UserDefaults.standard.value(forKey:"userTrader") as? Data {
                return try? PropertyListDecoder().decode(StoreTrader.self, from:data)

            }
            return nil
        }
    }
    
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
    
    static var myAccount : MyAccount?  {
        set {
            guard newValue != nil else {
                UserDefaults.standard.removeObject(forKey: "myAccount");
                return;
            }
            let encodedData = try? PropertyListEncoder().encode(newValue)
            UserDefaults.standard.set(encodedData, forKey:"myAccount")
            UserDefaults.standard.synchronize();
        }
        get {
            if let data = UserDefaults.standard.value(forKey:"myAccount") as? Data {
                return try? PropertyListDecoder().decode(MyAccount.self, from:data)

            }
            return nil
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

let KeyForUserDefaults = "CurrentCardItemasf"

struct CurrentCardItem :Codable {

    static var cardItem : [CardItem]?  {
        set {
            guard newValue != nil else {
                UserDefaults.standard.removeObject(forKey: "cartInfo");
                return;
            }
            let encodedData = try? PropertyListEncoder().encode(newValue)
            UserDefaults.standard.set(encodedData, forKey:"cartInfo")
            UserDefaults.standard.synchronize();
        }
        get {
            if let data = UserDefaults.standard.value(forKey:"cartInfo") as? Data {
                return try? PropertyListDecoder().decode([CardItem].self, from:data)
                
            }
            return nil
        }
    
    }

}



struct CardItem:Codable {
     let id : Int
     let nameAr :String?
     let nameEn :String?
     let detailsAr :String?
     let detailsEn :String?
     let oldPrice :Int?
     let price :Int?
     let images : String?
     var count:Int

}

func save(_ items: [CardItem]) {
    let data = items.map { try? JSONEncoder().encode($0) }
    UserDefaults.standard.set(data, forKey: KeyForUserDefaults)
}

func loads() -> [CardItem] {
    guard let encodedData = UserDefaults.standard.array(forKey: KeyForUserDefaults) as? [Data] else {
        return []
    }

    return encodedData.map { try! JSONDecoder().decode(CardItem.self, from: $0) }
}






