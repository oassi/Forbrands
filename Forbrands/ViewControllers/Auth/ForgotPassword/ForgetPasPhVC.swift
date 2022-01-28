//
//  ForgetPasPhVC.swift
//  Forbrands
//
//  Created by Osama Abu Assi on 27/01/2022.
//

import UIKit
import FlagPhoneNumber

class ForgetPasPhVC: SuperViewController,UITextFieldDelegate {

    
    @IBOutlet weak var phoneTF:FPNTextField!

    var isValidPhone = false
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            phoneTF.semanticContentAttribute = .forceLeftToRight
            phoneTF.textAlignment = NSTextAlignment.left;
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        
        // Do any additional setup after loading the view.
       
        phoneTF.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        setupPhoneTF()
        fpnDidSelectCountry(name: "SA", dialCode: "+966", code: "SA")

    }
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    //MARK: - setupPhoneTF
    func setupPhoneTF(){
        isValidPhone = false
        phoneTF.delegate = self
        phoneTF.textAlignment = .left
       

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
  
    
    
    @IBAction func bt_Virifcation(_ sender : UIButton) {
        guard isValidPhone else{
            self.showAlert(title: "".localized, message: "Please enter phone number".localized)

            return
        }
        guard let phone = phoneTF.text, !phone.isEmpty else {
            self.showAlert(title: "".localized, message: "Please enter phone number".localized)
            return
        }
        
        let num = phoneTF.getRawPhoneNumber()
     //   let fullNum = (phoneTF.selectedCountry?.phoneCode ?? "+996")! + num!
        
        let vc:PhoneVerificationCode = PhoneVerificationCode.loadFromNib()
        vc.phonNumber = num
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

}

//MARK: - asVisitor Button
extension ForgetPasPhVC: FPNTextFieldDelegate{
   
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        print(name, dialCode, code)
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        
        self.isValidPhone = isValid
        textField.getFormattedPhoneNumber(format: .RFC3966)
    }
    
    func fpnDisplayCountryList() {
    }
    
}

