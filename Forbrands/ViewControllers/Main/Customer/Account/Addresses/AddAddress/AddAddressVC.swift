//
//  AddAddressVC.swift
//  Forbrands
//
//  Created by osamaaassi on 05/08/2021.
//

import UIKit

class AddAddressVC: SuperViewController {

    @IBOutlet weak var lblFullName:      UITextField!
    @IBOutlet weak var lblMobile:        UITextField!
    @IBOutlet weak var lblAnotherMobile: UITextField!
    @IBOutlet weak var lblStreet:        UITextField!
    @IBOutlet weak var lblGovernorate:   UITextField!
    @IBOutlet weak var lblCity:          UITextField!
    @IBOutlet weak var lblBuilding:      UITextField!
    @IBOutlet weak var lblFloor:         UITextField!
    @IBOutlet weak var lblApartment:     UITextField!
    @IBOutlet weak var lblSpecialMarque: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
        navgtion.setTitle("Add Address".localized, sender: self, large: false)
        
    }

    @IBAction func tapSave(_ sender: UIButton) {
        
    }
    @IBAction func tapGovernorate(_ sender: UIButton) {
        
    }
    @IBAction func tapCity(_ sender: UIButton) {
        
    }
    
   

}
