//
//  AddAddressVC.swift
//  Forbrands
//
//  Created by osamaaassi on 05/08/2021.
//

import UIKit
import ActionSheetPicker_3_0
import FlagPhoneNumber
class AddAddressVC: SuperViewController {

    @IBOutlet weak var lblFullName:      UITextField!
    @IBOutlet weak var lblStreet:        UITextField!
    @IBOutlet weak var lblGovernorate:   UITextField!
    @IBOutlet weak var lblCity:          UITextField!
    @IBOutlet weak var lblBuilding:      UITextField!
    @IBOutlet weak var lblFloor:         UITextField!
    @IBOutlet weak var lblApartment:     UITextField!
    @IBOutlet weak var lblSpecialMarque: UITextField!
    @IBOutlet weak var phoneTF:FPNTextField!
    @IBOutlet weak var anotherMobileTF:FPNTextField!
    
    
    var statesList = [StatesList]()
    var citiesList = [StatesList]()
    var selectedGovernorateID:Int?
    var selectedCityID:Int?
    
    var addressInfo : AddressList?
    var isEdit = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGovernorate()
        addressEdit()
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
        navgtion.setTitle("Add Address".localized, sender: self, large: false)
        
        phoneTF.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        anotherMobileTF.addTarget(self, action: #selector(self.textFieldDidChangeanth(_:)), for: .editingChanged)
        
        setupPhoneTF(phoneTF)
        setupPhoneTF(anotherMobileTF)
        
        fpnDidSelectCountry(name: "SA", dialCode: "+966", code: "SA")
        
    }

    func addressEdit() {
        if(isEdit){
            phoneTF.text = addressInfo?.phone ?? ""
            anotherMobileTF.text = addressInfo?.phoneEx ?? ""
            lblFullName.text = addressInfo?.fullName ?? ""
            lblStreet.text = addressInfo?.street ?? ""
            lblGovernorate.text = addressInfo?.stateName ?? ""
            lblCity.text = addressInfo?.cityName ?? ""
            lblBuilding.text = addressInfo?.building?.description ?? ""
            lblFloor.text = addressInfo?.floor?.description ?? ""
            lblApartment.text = addressInfo?.apartment?.description ?? ""
            lblSpecialMarque.text = addressInfo?.specialMark ?? ""
            
            selectedGovernorateID = addressInfo?.stateId
            selectedCityID = addressInfo?.cityId
        }
    }
    //MARK: - setupPhoneTF
    func setupPhoneTF(_ textField : FPNTextField){
        textField.delegate = self
        textField.textAlignment = .left
        textField.setFlag(key: .SA)
        textField.selectedCountry?.code = .SA
        textField.setCountries(including: [.SA])
        textField.hasPhoneNumberExample = true
    }
    
    //MARK: - Did Change PhoneTF
    @objc func textFieldDidChange(_ textField: UITextField) {
        phoneTF.set(phoneNumber: textField.text ?? "")
        
    }
    @objc func textFieldDidChangeanth(_ textField: UITextField) {
        anotherMobileTF.set(phoneNumber: textField.text ?? "")
    }
    
