//
//  ConnectWithUsVC.swift
//  Forbrands
//
//  Created by osamaaassi on 05/08/2021.
//

import UIKit

class ConnectWithUsVC: SuperViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setTitle("Connect with us".localized, sender: self, large: false)
        navgtion.setCustomBackButtonForViewController(sender: self)
    }


    @IBAction func tapConnect(_ sender: UIButton) {
        //Email
        if(sender.tag == 0){
//            let vc:MyOrdersVC = MyOrdersVC.loadFromNib()
//            vc.hidesBottomBarWhenPushed = true
//            vc.modalPresentationStyle = .fullScreen
//            self.navigationController?.pushViewController(vc, animated: true)
         }
        //WhatsApp
        if(sender.tag == 1){}
        

        
        
    }

}
