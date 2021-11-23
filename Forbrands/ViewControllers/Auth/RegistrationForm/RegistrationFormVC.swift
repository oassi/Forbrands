//
//  RegistrationFormVC.swift
//  Forbrands
//
//  Created by osamaaassi on 05/08/2021.
//

import UIKit
import VKPinCodeView
class RegistrationFormVC: SuperViewController {

    @IBOutlet weak var lblNumber: VKPinCodeView!
    @IBOutlet weak var lblPassword: UITextField!
    @IBOutlet weak var lblFullName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldDelegate()
        // Do any additional setup after loading the view.
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
    }

    
    private func textFieldDelegate(){
        lblPassword.delegate = self
        lblFullName.delegate = self
    }

    @IBAction func tapConfirm(_ sender: Any) {
        
    }

}
extension RegistrationFormVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == lblPassword){
            lblFullName.becomeFirstResponder()
        }else if (textField == lblFullName){
            
        }
        return true
    }
    
}
