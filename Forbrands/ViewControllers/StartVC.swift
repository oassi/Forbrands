//
//  ViewController.swift
//  Forbrands
//
//  Created by osamaaassi on 03/08/2021.
//

import UIKit

class StartVC: UIViewController {

    public static var typeUser = "seller"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        
        DispatchQueue.main.async {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                        let vc = LoginVC.loadFromNib().navigationController()
                        vc.modalPresentationStyle = .fullScreen
                        self.goToRoot(vc)
            })}
       // let vcs =  LoginVC().navigationController()
         //let vc:LoginVC = LoginVC.loadFromNib().navigationController()
//         vcs.hidesBottomBarWhenPushed = true
//         vcs.modalPresentationStyle = .fullScreen
//         self.present(vcs, animated: true, completion: nil)
   
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
   
    

}

extension UIViewController{
    func goToRoot(_ viewController:UIViewController) {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
      //  self.present(viewController, animated: true, completion: nil)
    }
}


// Get All Family Names
//let fontFamilyNames = UIFont.familyNames
//for familyName in fontFamilyNames {
//    print("Font Family Name = [\(familyName)]")
//    let names = UIFont.fontNames(forFamilyName: familyName)
//    print("Font Names = [\(names)]")
//}
