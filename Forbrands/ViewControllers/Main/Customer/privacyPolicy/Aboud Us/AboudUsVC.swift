//
//  AboudUsVC.swift
//  Forbrands
//
//  Created by osamaaassi on 07/08/2021.
//

import UIKit

class AboudUsVC: SuperViewController {

    @IBOutlet weak var tfAbout:UITextView!
    @IBOutlet weak var saveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAboutUs()
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
        navgtion.setTitle("About us".localized, sender: self, large: false)
        navgtion.setCustomBackButtonForViewController(sender: self)
    }
    @IBAction func tapToBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func getAboutUs() {
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.aboutApp,isAuthRequired:  false).start(){ (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<AboutApp>.self, from: response.data!)
                if Status.code != 200{
                    return
                }
                else{
                    self.tfAbout.text = Status.data?.valueInfo ?? ""
                    self.tfAbout.textAlignment = .justified
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }

    }

}
