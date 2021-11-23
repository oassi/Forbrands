//
//  PrivacyPolicyVC.swift
//  Forbrands
//
//  Created by osamaaassi on 04/08/2021.
//

import UIKit

class PrivacyPolicyVC: SuperViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setTitle("Privacy Policy".localized, sender: self, large: false)
        navgtion.setCustomBackButtonForViewController(sender: self)
    }


    @IBAction func tapToBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   

}
