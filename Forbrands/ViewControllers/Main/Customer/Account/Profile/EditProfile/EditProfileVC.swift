//
//  EditProfileVC.swift
//  Forbrands
//
//  Created by osamaaassi on 05/08/2021.
//

import UIKit

class EditProfileVC: SuperViewController {

    @IBOutlet weak var lblFullName: UITextField!
    @IBOutlet weak var lblMobile:   UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        // Do any additional setup after loading the view.
    }
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setTitle(" ".localized, sender: self, large: false)
        navgtion.setCustomBackButtonForViewController(sender: self)
    }


    @IBAction func tapSave(_ sender: UIButton) {
      
    }

}
