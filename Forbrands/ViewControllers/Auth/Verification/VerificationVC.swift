//
//  VerificationVC.swift
//  Forbrands
//
//  Created by osamaaassi on 05/08/2021.
//

import UIKit
import VKPinCodeView

class VerificationVC: SuperViewController {
    
    @IBOutlet var lblCode: VKPinCodeView!
    @IBOutlet weak var lblNumber: UILabel!
    var isSeller = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblCode.onSettingStyle = {
        BorderStyle(
            textColor: .red,
            borderWidth: 1,
            selectedBorderColor :UIColor.red, backgroundColor: .white,
            selectedBackgroundColor: UIColor.white
        )}
        lblCode.animateSelectedInputItem = true
        lblCode.endEditing(true)
        lblCode.onComplete = { code, pinView in
           // self.bt_Virifcation( self.phone , code)
            }
        
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
    }

    @IBAction func bt_Virifcation(_ sender : UIButton) {
        if (!isSeller){
            let vc:TTabBarController = TTabBarController.loadFromNib()
            vc.modalPresentationStyle = .fullScreen
            self.goToRoot(vc)
        }else{
            let vc:StoreInformationVC = StoreInformationVC.loadFromNib()
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @IBAction func bt_resendCode(_ sender: UIButton) {
        
    }
    

}