    @IBAction func tapSave(_ sender: UIButton) {
        authAddAddress()
    }
    func authAddAddress(){
      
        guard let fullName = self.lblFullName.text, !fullName.isEmpty else{
            self.showAlert(title: "Error".localized, message: "The name cannot be empty".localized)
            lblFullName.becomeFirstResponder()
            return
        }

        guard let phone = phoneTF.text, !phone.isEmpty, phone.count == 11 else {
            self.showAlert(title: "".localized, message: "Please enter phone number".localized)
            return
        }
       
        guard let street = self.lblStreet.text, !street.isEmpty else{
            self.showAlert(title: "Error".localized, message: "Street cannot be empty".localized)
            lblStreet.becomeFirstResponder()
            return
        }
        
        guard (selectedGovernorateID != nil) else {
            showAlert(title: "", message: "Please select Governorate in first".localized)
            return
        }
        guard (selectedCityID != nil) else {
            showAlert(title: "", message: "Please select City".localized)
            return
        }
        
        let num = phoneTF.getRawPhoneNumber()
        let fullNum = (phoneTF.selectedCountry?.phoneCode ?? "+996")! + num!
        
        var parameters: [String: String] = [:]
        parameters["full_name"] =    fullName
        parameters["phone"] =        num
        parameters["street"] =       street
        parameters["state_id"] =     selectedGovernorateID!.description
        parameters["city_id"] =      selectedCityID!.description
        
        if(lblBuilding.text != nil && !(lblBuilding.text?.isEmpty ?? false)){
            parameters["building"] =  lblBuilding.text ?? "0"
        }else{
            parameters["building"] = "0"
        }
        
        if(lblFloor.text != nil && !(lblFloor.text?.isEmpty ?? false)){
            parameters["floor"] = lblFloor.text ?? "0"
        }else{
            parameters["floor"] = "0"
        }
        
        if(lblApartment.text != nil && !(lblApartment.text?.isEmpty ?? false)){
            parameters["apartment"] = lblApartment.text ?? "0"
        }else{
            parameters["apartment"] = "0"
        }
        if(lblSpecialMarque.text != nil && !(lblSpecialMarque.text?.isEmpty ?? false)){
            parameters["special_mark"] = lblSpecialMarque.text ?? "not found".localized
        }else{
            parameters["special_mark"] = "not found".localized
        }
      
        if(anotherMobileTF.text != nil && anotherMobileTF.text?.count == 11){
            let another = anotherMobileTF.getRawPhoneNumber()
            let anotherMobile = (anotherMobileTF.selectedCountry?.phoneCode ?? "+996")! + another!
            parameters["phone_ex"] = another
        }
        if(isEdit){
            editAddress(parameters, addressInfo!.id?.description ?? "0")
        }else{
            addAddAddress(parameters)
        }
      
    }
    func addAddAddress(_ parameters: [String:String]){
            _ = WebRequests.setup(controller: self).prepare(api: Endpoint.addAddress,parameters: parameters ,isAuthRequired:  true).start(){ (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<AddressList>.self, from: response.data!)
                guard Status.code == 200 else{
                    self.showAlert(title: Status.title ?? Status.errors?.first ?? "", message: Status.message ??  "")
                    return
                }
                self.showAlert(title: "", message: Status.message ?? "")
                self.navigationController?.popViewController(animated: true)
                
            }catch let jsonErr {
                print("Error serializing respone json", jsonErr)
            }
        }
    }
    
    func editAddress(_ parameters: [String:String], _ id:String){
            _ = WebRequests.setup(controller: self).prepare(api: Endpoint.editAddress,nestedParams: id,parameters: parameters ,isAuthRequired:  true).start(){ (response, error) in
            do {
                let Status =  try JSONDecoder().decode(StatusAddressEdit.self, from: response.data!)
                guard Status.code == 200 else{
                    self.showAlert(title: Status.title ?? "", message: Status.message ?? "")
                    return
                }
                
                self.showAlert(title: "", message: Status.message ?? "")
                self.navigationController?.popViewController(animated: true)
                
            }catch let jsonErr {
                print("Error serializing respone json", jsonErr)
            }
        }
    }
    
    func getGovernorate(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.statesList ,isAuthRequired:  false).start(){  (response, error) in
            do {
                
                let Status =  try JSONDecoder().decode(BaseDataArrayResponse<StatesList>.self, from: response.data!)
                
                if Status.code == 200{
                    guard Status.data?.count != 0 else {
                        return
                    }
                    self.statesList += Status.data!
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    func getCities(_ id:String){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.citiesByStates,nestedParams: id ,isAuthRequired:  false).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataArrayResponse<StatesList>.self, from: response.data!)
                
                if Status.code == 200{
                    guard Status.data?.count != 0 else {
                        return
                    }
                    self.citiesList.removeAll()
                    self.citiesList += Status.data!
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }

    @IBAction func tapGovernorate(_ sender: UIButton) {
        guard !statesList.isEmpty else {
            showAlert(title: "", message: "There are no Governorates".localized)
            return
        }
        self.selectedGovernorateID = statesList.first?.id ?? nil
        self.lblGovernorate.text = statesList.first?.name ?? ""
        self.getCities(self.selectedGovernorateID!.description)
        
        self.selectedCityID = nil
        self.lblCity.text = ""
        ActionSheetStringPicker.show(withTitle: self.lblGovernorate.text ?? "Governorate".localized, rows: self.statesList.map { $0.name as Any }
            , initialSelection: 0, doneBlock: {
                picker, value, index in
                if let Value = index {
                    self.lblGovernorate.text = Value as? String
                    self.selectedGovernorateID = self.statesList[value].id ?? 0
                    self.getCities(self.selectedGovernorateID!.description)
                }
                return
        }, cancel: { ActionStringCancelBlock in return }, origin: sender)
        
    }
    @IBAction func tapCity(_ sender: UIButton) {
        guard (selectedGovernorateID != nil) else {
            showAlert(title: "", message: "Please select Governorate in first".localized)
            return
        }
        guard !citiesList.isEmpty else {
            showAlert(title: "", message: "There are no cities".localized)
            return
        }
        self.selectedCityID = citiesList.first?.id ?? 0
        self.lblCity.text = citiesList.first?.name ?? ""
        
        ActionSheetStringPicker.show(withTitle: self.lblCity.text ?? "City".localized, rows: self.citiesList.map { $0.name as Any }
            , initialSelection: 0, doneBlock: {
                picker, value, index in
                if let Value = index {
                    self.lblCity.text = Value as? String
                    self.selectedCityID = self.citiesList[value].id ?? 0
                }
                return
        }, cancel: { ActionStringCancelBlock in return }, origin: sender)

    }
    
   

}


//MARK: - asVisitor Button
extension AddAddressVC: FPNTextFieldDelegate{
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        print(name, dialCode, code)
    }
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        
        textField.getFormattedPhoneNumber(format: .RFC3966)
    }
    
    func fpnDisplayCountryList() {
    }
    
}
