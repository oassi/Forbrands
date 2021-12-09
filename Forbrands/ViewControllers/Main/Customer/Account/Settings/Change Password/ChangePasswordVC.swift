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
    @IBOutlet weak var saveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        oldPassword.delegate = self
        newPassword.delegate = self
        
        if(CurrentUser.typeSelect == userType.Seller){
            changBackgroundColorButApp(saveButton)
        }
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
        var parameters: [String: String] = [:]
        if let oldPass = oldPassword.text, !oldPass.isEmpty {
            parameters["old_password"] = oldPass.stringByRemovingWhitespaces
        }
        if let newPass = newPassword.text, !newPass.isEmpty{
            parameters["new_password"] = newPass.stringByRemovingWhitespaces
        }
        if(CurrentUser.userInfo?.user?.phone != nil){
            let phon = CurrentUser.userInfo!.user!.phone
            parameters["phone"] = phon
        }
        
        changePassword(parameters)
    }
    
    func changePassword(_ parameters: [String:String]){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.editProfile,parameters: parameters ,isAuthRequired:  true).start(){ (response, error) in
            
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<UserStruct>.self, from: response.data!)
                if Status.code == 200{
                    self.navigationController?.popViewController(animated: true)
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
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


