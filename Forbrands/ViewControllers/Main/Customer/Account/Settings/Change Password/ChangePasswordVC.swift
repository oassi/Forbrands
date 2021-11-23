//
//  ChangePasswordVC.swift
//  Forbrands
//
//  Created by osamaaassi on 05/08/2021.
//

import UIKit

class ChangePasswordVC: SuperViewController {

    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        oldPassword.delegate = self
        newPassword.delegate = self
        // Do any additional setup after loading the view.
        
        
    }
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
        navgtion.setTitle("".localized, sender: self, large: false)
    }
    @IBAction func tapSave(_ sender: UIButton) {
        ChangePassword()
    }

     private func ChangePassword() {
        
    }
    
    @IBAction func isHideOld(_ sender: UIButton) {
        if(sender.tag == 0){
            hidePass(oldPassword)
        }
        if(sender.tag == 1){
            hidePass(newPassword)
        }
    }
    
    private func hidePass(_ sender: UITextField){
        if(sender.isSecureTextEntry){
            sender.isSecureTextEntry = false
        }
        else{
            sender.isSecureTextEntry = true
        }
    }
}

extension ChangePasswordVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == oldPassword){
            newPassword.becomeFirstResponder()
        }
        if(textField == newPassword){
            ChangePassword()
        }
        return true
    }
}
