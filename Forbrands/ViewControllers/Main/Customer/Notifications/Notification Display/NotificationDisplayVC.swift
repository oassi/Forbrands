//
//  NotificationDisplayVC.swift
//  Forbrands
//
//  Created by osamaaassi on 06/08/2021.
//

import UIKit

class NotificationDisplayVC: SuperViewController {
    
    @IBOutlet weak var lblPromocode:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        // Do any additional setup after loading the view.
    }

    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setTitle(" ", sender: self, large: false)
        navgtion.setCustomBackButtonForViewController(sender: self, isWhite: false)
       // navgtion.setCustomBackButtonForViewController(sender: self)
    }
    
    @IBAction func tapCopyText(_ sender: UIButton) {
        UIPasteboard.general.string = lblPromocode.text
        
        if let myString = UIPasteboard.general.string {
            self.showAlert(title: "successful".localized, message:"Promc Code :\(myString)")
        }
       

    }

}
