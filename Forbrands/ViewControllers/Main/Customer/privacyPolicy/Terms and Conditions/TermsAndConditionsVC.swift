//
//  TermsAndConditionsVC.swift
//  Forbrands
//
//  Created by osamaaassi on 07/08/2021.
//

import UIKit

class TermsAndConditionsVC: SuperViewController {

    @IBOutlet weak var tfTermsAndConditions:UITextView!
    @IBOutlet weak var saveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        getTermsAndConditions()
        // Do any additional setup after loading the view.
        if(CurrentUser.typeSelect == userType.Seller){
            changBackgroundColorButApp(saveButton)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        navButtons()
    }
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setTitle("Terms And Conditions".localized, sender: self, large: false)
        navgtion.setCustomBackButtonForViewController(sender: self)
        navigationController?.navigationBar.tintColor = getColorApp()
    }
    
    
    func getTermsAndConditions() {
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.conditions,isAuthRequired:  false).start(){ (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<AboutApp>.self, from: response.data!)
                if Status.code != 200{
                    return
                }
                else{
                    self.tfTermsAndConditions.text = Status.data?.valueInfo ?? ""
                    self.tfTermsAndConditions.textAlignment = .justified
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
    @IBAction func tapToBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
