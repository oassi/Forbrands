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
        let button1 = UIBarButtonItem(title: "Skip", style: .plain, target: self, action: #selector(self.skip))
        let button2 = UIBarButtonItem(title: "Language".localized, style: .plain, target: self, action: #selector(self.ChangeLanguage))
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navgtion.navigationBar.barTintColor = UIColor(named: "white")
        button1.setTitleTextAttributes([ NSAttributedString.Key.font: UIFont.DinNextLtW23Regular(ofSize: 16)], for: .normal)
        button2.setTitleTextAttributes([ NSAttributedString.Key.font: UIFont.DinNextLtW23Regular(ofSize: 16)], for: .normal)
        
        navgtion.setLeftsButtons([button1], sender: self)
        navgtion.setRightButtons([button2], sender: self)
    }
    
    @objc func skip(){
        let vc:TTabBarController = TTabBarController.loadFromNib()
        vc.modalPresentationStyle = .fullScreen
        self.goToRoot(vc)
    }
    @objc func ChangeLanguage(){
        
    }

    
    
    @IBAction func btLoginWithPhone(_ sender: Any) {
        CurrentUser.typeSelect = userType.User
        let vc:RegistWithPhoneVC = RegistWithPhoneVC.loadFromNib()
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
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
    @IBAction func btSellr(_ sender: Any) {
        CurrentUser.typeSelect = userType.Seller
        let vc:LoginAsSellerVC = LoginAsSellerVC.loadFromNib()
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
   

}
