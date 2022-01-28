//
//  PhoneVerificationCode.swift
//  Forbrands
//
//  Created by Osama Abu Assi on 27/01/2022.
//

import UIKit
import VKPinCodeView

class PhoneVerificationCode: SuperViewController {
    
    @IBOutlet var lblCode: VKPinCodeView!
    @IBOutlet weak var lblNumber: UILabel!
    
    @IBOutlet weak var lblresend: UIStackView!
    @IBOutlet weak var lblTimmer: UILabel!
    
    var isSeller = false
    var idUser:String?
    var phonNumber:String?
    
    var timer = Timer()
    var seconds = 30
    var currentSeconds = Date()
    var codeNumber :String?
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        generateCode()
        
        lblNumber.text = phonNumber ?? ""
        lblCode.onSettingStyle = { UnderlineStyle(
            lineWidth : 1.0
        )}
        lblCode.animateSelectedInputItem = true
        lblCode.endEditing(true)
        lblCode.onComplete = { code, pinView in
            self.codeNumber = code
        }
        
        timer.invalidate()
        startTimeer()
        
    }
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
    }
    
    
    func startTimeer(){
        timer.invalidate()
        self.seconds = 20
        self.lblresend.isHidden = true
        
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
            self.lblresend.isHidden = false
            self.lblTimmer.text = ""
            timer.invalidate()
        }
        else{
            let readytext = self.setupTimer(seconds: seconds)
            let mainText = "Code expires after".localized + readytext
            self.lblTimmer.text = mainText
            seconds = difference.second ?? 0
        }
    }
    
    func setupTimer(seconds:Int) -> String {
        _ = seconds / 3600
        let minute = seconds / 60 % 60
        let second = seconds % 60
        return " \(String(format: "%02d", minute)):" + "\(String(format: "%02d", second))"
    }
    
    
    
    @IBAction func bt_Virifcation(_ sender : UIButton) {
        guard let code = self.codeNumber , !code.isEmpty else {
            self.showAlert(title: "Error".localized, message: "Code cannot be empty".localized)
            return
        }
        self.verifcationCode(code)
    }
   
    
    func verifcationCode(_ code : String){
        var parameters = [String : String]()
            parameters["code"] = code
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.checkCode,parameters:parameters ,isAuthRequired:  false).start(){  (response, error) in
            do {
                
                let Status =  try JSONDecoder().decode(BaseDataResponse<UserData>.self, from: response.data!)
                
                if Status.code == 200{
                  
                    WebRequests.tokenApiPassword = Status.data?.token ?? ""
                        let vc:NewPasswordVC = NewPasswordVC.loadFromNib()
                        vc.modalPresentationStyle = .fullScreen
                        self.navigationController?.pushViewController(vc, animated: true)
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    func generateCode() {
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.forgetpasswordCode,parameters: ["phone" : phonNumber ?? "0"] ,isAuthRequired:  false).start(){ (response, error) in
            do {
                
                let Status =  try JSONDecoder().decode(BaseDataResponse<GenerateCode>.self, from: response.data!)
                if Status.code == 200{
                    self.startTimeer()
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
           
        }
        
    }
    
    @IBAction func bt_resendCode(_ sender: UIButton) {
        generateCode()
    }
    
    
}

