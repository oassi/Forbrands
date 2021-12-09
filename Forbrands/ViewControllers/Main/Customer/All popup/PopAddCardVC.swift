//
//  PopAddCardVC.swift
//  Forbrands
//
//  Created by osamaaassi on 14/08/2021.
//

import UIKit

class PopAddCardVC: UIViewController {

    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var views: UIView!
    var goTocard : (()->())?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

            
    @IBAction func tapKeepShopping(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapGoToCard(_ sender: Any) {
        goTocard?()
        dismiss(animated: true, completion: nil)
    }
    

}
