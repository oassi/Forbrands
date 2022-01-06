//
//  PayMethodVC.swift
//  Forbrands
//
//  Created by osamaaassi on 06/12/2021.
//

import UIKit

class PayMethodVC: SuperViewController {
    @IBOutlet weak var tableview:UITableView!
    @IBOutlet weak var saveBut:UIButton!
    var paymentMethods = [PayMethods]()
    var selectedIndex: Int  = 0
    
    var paymentId : Int?
    var addressID: Int?
    var isDiscount:Bool?
    var amounts : Double?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        getPayMethods()
        tableview.registerCell(id: "PaymentMethodsCell")
        // Do any additional setup after loading the view.
    }

    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
    }

  func getPayMethods(){
            _ = WebRequests.setup(controller: self).prepare(api: Endpoint.payMethodsList ,isAuthRequired:  true).start(){  (response, error) in
                do {
                    let Status =  try JSONDecoder().decode(BaseDataResponse<PayMethodObj>.self, from: response.data!)
                     if Status.code == 200{
                        if let pay = Status.data?.payMethods , !pay.isEmpty {
                            self.paymentMethods += Status.data!.payMethods!
                            self.tableview.reloadData()
                        }
                       
                    }
                }catch let jsonErr {
                    print("Error serializing  respone json", jsonErr)
                }
            }
        }
    
    @IBAction func tapSave(_ sender: UIButton) {
        guard let id = paymentId else {
            showAlert(title: "", message: "Please select Pay Method".localized)
            return
        }
        
        var parameters = [String : String]()
        parameters["payment_id"] = paymentId?.description ?? "0"
        parameters["address_id"] = addressID?.description ?? "0"
        parameters["total"]      = amounts?.description ?? "0.0"
        parameters["isDiscount"] = isDiscount?.description ?? "false"
        print(parameters)
        switch id {
        case 1:
            addOrders(parameters :parameters, paymentId: 1)
        case 2:
            addOrders(parameters :parameters, paymentId: 2)
        case 3:
            addOrders(parameters :parameters, paymentId: 3)
        case 4:
            print(id)
        case 5:
            addOrders(parameters :parameters, paymentId: 5)
        default:
            break
        }
       
    }
    
    func addOrders(parameters : [String:String], paymentId : Int)  {
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.addOrders,parameters: parameters ,isAuthRequired:  true).start(){  (response, error) in
            do {
                
                let Status =  try JSONDecoder().decode(StatusStruct.self, from: response.data!)
                if Status.code == 200{
                    guard let st = Status.status, st else {
                        return
                    }
                    if paymentId == 1 {
                        let vc:CheckoutVC = CheckoutVC.loadFromNib()
                        vc.modalPresentationStyle = .fullScreen
                        self.navigationController?.present(vc, animated: true, completion: nil)
                    }else if paymentId == 2 {
                        self.pay(type: Endpoint.tabby)
                    }
                    else if paymentId == 3 {
                        self.pay(type: Endpoint.stc)
                    }
                    else if paymentId == 5 {
                        self.pay(type: Endpoint.tap)
                    }
                 
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    func pay(type:Endpoint) {
        _ = WebRequests.setup(controller: self).prepare(api: type ,isAuthRequired:  true).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(TabbayResponse.self, from: response.data!)
                
                let vc : webViewVC = webViewVC.loadFromNib()
                vc.url = Status.webUrl ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
                
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
}


extension PayMethodVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentMethods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "PaymentMethodsCell", for: indexPath) as! PaymentMethodsCell
        let obj = paymentMethods[indexPath.row]
        cell.lblNamePayment.text = MOLHLanguage.isArabic() ? obj.nameAr  ?? "": obj.nameEn ?? ""

        if selectedIndex == indexPath.row {
            cell.imgPayment.image = UIImage(named: "doneTrue")
            paymentId = paymentMethods[indexPath.row].id
        }else {
            cell.imgPayment.image = UIImage(named: "emptyDot")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let id = paymentMethods[indexPath.row].id {
            paymentId =  id
            selectedIndex = indexPath.row
            tableview.reloadData()
        }
       
    }
}




