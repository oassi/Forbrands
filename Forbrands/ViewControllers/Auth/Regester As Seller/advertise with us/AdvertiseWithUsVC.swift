//
//  AdvertiseWithUsVC.swift
//  Forbrands
//
//  Created by osamaaassi on 09/08/2021.
//

import UIKit

class AdvertiseWithUsVC: UIViewController {

    @IBOutlet weak var lblfeatures: UILabel!
    @IBOutlet weak var img: UIImageView!
    var subscription : Subscription!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        getSubscription()
    }
   
    private func navButtons(){
      //  let navgtion = self.navigationController as! CustomNavigationBar
       // let button1 = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
       // navgtion.setLeftsButtons([button1], sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func AdvertiseWithUsButton(_ sender: UIButton) {
        let vc:ConnectWithUsVC = ConnectWithUsVC.loadFromNib()
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func skipButton(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                        let vc = TTabBarController()
                        vc.modalPresentationStyle = .fullScreen
                        self.goToRoot(vc)
            })}
    }
    
    func getSubscription(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.subscriptionTrader ,isAuthRequired:  false).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<Subscription>.self, from: response.data!)
                
                if Status.code == 200{
                    self.subscription = Status.data!
                    self.img.sd_custom(url: self.subscription.image ?? "")
//                    let feature = MOLHLanguage.isArabic() ? Status.data!.featuresAr  ?? "": Status.data!.featuresEn ?? ""
//                     self.lblfeatures.text = feature.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "")
//
                    if MOLHLanguage.isArabic(){
                        Status.data!.featuresAr?.forEach{self.lblfeatures.text = $0}
                    }else{
                        Status.data!.featuresEn?.forEach{self.lblfeatures.text = $0}
                    }
                }
            }catch let jsonErr {
                print("Error serializing respone json", jsonErr)
            }
        }
    }

}
