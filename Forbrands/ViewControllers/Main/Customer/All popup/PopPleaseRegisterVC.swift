//
//  PopPleaseRegisterVC.swift
//  Forbrands
//
//  Created by osamaaassi on 14/08/2021.
//

import UIKit

class PopPleaseRegisterVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func tapSignIn (_ sender : UIButton){
        let vc = LoginVC.loadFromNib().navigationController()
        vc.modalPresentationStyle = .fullScreen
        self.goToRoot(vc)
    }

}
