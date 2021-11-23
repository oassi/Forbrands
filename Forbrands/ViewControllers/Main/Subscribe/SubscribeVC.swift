//
//  SubscribeVC.swift
//  Forbrands
//
//  Created by osamaaassi on 13/08/2021.
//

import UIKit

class SubscribeVC: SuperViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        // Do any additional setup after loading the view.
    }
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
    }

    @IBAction func tapSubscribe(_ sender: UIButton) {
        let vc:PaymentMethodVC =  PaymentMethodVC.loadFromNib()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
   

}
