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
    @IBOutlet weak var viewPay : UIView!
    @IBOutlet weak var viewPoint : UIView!
    @IBOutlet weak var viewMyAccount: UIStackView!
    @IBOutlet weak var viewtopNotSingin : UIView!
    
    @IBOutlet weak var viewIstgram : UIView!
    @IBOutlet weak var viewTwitter : UIView!
    @IBOutlet weak var imgIstgram : UIImageView!
    @IBOutlet weak var imgTwitter : UIImageView!

    @IBOutlet weak var viewSingOut : UIView!
    @IBOutlet weak var SubscribeToPremiumMembership : UIStackView!
    @IBOutlet weak var subscribeBut : UIButton!

 
    enum SocialNetwork  {
        case Twitter, Instagram,Evaluation
        func url() -> SocialNetworkUrl {
            switch self {
            case .Twitter: return SocialNetworkUrl(scheme: CurrentUser.myAccount?.twitter ?? "", page: CurrentUser.myAccount?.twitter ?? "")
            case .Instagram: return SocialNetworkUrl(scheme: CurrentUser.myAccount?.instagram ?? "", page:CurrentUser.myAccount?.instagram ?? "")
            case .Evaluation: return SocialNetworkUrl(scheme: CurrentUser.myAccount?.appStore ?? "", page:CurrentUser.myAccount?.appStore ?? "")
            }
        }
        func openPage() {
            self.url().openPage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMyAccount()
        // Do any additional setup after loading the view.
        SubscribeToPremiumMembership.isHidden = true
//        SubscribeToPremiumMembership.isHidden = !(CurrentUser.myAccount?.subscriptions ?? true)

        viewtopNotSingin.isHidden = true
        
        if(CurrentUser.typeSelect == userType.Seller){
            viewMyOrede.isHidden = true
            viewAddress.isHidden = true
            SubscribeToPremiumMembership.isHidden = true
            viewPay.isHidden = false
            viewPoint.isHidden = false
        }
        if( CurrentUser.typeSelect == userType.Guest){
            viewtopNotSingin.isHidden = false
            viewMyOrede.isHidden = true
            viewAddress.isHidden = true
            viewMyAccount.isHidden = true
            viewPay.isHidden = true
            viewPoint.isHidden = true
            viewSingOut.isHidden = true
            SubscribeToPremiumMembership.isHidden = true

        }
        if CurrentUser.typeSelect == userType.User {
            viewPay.isHidden = true
            viewPoint.isHidden = true
        }
      
    }

    override func viewWillAppear(_ animated: Bool) {
        let navgtion = self.navigationController as! CustomNavigationBar
        if(CurrentUser.typeSelect == userType.Seller){
            navigationController?.navigationBar.tintColor = getColorApp()
            imgIstgram.setImageColor(color: UIColor(named: getColorName())!)
            imgTwitter.setImageColor(color: UIColor(named: getColorName())!)
            viewIstgram.borderColor =  getColorApp()
            viewTwitter.borderColor =  getColorApp()
            changBackgroundColorButApp(subscribeBut)
            
        }
        if CurrentUser.typeSelect != userType.Guest{
            navgtion.setTitle("My Account".localized, sender: self, large: true)
            navigationController?.navigationBar.layer.masksToBounds = false
        }
        else{
            navigationController?.navigationBar.layer.masksToBounds = true
            navgtion.setLeftsButtons([navgtion.siginBarButton!], sender: self)
            navgtion.setRightButtons([navgtion.newUserBarButton!], sender: self)
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        if CurrentUser.typeSelect != userType.Guest{
            let navgtion = self.navigationController as! CustomNavigationBar
            navgtion.setTitle("My Account".localized, sender: self, large: false)
        }
    }
      
    override func didClickRightButton(_sender: UIBarButtonItem) {
        switch _sender.tag {
        case 160:
            let vc = LoginVC.loadFromNib().navigationController()
            vc.modalPresentationStyle = .fullScreen
            self.goToRoot(vc)
        default:
            break
        }
    }
    
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
            if(CurrentUser.typeSelect == userType.Seller){
                let vc:PayMethodSellerVC = PayMethodSellerVC.loadFromNib()
                poushVC(vc)
            }
           
        }
        //Payment
        if(sender.tag == 10){
            if(CurrentUser.typeSelect == userType.Seller){
                let vc:MyPointsVC = MyPointsVC.loadFromNib()
                poushVC(vc)
            }
           
        }
        
    }
    @IBAction func tapApp(_ sender: UIButton) {
        
        //Shaer the app
        if(sender.tag == 4){
            let shareAll = ["\(CurrentUser.myAccount?.shareText ?? "")", "\(CurrentUser.myAccount?.appStore ?? "")"] as [Any]
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
            CurrentUser.userInfo = nil
            CurrentUser.userTrader = nil
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
    
    func getMyAccount(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.myAccount ,isAuthRequired:  false).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<MyAccount>.self, from: response.data!)
                if Status.code == 200{
                    guard (Status.data != nil) else {
                        return
                    }
                    CurrentUser.myAccount = Status.data
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }

}


