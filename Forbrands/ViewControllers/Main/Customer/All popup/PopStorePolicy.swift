//
//  PopStorePolicy.swift
//  Forbrands
//
//  Created by osamaaassi on 17/12/2021.
//

import UIKit

class PopStorePolicy: SuperViewController {

    @IBOutlet var senstorePolicyLbl  : UILabel!
    var storePolicyID:String?
    override func viewDidLoad() {
        super.viewDidLoad()

        storePolicy(storePolicyID ?? "0")
        // Do any additional setup after loading the view.
    }
    

    @IBAction func tapPolicy(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    func storePolicy( _ id:String){
            _ = WebRequests.setup(controller: self).prepare(api: Endpoint.storePolicy,parameters: ["id" : id ] ,isAuthRequired:  true).start(){ (response, error) in
                
            do {
                
                let Status =  try JSONDecoder().decode(BaseDataResponse<StorePolicy>.self, from: response.data!)
                if Status.code == 200{
                    if Status.data != nil {
                        self.senstorePolicyLbl.text = Status.data?.storePolicy
                    }
                  
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }

}
