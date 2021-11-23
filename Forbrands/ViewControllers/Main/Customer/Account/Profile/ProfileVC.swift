//
//  ProfileVC.swift
//  Forbrands
//
//  Created by osamaaassi on 05/08/2021.
//

import UIKit

class ProfileVC: SuperViewController {

    
    @IBOutlet weak var lblFullName: UITextField!
    @IBOutlet weak var lblMobile:   UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
    }

    
    @IBAction func tapEdit(_ sender: UIButton) {
            let vc:EditProfileVC = EditProfileVC.loadFromNib()
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
       
    }
    
    @IBAction func tapEditImgProfile(_ sender: UIButton) {
        
    }

}
