//
//  ChangeLanguageVC.swift
//  Forbrands
//
//  Created by osamaaassi on 05/08/2021.
//

import UIKit

class ChangeLanguageVC: SuperViewController {
    
    @IBOutlet weak var imgEn: UIImageView!
    @IBOutlet weak var imgAr: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if(MOLHLanguage.isArabic() ){
            imgAr.isHidden = false
            imgEn.isHidden = true
           
        }else{
            imgAr.isHidden = true
            imgEn.isHidden = false
        }
        // Do any additional setup after loading the view.
        if(CurrentUser.typeSelect == userType.Seller){
            changBackgroundColorButApp(saveButton)
            imgEn.tintColor = getColorApp()
            imgAr.tintColor = getColorApp()
            
        }
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
    }


    @IBAction func checkLanguage(_ sender: UIButton) {
        if(sender.tag == 0){
            imgEn.isHidden = false
            imgAr.isHidden = true
            MOLH.setLanguageTo("en")
            MOLH.reset(transition: .transitionCrossDissolve, duration: 0.25)
        }
        if(sender.tag == 1){
            imgEn.isHidden = true
            imgAr.isHidden = false
            MOLH.setLanguageTo("ar")
            MOLH.reset(transition: .transitionCrossDissolve, duration: 0.25)
        }
        
    }
    
    @IBAction func tapSave(_ sender: UIButton) {
        
    }

}

