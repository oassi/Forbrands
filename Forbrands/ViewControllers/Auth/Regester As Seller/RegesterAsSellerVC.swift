//
//  RegesterAsSellerVC.swift
//  Forbrands
//
//  Created by osamaaassi on 09/08/2021.
//

import UIKit
import FlagPhoneNumber
class RegesterAsSellerVC: SuperViewController,UITextFieldDelegate {

    @IBOutlet weak var lblFullName: UITextField!
    @IBOutlet weak var lblEmail: UITextField!
    @IBOutlet weak var lblPassword: UITextField!
    
    @IBOutlet weak var phoneTF:FPNTextField!
    @IBOutlet weak var loginButton: UIButton!
    var isValidPhone = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        lblFullName.delegate = self
        lblEmail.delegate = self
        lblPassword.delegate = self
        // Do any additional setup after loading the view.
        
        phoneTF.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        setupPhoneTF()
        fpnDidSelectCountry(name: "SA", dialCode: "+966", code: "SA")
    }
    //MARK: - setupPhoneTF
    func setupPhoneTF(){
        isValidPhone = false
        phoneTF.delegate = self
        phoneTF.setFlag(key: .SA)
        phoneTF.selectedCountry?.code = .SA
        phoneTF.setCountries(including: [.SA])
        phoneTF.hasPhoneNumberExample = true
    }
    
    //MARK: - Did Change PhoneTF
    @objc func textFieldDidChange(_ textField: UITextField) {
        phoneTF.set(phoneNumber: textField.text ?? "")
    }
    
    //MARK: - toggle Login Button
 
    override func viewWillAppear(_ animated: Bool) {
        navButtons()
    }
    
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
        navigationController?.navigationBar.tintColor = getColorApp()
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
    
    @IBAction func tapSignIn(_ sender:UIButton) {
        let vc:SignVC = SignVC.loadFromNib()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapConfirm(_ sender: Any) {
//        let vc:StoreInformationVC = StoreInformationVC.loadFromNib()
//        vc.modalPresentationStyle = .fullScreen
//        self.navigationController?.pushViewController(vc, animated: true)
        
         guard let fullName = self.lblFullName.text, !fullName.isEmpty else{
            self.showAlert(title: "Error".localized, message: "Username cannot be empty".localized)
            return
        }
        guard isValidPhone else{
            self.showAlert(title: "".localized, message: "Please enter phone number".localized)
            
            return
        }
       
        guard let phone = phoneTF.text, !phone.isEmpty else {
            self.showAlert(title: "".localized, message: "Please enter phone number".localized)
            return
        }
        
        guard let email = self.lblEmail.text, !email.isEmpty else{
            self.showAlert(title: "Error".localized, message: "Email cannot be empty".localized)
            return
        }
        guard let password = self.lblPassword.text, !password.isEmpty else{
            self.showAlert(title: "Error".localized, message: "Password cannot be empty".localized)
            return
        }
        
        if password.count < 6 {
            showAlert(title: "Error".localized, message: "Password must be at least 6 characters long".localized)
            return
        }
        let num = phoneTF.getRawPhoneNumber()
       let fullNum = (phoneTF.selectedCountry?.phoneCode ?? "+996")! + num!
        
        var parameters: [String: Any] = [:]
        parameters["name"] =      fullName
        parameters["email"] =     email
        parameters["phone"] =    num
        parameters["password"] =  password
        parameters["role_id"] =   2
        
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.register,parameters: parameters ,isAuthRequired:  false).start(){ (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<UserData>.self, from: response.data!)
            
                if Status.code != 200{
                    return
                }
                else{
                    CurrentUser.userInfo = Status.data
                    let vc:VerificationVC = VerificationVC.loadFromNib()
                    vc.idUser = (Status.data!.user?.id?.description ?? "0")
                    vc.phonNumber = fullNum
                    vc.hidesBottomBarWhenPushed = true
                    vc.modalPresentationStyle = .fullScreen
                    vc.isSeller = true
                    self.navigationController?.pushViewController(vc, animated: true)

                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
    
}
extension RegesterAsSellerVC{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == lblFullName){
            lblEmail.becomeFirstResponder()
        }else if (textField == lblEmail){
            lblPassword.becomeFirstResponder()
        }
        return true
    }
    
}

//MARK: - asVisitor Button
extension RegesterAsSellerVC: FPNTextFieldDelegate{
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        print(name, dialCode, code)
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        self.isValidPhone = isValid
//        textField.getFormattedPhoneNumber(format: .RFC3966)
    }
    
    func fpnDisplayCountryList() {
    }
    
}
