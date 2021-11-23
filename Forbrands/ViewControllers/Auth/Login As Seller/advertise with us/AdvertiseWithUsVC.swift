//
//  AdvertiseWithUsVC.swift
//  Forbrands
//
//  Created by osamaaassi on 09/08/2021.
//

import UIKit

class AdvertiseWithUsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
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

}
