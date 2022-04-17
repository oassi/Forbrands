//
//  ConnectWithUsVC.swift
//  Forbrands
//
//  Created by osamaaassi on 05/08/2021.
//

import UIKit

class ConnectWithUsVC: SuperViewController {

    var contactUs : ContactUs?
    override func viewDidLoad() {
        super.viewDidLoad()
        getContactUs()
        navButtons()
        // Do any additional setup after loading the view.
    }

    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setTitle("Connect with us".localized, sender: self, large: false)
        navgtion.setCustomBackButtonForViewController(sender: self)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    @IBAction func tapConnect(_ sender: UIButton) {
        //Email
        if(sender.tag == 0){
            SocialNetworkUrl(scheme: "mailto:\(contactUs?.email?.valueLink ?? "")" , page: "mailto:\(contactUs?.email?.valueLink ?? "")").openPage()
         }
        //WhatsApp
        if(sender.tag == 1){
            SocialNetworkUrl(scheme: contactUs?.whatsapp?.valueLink ?? "", page: contactUs?.whatsapp?.valueLink ?? "").openPage()
        }
        //ConnectUs
        if(sender.tag == 2){
            let vc :ConnectUsVC = ConnectUsVC.loadFromNib()
             vc.modalPresentationStyle = .fullScreen
             vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
         
    }
    
    func getContactUs(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.contactUs ,isAuthRequired:  false).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<ContactUs>.self, from: response.data!)
                if Status.code == 200{
                    guard (Status.data != nil) else {
                        return
                    }
                    self.contactUs = Status.data!
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }

}
