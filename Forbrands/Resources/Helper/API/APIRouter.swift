//
//  APIRouter.swift
//  Alerts
//
//  Created by  Ahmed’s MacBook Pro on 11/21/20.
//  Copyright © 2020  Ahmed’s MacBook Pro. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

enum Endpoint {
    
    #if DEBUG
    static let networkEnviroment: NetworkEnvironment = .dev
    #else
    static let networkEnviroment: NetworkEnvironment = .production
    #endif
    
    //MARK: - APIRouter URL -
    public static var DOMAIN_URL :String{
        switch Endpoint.networkEnviroment {
        case .dev:
            return App.DOMAIN_URL.dev_URL
        case .production:
            return App.DOMAIN_URL.production_URL
        case .stage:
            return App.DOMAIN_URL.stage_URL
            
        }
    }
    // Auth
    case login
    case register
    case generateActiveCode
    case verifyPhoneCode
   
    
    //About App
    case aboutApp
    case conditions
    case privacyPolicy
    case contactUs
  
    //subscription
    case subscriptionCustomer
    case subscriptionTrader
    
    //Payment
    case payMethods
    case payMethodsByStore
    case updatePayMethodByStore
    case payMethodsList
   
    
    //Store
    case storesList
    case storeByID
    case addStoresInfo
    case editStoresInfo
    case categoriesList
    case productsByStore
    case productsByStoreAuth
    case myStoreSeller
    case storePolicy
    
    //profile
    case uploadImageProfile
    case editProfile
    case userProfile

   
    
    //My Account
    case myAccount
    case uploadImageStore
    
    //Address
    case addAddress
    case addressList
    case deleteAddress
    case editAddress

    case statesList
    case citiesByStates
    
    // User Home Page
        ///Home
    case homePage
    case productsByCategory
    case productsByCategoryAuth
    
    //favorite
    case fav
    case unfav
    case favList
    
    //Prodect
    case addProduct
    case getProductsByStoreByCategory
    case deleteProduct
    case editProduct
    case getProduct
    case productChangeStatus
    case reviewsByID
    
    
    //order
    case addOrders
    case customerOrders
    case cancelOreder
    case changeProcessTrader
    case addReview
    case traderOrders
    
    //search
    case search
    
    //ContactUs
    case contactWithUs
    
    //Payment
    case tabby
    case tap
    case stc
    case point
    
    //Cart
    case addCart
    case removeProductCart
    case listCart
    case addPromoCode
    case deletePromoCode
    case ordersComplete
    
