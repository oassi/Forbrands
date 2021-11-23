//
//  EditStoreInformationVC.swift
//  Forbrands
//
//  Created by osamaaassi on 13/08/2021.
//

import UIKit

class EditStoreInformationVC: SuperViewController {

    @IBOutlet var lblStoreName  : UITextField!
    @IBOutlet var lblStoreLink  : UITextField!
    @IBOutlet var lblCommercial : UITextField!
    @IBOutlet var lblIban       : UITextField!
    
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
