//
//  OnBordingVC.swift
//  Forbrands
//
//  Created by osamaaassi on 17/08/2021.
//

import UIKit

class OnBordingVC: UIViewController {
    @IBOutlet weak var lblTimmer: UILabel!
    var timer = Timer()
    var seconds = 5
    var currentSeconds = Date()
    var isPush = true
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timer.invalidate()
        startTimeer()
    }
    
    func startTimeer(){
        timer.invalidate()
        self.seconds = 5
        self.currentSeconds = Date().addingTimeInterval(TimeInterval(seconds))
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerDiscount), userInfo: nil, repeats: true)
    }
    @objc func timerDiscount(){
        let startDate = Date()
        print("date",currentSeconds)
        print("date",startDate)
        let difference = Calendar.current.dateComponents([.second], from: startDate, to: currentSeconds)
        let formattedString = "\(difference.second ?? 0)"
        
        if(formattedString < "0"){
            self.lblTimmer.text = "0"
            if(isPush){
                goToLogin(0.0)
                
            }
            timer.invalidate()
        }
        else{
            let readytext = self.setupTimer(seconds: seconds)
            let mainText = "Skip".localized + readytext + "s".localized
            self.lblTimmer.text = mainText
            seconds = difference.second ?? 0
        }
    }
    
    func setupTimer(seconds:Int) -> String {
        _ = seconds / 3600
        _ = seconds / 60 % 60
        let second = seconds % 60
        return "\(String(format: "%02d", second))"
    }
    
    @IBAction func bt_Next(_ sender: Any) {
        isPush = false
        goToLogin(0.0)
    }

    func register<T>(_ a: T) {
        let vc = a
        (vc as! UIViewController).modalPresentationStyle = .fullScreen
        self.goToRoot(vc as! UIViewController)
    }
    
    private func goToLogin(_ tiem :Double = 5.0 ){
        if CurrentUser.userInfo == nil {
            register(LoginVC.loadFromNib().navigationController())
        }else{
            if(CurrentUser.userInfo!.roleName == "Trader"
                && CurrentUser.userInfo!.store == nil
                && CurrentUser.userTrader == nil){
                UserDefaults.standard.set(true, forKey: "isNotCompleteData")
                register(StoreInformationVC.loadFromNib().navigationController())
            }
            else{
                register(TTabBarController())
            }
            
        }
        
//        DispatchQueue.main.async {
//            DispatchQueue.main.asyncAfter(deadline: .now() + tiem, execute: {
//
//                if CurrentUser.userInfo == nil {
//                    let vc = LoginVC.loadFromNib().navigationController()
//                    vc.modalPresentationStyle = .fullScreen
//                    self.goToRoot(vc)
//                }else{
//                    let vc = TTabBarController()
//                    vc.modalPresentationStyle = .fullScreen
//                    self.goToRoot(vc)
//                }
//            })}
    }
    
}

