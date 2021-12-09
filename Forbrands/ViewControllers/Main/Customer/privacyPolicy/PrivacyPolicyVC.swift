//
//  PrivacyPolicyVC.swift
//  Forbrands
//
//  Created by osamaaassi on 04/08/2021.
//

import UIKit

class PrivacyPolicyVC: SuperViewController {
    @IBOutlet weak var tfPrivacyPolicy:UITextView!
    @IBOutlet weak var saveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        getPrivacyPolicy()
        // Do any additional setup after loading the view.
        if(CurrentUser.typeSelect == userType.Seller){
            changBackgroundColorButApp(saveButton)
        }
    }

    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setTitle("Privacy Policy".localized, sender: self, large: false)
        navgtion.setCustomBackButtonForViewController(sender: self)
    }
    
    @IBAction func tapToBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func getPrivacyPolicy() {
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.privacyPolicy,isAuthRequired:  false).start(){ (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<AboutApp>.self, from: response.data!)
                if Status.code != 200{
                    return
                }
                else{
                    self.tfPrivacyPolicy.text = Status.data?.valueInfo ?? ""
                    self.tfPrivacyPolicy.textAlignment = .justified
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
    
    
   

}
