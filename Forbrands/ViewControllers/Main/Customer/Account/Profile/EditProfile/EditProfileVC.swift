//
//  EditProfileVC.swift
//  Forbrands
//
//  Created by osamaaassi on 05/08/2021.
//

import UIKit
import FlagPhoneNumber

class EditProfileVC: SuperViewController,UITextFieldDelegate {

    @IBOutlet weak var lblFullName: UITextField!
    @IBOutlet weak var phoneTF:FPNTextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    var phone : String?
    var name : String?
    
    var isValidPhone = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        // Do any additional setup after loading the view.
        phoneTF.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        setupPhoneTF()
        phoneTF.set(phoneNumber: phone ?? "")
        lblFullName.text = name ?? ""
        
        fpnDidSelectCountry(name: "SA", dialCode: "+966", code: "SA")
    }
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setTitle(" ".localized, sender: self, large: false)
        navgtion.setCustomBackButtonForViewController(sender: self)
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
    

    @IBAction func tapSave(_ sender: UIButton) {
        
        var parameters: [String: String] = [:]
        if let fullName = lblFullName.text, !fullName.isEmpty {
            parameters["name"] = fullName
        }
        guard isValidPhone else{
            self.showAlert(title: "".localized, message: "Please enter phone number".localized)
            return
        }
        if(phoneTF.text != nil && phoneTF.text?.count == 11){
            let another = phoneTF.getRawPhoneNumber()
            let mobile = (phoneTF.selectedCountry?.phoneCode ?? "+996")! + another!
            parameters["phone"] = mobile
        }
        parameters["email"] = CurrentUser.userInfo?.user?.email 
        editProfile(parameters)
    }
    func editProfile(_ parameters: [String:String]){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.editProfile,parameters: parameters ,isAuthRequired:  false).start(){ (response, error) in
            
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
}
//MARK: - asVisitor Button
extension EditProfileVC: FPNTextFieldDelegate{
   
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
