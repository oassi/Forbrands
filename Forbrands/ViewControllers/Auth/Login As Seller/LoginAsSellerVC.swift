//
//  LoginAsSellerVC.swift
//  Forbrands
//
//  Created by osamaaassi on 09/08/2021.
//

import UIKit
import VKPinCodeView
class LoginAsSellerVC: SuperViewController {

    @IBOutlet weak var lblFullName: UITextField!
    @IBOutlet weak var lblPhone: VKPinCodeView!
    @IBOutlet weak var lblEmail: UITextField!
    @IBOutlet weak var lblPassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        lblFullName.delegate = self
        lblEmail.delegate = self
        lblPassword.delegate = self
        // Do any additional setup after loading the view.
    }
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
    }
    
    @IBAction func isHidePassword(_ sender: UIButton) {
        hidePass(lblPassword)
    }
    
    private func hidePass(_ sender: UITextField){
        if(sender.isSecureTextEntry){
            sender.isSecureTextEntry = false
        }
        else{
            sender.isSecureTextEntry = true
        }
    }
    
    private func textFieldDelegate(){
        lblPassword.delegate = self
        lblFullName.delegate = self
    }
    
    
    @IBAction func tapConfirm(_ sender: Any) {
        let vc:VerificationVC = VerificationVC.loadFromNib()
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        vc.isSeller = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
extension LoginAsSellerVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == lblFullName){
            lblEmail.becomeFirstResponder()
        }else if (textField == lblEmail){
            lblPassword.becomeFirstResponder()
        }
        return true
    }
    
}
