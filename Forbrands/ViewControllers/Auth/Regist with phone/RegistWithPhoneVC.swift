//
//  RegistWithPhoneVC.swift
//  Forbrands
//
//  Created by osamaaassi on 04/08/2021.
//

import UIKit

class RegistWithPhoneVC: SuperViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }

   
    @IBAction func bt_Virifcation(_ sender : UIButton) {
        let vc:VerificationVC = VerificationVC.loadFromNib()
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

}
