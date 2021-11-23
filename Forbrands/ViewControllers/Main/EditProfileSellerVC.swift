//
//  EditProfileSellerVC.swift
//  Forbrands
//
//  Created by osamaaassi on 13/08/2021.
//

import UIKit

class EditProfileSellerVC: SuperViewController {

    @IBOutlet var lblFullName : UITextField!
    @IBOutlet var lblMobile   : UITextField!
    @IBOutlet var lblEmail    : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        // Do any additional setup after loading the view.
    }
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
    }

    @IBAction func tapSave(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
