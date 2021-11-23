//
//  TermsAndConditionsVC.swift
//  Forbrands
//
//  Created by osamaaassi on 07/08/2021.
//

import UIKit

class TermsAndConditionsVC: SuperViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setTitle("Terms And Conditions".localized, sender: self, large: false)
        navgtion.setCustomBackButtonForViewController(sender: self)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
