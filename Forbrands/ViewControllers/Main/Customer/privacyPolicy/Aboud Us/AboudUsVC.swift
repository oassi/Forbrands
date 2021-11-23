//
//  AboudUsVC.swift
//  Forbrands
//
//  Created by osamaaassi on 07/08/2021.
//

import UIKit

class AboudUsVC: SuperViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setTitle("About us".localized, sender: self, large: false)
        navgtion.setCustomBackButtonForViewController(sender: self)
    }

}
