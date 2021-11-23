//
//  ProfileSellerVC.swift
//  Forbrands
//
//  Created by osamaaassi on 13/08/2021.
//

import UIKit

class ProfileSellerVC: SuperViewController {

    @IBOutlet var collectionview    : UICollectionView!
    @IBOutlet var imgCoverStore     : UIImageView!
    @IBOutlet var lblFullName       : UILabel!
    @IBOutlet var lblMobile         : UILabel!
    @IBOutlet var lblEmail          : UILabel!
    @IBOutlet var lblStoreName      : UILabel!
    @IBOutlet var lblStoreLink      : UILabel!
    @IBOutlet var lblCommercial     : UILabel!
    @IBOutlet var lblIban           : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
        navgtion.setTitle("My Account".localized, sender: self, large: true)
        navigationController?.navigationBar.backgroundColor = UIColor(named: "background")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navButtons()
    }

    @IBAction func tapChangePhoto(_ sender: Any) {
        
    }

    
    @IBAction func tapEdit(_ sender: UIButton) {
        var vc = UIViewController()
        switch  sender.tag {
        case 0:
            vc = EditProfileSellerVC.loadFromNib()
        case 1:
             vc = EditStoreInformationVC.loadFromNib()
        default:
            break
        }
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
