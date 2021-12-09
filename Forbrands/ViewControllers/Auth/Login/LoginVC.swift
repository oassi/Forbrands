//
//  LoginVC.swift
//  Forbrands
//
//  Created by osamaaassi on 05/08/2021.
//

import UIKit

class LoginVC: SuperViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        // Do any additional setup after loading the view.
       
        
    }
    
    
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.navigationBar.layer.masksToBounds = true
        navgtion.navigationBar.barTintColor = UIColor(named: "white")
        navgtion.setRightButtons([navgtion.skipNav!], sender: self)
        navgtion.setLeftsButtons([navgtion.languageNav!], sender: self)
        //navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
    }
    
    override func didClickRightButton(_sender: UIBarButtonItem) {
        switch _sender.tag {
        case 140:
            skip()
        case 150:
            ChangeLanguage()
        default:
            break
        }
    }
    
    func skip(){
        CurrentUser.typeSelect = userType.Guest
  
        let vc:TTabBarController = TTabBarController.loadFromNib()
        vc.modalPresentationStyle = .fullScreen
        self.goToRoot(vc)
    }
    func ChangeLanguage(){
        var actions: [(String, UIAlertAction.Style)] = []
        if(MOLHLanguage.currentAppleLanguage() == "ar"){
            actions.append(("English", UIAlertAction.Style.default))
        }
        if(MOLHLanguage.currentAppleLanguage() == "en"){
            actions.append(("العربية", UIAlertAction.Style.default))
        }
        
        actions.append(("Cancel", UIAlertAction.Style.cancel))
        
        showActionsheet(viewController: self, title: "Alert!".localized, message: "The language settings for the application will be changed.".localized, actions: actions) { (index) in
            print("call action \(index)")
            switch index{
            case 0:
                if(MOLHLanguage.currentAppleLanguage() == "ar"){
                    MOLH.setLanguageTo("en")
                    MOLH.reset(transition: .transitionCrossDissolve, duration: 0.25)
                }else{
                    MOLH.setLanguageTo("ar")
                    MOLH.reset(transition: .transitionCrossDissolve, duration: 0.25)
                }
            default:
                break
            }
            
        }
        
    }

    
    @IBAction func btLoginWithGoogle(_ sender: Any) {
        CurrentUser.typeSelect = userType.User
    }
    
    @IBAction func btTermsAndConditions(_ sender: Any) {
        let vc:TermsAndConditionsVC = TermsAndConditionsVC.loadFromNib()
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btRegester(_ sender: UIButton) {
        var vc:UIViewController!
        switch sender.tag {
        case 0:
            CurrentUser.typeSelect = userType.Seller
             vc = RegesterAsSellerVC.loadFromNib()
        case 1:
            CurrentUser.typeSelect = userType.User
            vc  = RegistrationFormVC.loadFromNib()
        default:
            break
        }
       
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
  
  
    
    

}