    //Splash
    case adsList
   
    
    public var values : (url: String ,reqeustType: HTTPMethod,key :String?){
        get{
            switch self {
            // Auth
            case .login:
                return (Endpoint.DOMAIN_URL + "admin/login",.post,nil)
            case .register:
                return (Endpoint.DOMAIN_URL + "admin/register",.post,nil)
            case .generateActiveCode:
                return (Endpoint.DOMAIN_URL + "v1/user/generateActiveCode/",.get,nil)
            case .verifyPhoneCode:
                return (Endpoint.DOMAIN_URL + "v1/user/verifyPhoneCode/",.get,nil)
                
            // Cart
            
            case .addCart:
                return (Endpoint.DOMAIN_URL + "v1/user/addcart",.post,nil)
            case .removeProductCart:
                return (Endpoint.DOMAIN_URL + "v1/user/removeproductcart",.post,nil)
            case .listCart:
                return (Endpoint.DOMAIN_URL + "v1/user/cart",.get,nil)
                
            case .addPromoCode:
                return (Endpoint.DOMAIN_URL + "v1/user/discount",.get,nil)
            case .deletePromoCode:
                return (Endpoint.DOMAIN_URL + "v1/user/cancel/discount",.get,nil)
            case .ordersComplete:
                return (Endpoint.DOMAIN_URL + "v1/orders/show",.get,nil)
                
                
            //About App
            case .aboutApp:
                return (Endpoint.DOMAIN_URL + "v1/about_app",.get,nil)
            case .conditions:
                return (Endpoint.DOMAIN_URL + "v1/conditions",.get,nil)
            case .privacyPolicy:
                return (Endpoint.DOMAIN_URL + "v1/privacy_policy",.get,nil)
            case .contactUs:
                return (Endpoint.DOMAIN_URL + "v1/contact_us/list",.get,nil)
                
                
            //profile
            case .uploadImageProfile:
                return (Endpoint.DOMAIN_URL + "v1/user/upload_image",.post,nil)
            case .editProfile:
                return (Endpoint.DOMAIN_URL + "v1/user/edit",.post,nil)
            case .userProfile:
                return (Endpoint.DOMAIN_URL + "v1/user/profile",.get,nil)
                
                
            //subscription
            case .subscriptionCustomer:
                return (Endpoint.DOMAIN_URL + "v1/subscription/customer",.get,nil)
            case .subscriptionTrader:
                return (Endpoint.DOMAIN_URL + "v1/subscription/trader",.get,nil)
                
            //Payment
            case .payMethods:
                return (Endpoint.DOMAIN_URL + "v1/pay_methods/list",.get,nil)
            case .payMethodsByStore:
                return (Endpoint.DOMAIN_URL + "v1/pay_methods/store/",.get,nil)
            case .updatePayMethodByStore:
                return (Endpoint.DOMAIN_URL + "v1/pay_method/store_list",.post,nil)
            case .payMethodsList:
                return (Endpoint.DOMAIN_URL + "v1/pay_methods/list",.get,nil)
                
                
            //Store
            case .storesList:
                return (Endpoint.DOMAIN_URL + "v1/stores/list",.get,nil)
            case .storeByID:
                return (Endpoint.DOMAIN_URL + "v1/stores/",.get,nil)
            case .addStoresInfo:
                return (Endpoint.DOMAIN_URL + "v1/stores/add",.post,nil)
            case .editStoresInfo:
                return (Endpoint.DOMAIN_URL + "v1/stores/edit/",.post,nil)
            case .uploadImageStore:
                return (Endpoint.DOMAIN_URL + "v1/stores/upload_image/",.post,nil)
            case .categoriesList:
                return (Endpoint.DOMAIN_URL + "v1/categories/list",.get,nil)
            case .productsByStore:
                return (Endpoint.DOMAIN_URL + "v1/products/store/",.get,nil)
            case .productsByStoreAuth:
                return (Endpoint.DOMAIN_URL + "v1/products/store_auth/",.get,nil)
            case .myStoreSeller:
                return (Endpoint.DOMAIN_URL + "v1/stores/my_store",.get,nil)
            case .storePolicy:
                return (Endpoint.DOMAIN_URL + "stores/storePolicy/",.get,nil)
                
                
            //My Account
            case .myAccount:
                return (Endpoint.DOMAIN_URL + "v1/my_account/list",.get,nil)
                
            //Address
            case .addAddress:
                return (Endpoint.DOMAIN_URL + "v1/address/add",.post,nil)
            case .addressList:
                return (Endpoint.DOMAIN_URL + "v1/address/list",.get,nil)
            case .deleteAddress:
                return (Endpoint.DOMAIN_URL + "v1/address/delete/",.get,nil)
            case .editAddress:
                return (Endpoint.DOMAIN_URL + "v1/address/edit/",.post,nil)
                
            case .statesList:
                return (Endpoint.DOMAIN_URL + "v1/states/list",.get,nil)
            case .citiesByStates:
                return (Endpoint.DOMAIN_URL + "v1/cities/state/",.get,nil)
            
             
            // User Home
                ///Home
            case .homePage:
                return (Endpoint.DOMAIN_URL + "v1/home_page/list",.get,nil)
            case .productsByCategory:
                return (Endpoint.DOMAIN_URL + "v1/products/category/",.get,nil)
            case .productsByCategoryAuth:
                return (Endpoint.DOMAIN_URL + "v1/products/category_auth/",.get,nil)
                
                
                
            //favorite
            case .fav:
                return (Endpoint.DOMAIN_URL + "v1/favorite/add/",.get,nil)
            case .unfav:
                return (Endpoint.DOMAIN_URL + "v1/favorite/delete/",.get,nil)
            case .favList:
                return (Endpoint.DOMAIN_URL + "v1/favorite/list",.get,nil)
                
            //Prodect
            case .addProduct:
                return (Endpoint.DOMAIN_URL + "v1/products/add",.post,nil)
            case .getProductsByStoreByCategory:
                return (Endpoint.DOMAIN_URL + "v1/products/store/\(CurrentUser.userInfo?.store?.id ?? 0)/category/",.get,nil)
            case .deleteProduct:
                return (Endpoint.DOMAIN_URL + "v1/products/delete/",.get,nil)
            case .editProduct:
                return (Endpoint.DOMAIN_URL + "v1/products/edit/",.post,nil)
            case .getProduct:
                return (Endpoint.DOMAIN_URL + "v1/products/",.get,nil)
            case .productChangeStatus:
                return (Endpoint.DOMAIN_URL + "v1/products/change_status/",.get,nil)
            case .reviewsByID:
                return (Endpoint.DOMAIN_URL + "v1/products/reviews_list/",.get,nil)
             
            //order
            case .addOrders:
                return (Endpoint.DOMAIN_URL + "v1/orders/add",.post,nil)
            case .customerOrders:
                return (Endpoint.DOMAIN_URL + "v1/orders/customer/list",.get,nil)
            case .cancelOreder:
                return (Endpoint.DOMAIN_URL + "v1/orders/customer/process",.post,nil)
            case .changeProcessTrader:
                return (Endpoint.DOMAIN_URL + "v1/orders/trader/process",.post,nil)
            case .addReview:
                return (Endpoint.DOMAIN_URL + "v1/orders/addReview",.post,nil)
            case .traderOrders:
                return (Endpoint.DOMAIN_URL + "v1/orders/list",.get,nil)
               
            //search
            case .search:
                return (Endpoint.DOMAIN_URL + "search",.get,nil)
            //contactUs
            case .contactWithUs:
                return (Endpoint.DOMAIN_URL + "v1/ContactUs",.post,nil)
        
            //Payment
            case .tabby:
                return (Endpoint.DOMAIN_URL + "v1/credit/taby",.get,nil)
            case .tap:
                return (Endpoint.DOMAIN_URL + "credit/tap",.get,nil)
            case .stc:
                return (Endpoint.DOMAIN_URL + "credit/stc",.get,nil)
            case .point:
                    return (Endpoint.DOMAIN_URL + "User/point",.get,nil)
            
            //Splash
            case .adsList:
                    return (Endpoint.DOMAIN_URL + "v1/ads/front/list",.get,nil)
            
            
            }
            

        }
        
    }
}

//private let manager: Alamofire.SessionManager = {
//     let configuration = URLSessionConfiguration.default
//     configuration.timeoutIntervalForRequest = 100
//     configuration.timeoutIntervalForResource = 100
//     return Alamofire.SessionManager(configuration: configuration)
// }()



