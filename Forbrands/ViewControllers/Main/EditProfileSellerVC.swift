//
//  EditProfileSellerVC.swift
//  Forbrands
//
//  Created by osamaaassi on 13/08/2021.
//

import UIKit
import FlagPhoneNumber
class EditProfileSellerVC: SuperViewController,UITextFieldDelegate {
    
    @IBOutlet var lblFullName : UITextField!
    @IBOutlet var lblEmail    : UITextField!
    
    @IBOutlet weak var phoneTF:FPNTextField!
    @IBOutlet weak var saveButton: UIButton!
    var isValidPhone = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        getUserProfile()
        changBackgroundColorButApp(saveButton)
        // Do any additional setup after loading the view.
        phoneTF.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        setupPhoneTF()
        fpnDidSelectCountry(name: "SA", dialCode: "+966", code: "SA")
        
    }
    
    
   
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
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
        if let email = lblEmail.text, !email.isEmpty {
            parameters["email"] = email
        }
        guard isValidPhone else{
            self.showAlert(title: "".localized, message: "Please enter phone number".localized)
            return
        }
        
        if(phoneTF.text != nil && phoneTF.text?.count == 11){
            let another = phoneTF.getRawPhoneNumber()
            let anotherMobile = (phoneTF.selectedCountry?.phoneCode ?? "+996")! + another!
            parameters["phone"] = anotherMobile
        }
        
        editProfile(parameters)
    }
    
    func getUserProfile(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.userProfile ,isAuthRequired:  true).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<UserStruct>.self, from: response.data!)
                
                guard Status.code == 200 else{
                    self.showAlert(title: Status.title ?? "", message: Status.message ?? "")
                    return
                }
                self.lblFullName.text = Status.data?.name ?? ""
                self.lblEmail.text =  Status.data?.email ?? ""
                self.phoneTF.set(phoneNumber: Status.data?.phone! ?? "")
                
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    func editProfile(_ parameters: [String:String]){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.editProfile,parameters: parameters ,isAuthRequired:  false).start(){ (response, error) in
            
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<UserStruct>.self, from: response.data!)
                guard Status.code == 200 else{
                    self.showAlert(title: Status.title ?? "", message: Status.message ?? "")
                    return
                }
                self.navigationController?.popViewController(animated: true)
                
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
}





//MARK: - asVisitor Button
extension EditProfileSellerVC: FPNTextFieldDelegate{
    
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
