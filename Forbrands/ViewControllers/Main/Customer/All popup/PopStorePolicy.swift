//
//  PopStorePolicy.swift
//  Forbrands
//
//  Created by osamaaassi on 17/12/2021.
//

import UIKit

class PopStorePolicy: SuperViewController {

    @IBOutlet var senstorePolicyLbl  : UILabel!
 //   var storePolicyID:String?
    var storePolicy:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.senstorePolicyLbl.text = storePolicy ?? ""
        // Do any additional setup after loading the view.
    }
    

    @IBAction func tapPolicy(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

  
}
