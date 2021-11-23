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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgAr.isHidden = true
        // Do any additional setup after loading the view.
        
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
    }


    @IBAction func checkLanguage(_ sender: UIButton) {
        if(sender.tag == 0){
            imgEn.isHidden = false
            imgAr.isHidden = true
        }
        if(sender.tag == 1){
            imgEn.isHidden = true
            imgAr.isHidden = false
        }
        
    }
    
    @IBAction func tapSave(_ sender: UIButton) {
        
    }

}
