//
//  Constant.swift
//  StandardApp
//
//  Created by  Ahmed’s MacBook Pro on 5/1/21.
//

import Foundation
import UIKit

struct App {
    struct Keys {
        static let user_token = "user_token"
        static let noticias_favoritadas = "noticias_favoritadas"

    }
    
    struct DOMAIN_URL {
        static let dev_URL = "https://forbrand.almusand.com/api/"
        static let production_URL = "https://forbrand.almusand.com/api/"
        static let stage_URL = "https://forbrand.almusand.com/api/"
    }
    
    struct IMG_URL {
        static let img_URL = "https://forbrand.almusand.com"
    }
   
    struct Image {
        static let logo_app = "logo_app"
        static let ic_arroba = "ic_arroba"
        static let ic_password_visivel = "ic_password_visivel"
        static let ic_password_invisivel = "ic_password_invisivel"
        static let ic_pessoa = "ic_pessoa"
        static let ic_senha = "ic_senha"
        static let ic_noticia_nao_favoritada = "ic_noticia_nao_favoritada"
        static let ic_noticia_favoritada = "ic_noticia_favoritada"
        static let ic_filtrar = "ic_filtrar"
        static let fake_blur_image = "fake_blur_image"
        static let ic_logout = "ic_logout"
    }
    
    static func deleteAddress(_ viewController:UIViewController?, id:String, completion:((Bool)->Void)?) {
        viewController?.showAlertWithCancel(title: "", message: "Are you sure to delete?".localized, okAction: "Delete".localized, completion: { bool in
            
            _ = WebRequests.setup(controller: viewController).prepare(api: Endpoint.deleteAddress,nestedParams: id ,isAuthRequired: true).start(){  (response, error) in
                do {
                    let Status =  try JSONDecoder().decode(StatusStruct_.self, from: response.data!)
                    guard Status.code == 200 else{
                        viewController?.showAlert(title: Status.title ?? "", message: Status.message ?? "")
                        return
                    }
                    completion?(true)
                }catch let jsonErr {
                    print("Error serializing  respone json", jsonErr)
                }
            }
        })
    }
    
