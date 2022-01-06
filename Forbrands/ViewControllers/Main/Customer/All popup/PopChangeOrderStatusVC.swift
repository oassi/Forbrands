//
//  PopChangeOrderStatusVC.swift
//  Forbrands
//
//  Created by osamaaassi on 16/08/2021.
//

import UIKit

class PopChangeOrderStatusVC: SuperViewController {
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet var heighttableViewCell: NSLayoutConstraint!
    @IBOutlet var sendBut          : UIButton!
    
    var paymentMethods = ["Underway","Charging","Received"]
    var selectedID = 0
    var ordersId: String?
    var changeProcessDeleget : (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.registerCell(id: "PaymentMethodsCell")
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        tableviewRelodData()
        changBackgroundColorButApp(sendBut)
    }
    func tableviewRelodData(){
        self.heighttableViewCell.constant = CGFloat(55 * paymentMethods.count)
            tableview.reloadData()
    }
    
    @IBAction func tapSave(_ sender: UIButton) {
        var parameters = [String : String]()
        parameters["order_id"] = ordersId ?? ""
        switch selectedID {
        case 0:
         parameters["order_process"] = "1"
        case 1:
         parameters["order_process"] = "2"
        case 2:
         parameters["order_process"] = "3"
        default:
         break
        }
       
        
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.changeProcessTrader,parameters:parameters ,isAuthRequired: true).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(StatusStruct.self, from: response.data!)
                if Status.code == 200{
                    self.showAlert(title: "", message: "successful".localized)
                    self.changeProcessDeleget?()
                    self.navigationController?.popViewController(animated: true)
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
}

extension PopChangeOrderStatusVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentMethods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "PaymentMethodsCell", for: indexPath) as! PaymentMethodsCell
        cell.lblNamePayment.text = paymentMethods[indexPath.row].localized
        if(selectedID == indexPath.row){
            
            cell.imgPayment.image = UIImage(named: "fillDot")
            cell.imgPayment.setImageColor(color: UIColor(named: getColorName())!)

            
        }else{
            cell.imgPayment.image = UIImage(named: "emptyDot")
            cell.imgPayment.setImageColor(color: UIColor(named: getColorName())!)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedID = indexPath.row
        tableview.reloadData()
    }
    
    
}
