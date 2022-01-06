//
//  EditStoreInformationVC.swift
//  Forbrands
//
//  Created by osamaaassi on 13/08/2021.
//

import UIKit

class EditStoreInformationVC: SuperViewController {

    @IBOutlet var lblStoreName  : UITextField!
    @IBOutlet var lblStoreLink  : UITextField!
    @IBOutlet var lblCommercial : UITextField!
    @IBOutlet var lblIban       : UITextField!
    @IBOutlet var storePolicy   : UITextView!
    @IBOutlet weak var lblStoreDetails: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var optionColor: UILabel!
    @IBOutlet weak var optionColor2: UILabel!
    var storeData : StoreTrader?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        setupStoreInformation()
        lblStoreDetails.placeholder = "Store Details".localized
        changBackgroundColorButApp(saveButton)
        optionColor.textColor = getColorApp()
        optionColor2.textColor = getColorApp()
        // Do any additional setup after loading the view.
    }

    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
    }
    func setupStoreInformation(){
        lblStoreName.text = storeData?.name ?? ""
        lblStoreDetails.text = storeData?.detail ?? ""
        lblStoreLink.text = storeData?.maroofLink ?? ""
        lblCommercial.text = storeData?.commercialRecord ?? ""
        lblIban.text = storeData?.iban ?? ""
        storePolicy.text = storeData?.storePolicy ?? ""
    }
   
    
    
    @IBAction func tapSave(_ sender: Any) {
       
        var parameters: [String: String] = [:]
        if let storeName = lblStoreName.text, !storeName.isEmpty {
            parameters["name"] = storeName
        }
        if let storeLink = lblStoreLink.text, !storeLink.isEmpty {
            parameters["maroof_link"] = storeLink
        }
        if let storeDetails = lblStoreDetails.text, !storeDetails.isEmpty {
            parameters["detail"] = storeDetails
        }
        if let commercial = lblCommercial.text, !commercial.isEmpty {
            parameters["commercial_record"] = commercial
        }
        if let iban = lblIban.text, !iban.isEmpty {
            parameters["iban"] = iban
        }
        if let storePolicy = storePolicy.text, !storePolicy.isEmpty {
            parameters["store_policy"] = storePolicy
        }

        
        let id = CurrentUser.userTrader?.id?.description ?? "0"
        editStore(parameters,id)
    }
    
    func editStore(_ parameters: [String:String], _ id:String){
            _ = WebRequests.setup(controller: self).prepare(api: Endpoint.editStoresInfo,nestedParams: id,parameters: parameters ,isAuthRequired:  true).start(){ (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<StoreTrader>.self, from: response.data!)
                if Status.code == 200{
                    CurrentUser.userTrader = Status.data
                    self.navigationController?.popViewController(animated: true)
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }

}
