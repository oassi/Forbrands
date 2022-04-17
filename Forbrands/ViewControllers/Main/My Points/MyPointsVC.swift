//
//  MyPointsVC.swift
//  Forbrands
//
//  Created by osamaaassi on 16/12/2021.
//

import UIKit

class MyPointsVC: SuperViewController {

    @IBOutlet weak var moneyLbl:UILabel!
    @IBOutlet weak var pointLbl:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        getPoint()
        // Do any additional setup after loading the view.
    }


    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
    }
    
    
    func getPoint()  {
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.point ,isAuthRequired: true).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<Point>.self, from: response.data!)
                guard Status.code == 200 else{
                    self.showAlert(title: Status.title ?? "", message: Status.message ?? "")
                    return
                }
                self.moneyLbl.text = Status.data?.money?.description ?? "0"
                self.pointLbl.text = Status.data?.point?.description ?? "0"
                
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
    
    @IBAction func tapSave(_ sender: UIButton) {
        pay(type:.tap)
    }
    func pay(type:Endpoint) {
        
        _ = WebRequests.setup(controller: self).prepare(api: type ,isAuthRequired:  true).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(TabbayResponse.self, from: response.data!)
                
                let vc : webViewVC = webViewVC.loadFromNib()
                vc.url = Status.webUrl ?? ""
                vc.hidesBottomBarWhenPushed = true
                vc.isPoint = true
                self.navigationController?.pushViewController(vc, animated: true)
                
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }

}
