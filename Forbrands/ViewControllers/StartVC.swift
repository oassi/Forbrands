//
//  ViewController.swift
//  Forbrands
//
//  Created by osamaaassi on 03/08/2021.
//

import UIKit

class StartVC: UIViewController,SwiftyGifDelegate {

    @IBOutlet var splashImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        showGif()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            
            let vc:OnBordingVC = OnBordingVC.loadFromNib()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
//            if !UserDefaults.standard.bool(forKey: "didStart") {
//                UserDefaults.standard.set(true, forKey: "didStart")
//
//            }else{
//                DispatchQueue.main.async {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
//                        let vc = LoginVC.loadFromNib().navigationController()
//                        vc.modalPresentationStyle = .fullScreen
//                        self.goToRoot(vc)
//                    })}
//            }
        }
   
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func showGif() {
        do {
            let gif = try UIImage(gifName: "log")
            
    
            self.splashImage = UIImageView(gifImage: gif, loopCount: 1) // Use -1 for infinite loop
            self.splashImage.frame = self.view.bounds
            self.splashImage.contentMode = .scaleAspectFill
            self.splashImage.delegate = self
            self.view.addSubview(self.splashImage)
        } catch let error as NSError{
            print(error)
        }
        self.splashImage.startAnimatingGif()
    
    
    }
    

}

extension UIViewController{
    func goToRoot(_ viewController:UIViewController) {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}


// Get All Family Names
//let fontFamilyNames = UIFont.familyNames
//for familyName in fontFamilyNames {
//    print("Font Family Name = [\(familyName)]")
//    let names = UIFont.fontNames(forFamilyName: familyName)
//    print("Font Names = [\(names)]")
//}
