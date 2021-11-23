//
//  OrderDetailsVC.swift
//  Forbrands
//
//  Created by osamaaassi on 16/08/2021.
//

import UIKit

class OrderDetailsVC: SuperViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        // Do any additional setup after loading the view.
    }

    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setTitle("Order details".localized, sender: self, large: false)
        navgtion.setCustomBackButtonForViewController(sender: self)
        navgtion.navigationBar.layer.masksToBounds = false
    }
  

}
