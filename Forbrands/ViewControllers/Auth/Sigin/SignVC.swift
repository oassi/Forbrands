//
//  SignVC.swift
//  Forbrands
//
//  Created by osamaaassi on 23/08/2021.
//

import UIKit
import FlagPhoneNumber
class SignVC: SuperViewController {
    
    @IBOutlet weak var phoneTF: FPNTextField!
    @IBOutlet weak var lblPassword: UITextField!
    
    var isValidPhone = false
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
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
    
    
    
    @IBAction func tapForgotPassword(_ sender: UIButton) {
        
        let vc:ForgetPasPhVC = ForgetPasPhVC.loadFromNib()
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func tapConfirm(_ sender: UIButton) {
        
        guard isValidPhone else{
            self.showAlert(title: "".localized, message: "Please enter phone number".localized)
            return
        }
        guard let phone = phoneTF.text, !phone.isEmpty else {
            self.showAlert(title: "".localized, message: "Please enter phone number".localized)
            return
        }
        guard let password = self.lblPassword.text, !password.isEmpty else{
            self.showAlert(title: "Error".localized, message: "Password cannot be empty".localized)
            return
        }
        
        guard  password.count >= 6 else{
            self.showAlert(title: "Error".localized, message: "Password must be at least 6 characters long".localized)
            return
        }
        
        
        let num = phoneTF.getRawPhoneNumber()
        let a = (phoneTF.selectedCountry?.phoneCode ?? "+996")! + num!.description
        var parameters: [String: Any] = [:]
        parameters["phone"] =    num!
        parameters["password"] =  password
        
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.login,parameters: parameters ,isAuthRequired:  false).start(){ (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<UserData>.self, from: response.data!)
                
                guard Status.code == 200 else{
                    self.showAlert(title: Status.title ?? "", message: Status.message ?? "")
                    return
                }
                
                CurrentUser.userInfo = Status.data
                CurrentUser.userTrader = Status.data?.store
                CurrentUser.typeSelect =  Status.data?.roleName == "Trader" ?  userType.Seller : userType.User
                
                if(Status.data?.roleName == "Trader" && Status.data?.store == nil  && CurrentUser.userTrader == nil){
                    DispatchQueue.main.async {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                            let vc = StoreInformationVC.loadFromNib().navigationController()
                            vc.modalPresentationStyle = .fullScreen
                            UserDefaults.standard.set(true, forKey: "isNotCompleteData")
                            
                            self.goToRoot(vc)
                        })}
                    
                }else{
                    if CurrentUser.typeSelect == userType.Seller{
                        let vc:AdvertiseWithUsVC = AdvertiseWithUsVC.loadFromNib()
                        vc.modalPresentationStyle = .fullScreen
                        vc.tabBarController?.navigationItem.hidesBackButton = true
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    else{
                        self.getCountCart()
                        DispatchQueue.main.async {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                                let vc = TTabBarController()
                                vc.modalPresentationStyle = .fullScreen
                                self.goToRoot(vc)
                            })}
                    }
                   
                }
                
                
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
        
    }
    
    func getCountCart(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.countCart ,isAuthRequired:  true).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<CartObj>.self, from: response.data!)
                
                guard Status.code == 200 else{
                    self.showAlert(title: "Error".localized, message: Status.message ?? "")
                    return
                }
                
                if(Status.data != nil){
                    UserDefaults.standard.set("\(Status.data?.count?.description ?? "0")", forKey: "countCart")
                    NotificationCenter.default.post(name: .didCartCount, object: nil)
                }
                
                
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
    
}


//MARK: - asVisitor Button
extension SignVC: FPNTextFieldDelegate{
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        print(name, dialCode, code)
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        self.isValidPhone = isValid
    }
    
    func fpnDisplayCountryList() {
    }
    
}
