//
//  MyAccountVC.swift
//  Forbrands
//
//  Created by osamaaassi on 05/08/2021.
//

import UIKit

class MyAccountVC: SuperViewController {
    @IBOutlet weak var viewMyOrede : UIView!
    @IBOutlet weak var viewAddress : UIView!
    @IBOutlet weak var viewOther : UIView!
    @IBOutlet weak var viewSherApp : UIStackView!
    
    enum SocialNetwork {
        case Twitter, Instagram,Evaluation
        func url() -> SocialNetworkUrl {
            switch self {
            case .Twitter: return SocialNetworkUrl(scheme: "twitter:///user?screen_name=osama_asi", page: "https://twitter.com/osama_asi")
            case .Instagram: return SocialNetworkUrl(scheme: "instagram://user?username=assi.o", page:"https://www.instagram.com/assi.o")
            case .Evaluation: return SocialNetworkUrl(scheme: "https://www.apple.com/app-store/", page:"https://www.apple.com/app-store/")
            }
        }
        func openPage() {
            self.url().openPage()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if(CurrentUser.typeSelect == userType.Seller){
            viewMyOrede.isHidden = true
            viewAddress.isHidden = true
            viewOther.isHidden   = true
            viewSherApp.isHidden = true
        }
      
    }

    override func viewWillAppear(_ animated: Bool) {
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setTitle("My Account".localized, sender: self, large: true)
        navigationController?.navigationBar.layer.masksToBounds = false
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setTitle("My Account".localized, sender: self, large: false)
    }
      
        
//        navgtion.setShadowNavBar()
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationItem.largeTitleDisplayMode = .always
//        navigationController?.navigationBar.topItem?.title = "My Account"
//        navigationController?.navigationBar.shadowColor = .black
    

//    override func viewWillDisappear(_ animated: Bool) {
//        let navgtion = self.navigationController as! CustomNavigationBar
//        navgtion.setTitle("My Account".localized, sender: self, large: false)
//    }
    
    @IBAction func tapProfile(_ sender: UIButton) {
        //My Oreder
        if(sender.tag == 0){
            let vc:MyOrderVC = MyOrderVC.loadFromNib()
            vc.hidesBottomBarWhenPushed = true
            poushVC(vc)
           
         }
        //Addresses
        if(sender.tag == 1){
             let vc:AddressesVC = AddressesVC.loadFromNib()
            poushVC(vc)
        }
        
        //setting
        if(sender.tag == 2){
            let vc:SettingsVC = SettingsVC.loadFromNib()
            poushVC(vc)
        }
        
        //Payment
        if(sender.tag == 3){
            
        }
  
        
    }
    @IBAction func tapApp(_ sender: UIButton) {
        
        //Shaer the app
        if(sender.tag == 4){
            
            let shareAll = ["test", "Link"] as [Any]
            let activityViewController = UIActivityViewController(activityItems: shareAll as [Any], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
            
          
        }
        
        //Connect with us
        if(sender.tag == 5){
            let vc:ConnectWithUsVC = ConnectWithUsVC.loadFromNib()
            poushVC(vc)
        }
        
        //About us
        if(sender.tag == 6){
            let vc:AboudUsVC = AboudUsVC.loadFromNib()
            poushVC(vc)
        }
        
       
        //Other
        if(sender.tag == 8){}
        
        //Sing out
        if(sender.tag == 9){
           let vcs =  LoginVC().navigationController()
            //let vc:LoginVC = LoginVC.loadFromNib().navigationController()
            vcs.hidesBottomBarWhenPushed = true
            vcs.modalPresentationStyle = .fullScreen
            self.present(vcs, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func SubscribeToPremiumMembership(_ sender: UIButton) {
        let vc:SubscribeVC = SubscribeVC.loadFromNib()
        poushVC(vc)
    }
    
    fileprivate func poushVC(_ vc:UIViewController){
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func bts_SocialMedia(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            SocialNetwork.Twitter.openPage()
        case 1:
            SocialNetwork.Instagram.openPage()
        case 3:
            showAlertWithCancelAndDefault(title: "App Evaluation".localized, message: "Go to the App Store to rate the app".localized, okAction: "Go".localized) { (UIAlertAction) in
                SocialNetwork.Evaluation.openPage()
            }
           
        default:
            break
        }
    }

}
