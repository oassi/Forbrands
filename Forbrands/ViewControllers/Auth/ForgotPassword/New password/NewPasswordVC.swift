//
//  NewPasswordVC.swift
//  Forbrands
//
//  Created by Osama Abu Assi on 27/01/2022.
//

import UIKit

class NewPasswordVC : SuperViewController {

    @IBOutlet weak var lblPassword: UITextField!
    @IBOutlet weak var lblConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
    @IBAction func isHidePassword(_ sender: UIButton) {
        hidePass(lblPassword)
    }
    @IBAction func isHideConfirmPassword(_ sender: UIButton) {
        hidePass(lblConfirmPassword)
    }
    private func hidePass(_ sender: UITextField){
        if(sender.isSecureTextEntry){
            sender.isSecureTextEntry = false
        }
        else{
            sender.isSecureTextEntry = true
        }
    }
    
    @IBAction func tapConfirm(_ sender: Any) {
        view.endEditing(true)
        
        guard let password = self.lblPassword.text, !password.isEmpty else{
            self.showAlert(title: "Error".localized, message: "Password cannot be empty".localized)
            return
        }
        
        if password.count < 6 {
            showAlert(title: "Error".localized, message: "Password must be at least 6 characters long".localized)
            return
        }
        
        guard let ConfirmPassword = self.lblConfirmPassword.text, !ConfirmPassword.isEmpty else{
            self.showAlert(title: "Error".localized, message: "Confirm password cannot be empty".localized)
            return
        }
        
        guard  password == ConfirmPassword else{
            self.showAlert(title: "Error".localized, message: "Password does not match".localized)
            return
        }
        
        var parameters: [String: Any] = [:]
        parameters["new_password"] =  password
        parameters["confirm_password"] =  ConfirmPassword
        
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.changepassword,parameters: parameters ,isAuthRequired:true).start(){ (response, error) in
            do {
                let Status =  try JSONDecoder().decode(StatusStruct.self, from: response.data!)
                
                guard Status.code == 200 else{
                    //self.showAlert(title: "Error".localized, message: Status.message ?? "")
                    return
                }
                self.showAlert(title: Status.title ?? "", message: Status.message ?? "")
                WebRequests.tokenApiPassword = ""
                self.navigationController?.popToRootViewController(animated: true)
                
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
       
        
    }

}
