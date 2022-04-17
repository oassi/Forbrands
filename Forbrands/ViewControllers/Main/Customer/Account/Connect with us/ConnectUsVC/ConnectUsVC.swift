//
//  ConnectUsVC.swift
//  Forbrands
//
//  Created by osamaaassi on 01/12/2021.
//

import UIKit

class ConnectUsVC: SuperViewController {
    
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var messageTF: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        nameTf.text = CurrentUser.userInfo?.user?.name ?? ""
        emailTf.text = CurrentUser.userInfo?.user?.email ?? ""
        // Do any additional setup after loading the view.
        
        
    }
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setTitle("Connect with us".localized, sender: self, large: false)
        navgtion.setCustomBackButtonForViewController(sender: self)
    }
    
    func contactUs() {
        guard let message = messageTF.text, !message.isEmpty else {
            self.showAlert(title: "Error", message: "Cannot send an empty message".localized)
            messageTF.becomeFirstResponder()
            return
        }
        var parameters = [String : Any]()
        parameters["name"] = nameTf.text ?? ""
        parameters["email"] = emailTf.text ?? ""
        parameters["message"] = messageTF.text ?? ""
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.contactWithUs,parameters:parameters ,isAuthRequired: true).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<DataClass>.self, from: response.data!)
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



// MARK: Send Form Contact Us
@IBAction func saveButton(_ sender: UIButton) {
    contactUs()
}

@IBAction func backButton(_ sender: UIButton) {
    navigationController?.popViewController(animated: true)
}


}
