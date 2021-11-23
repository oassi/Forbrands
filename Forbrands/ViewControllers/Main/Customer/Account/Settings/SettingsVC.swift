//
//  SettingsVC.swift
//  Forbrands
//
//  Created by osamaaassi on 05/08/2021.
//

import UIKit

class SettingsVC: SuperViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setTitle(" ".localized, sender: self, large: false)
        navgtion.setCustomBackButtonForViewController(sender: self)
    }

    @IBAction func tapSettings(_ sender: UIButton) {
        //Password
        if(sender.tag == 0){
            let vc:ChangePasswordVC = ChangePasswordVC.loadFromNib()
            vc.hidesBottomBarWhenPushed = true
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
         }
        //Language
        if(sender.tag == 1){
            let vc:ChangeLanguageVC = ChangeLanguageVC.loadFromNib()
            vc.hidesBottomBarWhenPushed = true
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        //Edit Profile
        if(sender.tag == 2){
            var vc = UIViewController()
            if(CurrentUser.typeSelect == userType.User){
                vc = ProfileVC.loadFromNib()
                
            }else{
                vc = ProfileSellerVC.loadFromNib()
            }
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
        
        //Terms and Conditions
        if(sender.tag == 3){
            let vc:TermsAndConditionsVC = TermsAndConditionsVC.loadFromNib()
            vc.hidesBottomBarWhenPushed = true
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        //Privacy Policy
        if(sender.tag == 4){
            let vc:PrivacyPolicyVC = PrivacyPolicyVC.loadFromNib()
            vc.hidesBottomBarWhenPushed = true
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        
    }

}
