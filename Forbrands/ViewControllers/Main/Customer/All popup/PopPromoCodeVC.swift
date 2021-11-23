//
//  PopPromoCodeVC.swift
//  Forbrands
//
//  Created by osamaaassi on 09/08/2021.
//

import UIKit

class PopPromoCodeVC: UIViewController {
    @IBOutlet weak var popupView: UIView!

    @IBOutlet weak var lblPromeCode:UITextField!
    @IBOutlet weak var lblIsErrorPromoCode:UILabel!
    @IBOutlet weak var viewDescount:UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
    }
  
    @IBAction func tapSave (_ sender : UIButton){
     dismiss(animated: true, completion: nil)
    
    }


}