    static func fav(_ viewController:UIViewController?, id:String, completion:((Bool)->Void)?){
        if CurrentUser.typeSelect == userType.Guest{
            App.logout(viewController)
        } 
       _ = WebRequests.setup(controller: viewController).prepare(api: Endpoint.fav,nestedParams: id ,isAuthRequired:  true).start(){  (response, error) in
        
            do {
                
                let Status =  try JSONDecoder().decode(BaseDataResponse<Favorites>.self, from: response.data!)
                
                if Status.code == 200{
                    print("_____ FAV Done _____")
                    print( Status.message ?? "")
                    completion?(true)
                }else{
                    print("_____ FAV Error _____")
                    print( Status.message ?? "")
                    completion?(false)
                }
            }catch let jsonErr {
                completion?(false)
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
    
    
    
    static func unFav(_ viewController:UIViewController?, id:String, completion:((Bool)->Void)?){
        if CurrentUser.typeSelect == userType.Guest{
            App.logout(viewController)
        }
       _ = WebRequests.setup(controller: viewController).prepare(api: Endpoint.unfav,nestedParams: id ,isAuthRequired:  true).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(StatusStruct.self, from: response.data!)
                if Status.code == 200{
                    print("_____ unFAV Done _____")
                    print( Status.message ?? "")
                    completion?(true)
                }else{
                    print("_____ unFAV Error _____")
                    print( Status.message ?? "")
                    completion?(false)
                }
            }catch let jsonErr {
                completion?(false)
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
    
    static func deleteProducts(_ viewController:UIViewController?, id:String, completion:((Bool)->Void)?){
       _ = WebRequests.setup(controller: viewController).prepare(api: Endpoint.deleteProduct,nestedParams: id ,isAuthRequired:  true).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(DeleteProdect.self, from: response.data!)
                if Status.code == 200{
                    print("_____ deleteProducts Done _____")
                    print( Status.message ?? "")
                    completion?(true)
                }else{
                    print("_____ deleteProducts Error _____")
                    print( Status.message ?? "")
                    completion?(false)
                }
            }catch let jsonErr {
                completion?(false)
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
    static func addCart(_ viewController:UIViewController?,parameters : [String : String] = [:], completion:((Bool)->Void)?){
       _ = WebRequests.setup(controller: viewController).prepare(api: Endpoint.addCart ,parameters: parameters ,isAuthRequired:  true).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<CartObj>.self, from: response.data!)
                if Status.code == 200{
                    print("_____ addProducts Done _____")
                    print( Status.message ?? "")
                    print(Status.data?.count?.description)
                    UserDefaults.standard.set("\(Status.data?.count?.description ?? "0")", forKey: "countCart")

                    NotificationCenter.default.post(name: .didCartCount, object: nil)
                
                    
                    completion?(true)
                }else{
                    print("_____ addProducts Error _____")
                    print( Status.message ?? "")
                    completion?(false)
                }
            }catch let jsonErr {
                completion?(false)
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
    static func removeProductCart(_ viewController:UIViewController?,parameters : [String : String] = [:], completion:((Bool)->Void)?){
       _ = WebRequests.setup(controller: viewController).prepare(api: Endpoint.removeProductCart ,parameters: parameters ,isAuthRequired:  true).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<CartObj>.self, from: response.data!)
                if Status.code == 200{
                    print("_____ deleteProducts Done _____")
                    print( Status.message ?? "")
                    UserDefaults.standard.set("\(Status.data?.count?.description ?? "0")", forKey: "countCart")
                    NotificationCenter.default.post(name: .didCartCount, object: nil)
                    completion?(true)
                }else{
                    print("_____ deleteProducts Error _____")
                    print( Status.message ?? "")
                    completion?(false)
                }
            }catch let jsonErr {
                completion?(false)
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
    
    static func logout(_ viewController:UIViewController?) {
        let vc = LoginVC.loadFromNib().navigationController()
        vc.modalPresentationStyle = .fullScreen
        viewController?.goToRoot(vc)
    }
  
    
    
}

struct StatusStruct : Codable{
    let status: Bool?
    let code: Int?
    let message: String?
    let title: String?
    let data : [String]?

}
struct StatusStruct_ : Codable{
    let status: Bool?
    let code: Int?
    let message: String?
    let title: String?
    let data : DataClass

}


struct StatusAddressEdit : Codable{
    let status: Bool?
    let code: Int?
    let message: String?
    let title: String?
    let data : Bool?
}

struct DeleteProdect: Codable {
    var status: Bool
    var code: Int
    var title, message: String
    var data: DataClass
}

struct DataClass: Codable {
}

struct TabbyStruct : Codable{
    let status: String?
    let web_url: String?
}

enum DataType: String {
    case json
    case serialize
}

enum NetworkEnvironment{
    case dev
    case production
    case stage
}

enum APIKeys{
    static let GoogleMapsKey     = "AIzaSyBTJ2d8rXzUg-eP8yoGqZI86wcRuXlDP_0"
    static let GooglePlacesKey   = "AIzaSyBTJ2d8rXzUg-eP8yoGqZI86wcRuXlDP_0"
}

enum DateTimeFormats {
    static let kAPIDOBFormat = "yyyy-MM-dd"
    static let kDOBFormat = "dd-MM-yyyy"
    static let kStandardFormat = "dd-MM-yyyy HH:mm:ss"
    static let kTodaysDate = "MMM dd,yyyy HH:MM:ss"
    static let kSuccessFormat = "h:mm a '|' MMM dd yyyy"
    static let kDOBMonthFormat = "dd MMM yyyy"
    static let utcDateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
    static let utcDateFormatWithZone = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
}

enum messages {
    
    ///Public messages  App
    static let alert = "Alert!".localized
    static let emptyEmail = "Please Enter Email".localized
    static let emptyPhone = "Please Enter Phone".localized
    static let emptyYourName = "Please Enter Your Name".localized
    static let emptyPassword = "Please Enter Password".localized
    static let emptyCode = "Please Enter Code".localized
    static let notMatchPassword = "password does not match the password confirmation".localized
    static let mobileValid = "mobile Not Valid!".localized
    static let selectImage = "choose one photo at lest".localized
    static let selectDate = "Select Date".localized
    
    ///API
    static let noIntrentConnection = "There is no internet connection".localized
    static let api = "API".localized
    static let notAuthorized = "not Authorized".localized
    static let notValidData = "Not Valid Data!".localized


}

enum MaxLengths {
    static  let  mobileLength = 9
    static  let  maxCardHolderNameLength = 100
    static  let  pinLength             = 4
    static  let  nationalId            = 10
    static  let  ibanLength            = 24
}

enum ScreenSize {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
}

enum TypeVer : Int {
    case signUp
    case forgatepassword
    
}

enum TypeForgate:String{
    case email = "email"
    case phone = "phone"
    
}

enum LikeStatus {
    case liked, unliked
}

struct BannerColors {
    static let red = UIColor(red:198.0/255.0, green:26.00/255.0, blue:27.0/255.0, alpha:1.000)
    static let green = UIColor(red:48.00/255.0, green:174.0/255.0, blue:51.5/255.0, alpha:1.000)
    static let yellow = UIColor(red:255.0/255.0, green:204.0/255.0, blue:51.0/255.0, alpha:1.000)
    static let blue = UIColor(red:31.0/255.0, green:136.0/255.0, blue:255.0/255.0, alpha:1.000)
}


enum AttributedTextBlock {
    
    case header1(String)
    case header2(String)
    case normal(String)
    case list(String)
    
    var text: NSMutableAttributedString {
        let attributedString: NSMutableAttributedString
        switch self {
        case .header1(let value):
            let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 20), .foregroundColor: UIColor.black]
            attributedString = NSMutableAttributedString(string: value, attributes: attributes)
        case .header2(let value):
            let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 18), .foregroundColor: UIColor.black]
            attributedString = NSMutableAttributedString(string: value, attributes: attributes)
        case .normal(let value):
            let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 15), .foregroundColor: UIColor.black]
            attributedString = NSMutableAttributedString(string: value, attributes: attributes)
        case .list(let value):
            let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 15), .foregroundColor: UIColor.black]
            attributedString = NSMutableAttributedString(string: "∙ " + value, attributes: attributes)
        }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        paragraphStyle.lineHeightMultiple = 1
        paragraphStyle.paragraphSpacing = 10
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range:NSMakeRange(0, attributedString.length))
        return attributedString
    }
    
    
    
   
}


