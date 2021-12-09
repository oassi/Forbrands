//
//  PaymentMethodVC.swift
//  Forbrands
//
//  Created by osamaaassi on 13/08/2021.
//

import UIKit

class PaymentMethodVC: SuperViewController {
    @IBOutlet weak var tableview:UITableView!
    var paymentMethods = ["Pay when receiving","Pay by mada","STC Pay","Master Card","Visa"]
    var selectedID = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        tableview.registerCell(id: "PaymentMethodsCell")
        // Do any additional setup after loading the view.
    }
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
    }
    @IBAction func tapSubscribe(_ sender: UIButton) {
        let vc:OnlinePaymentVC =  OnlinePaymentVC.loadFromNib()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }

}


extension PaymentMethodVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentMethods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "PaymentMethodsCell", for: indexPath) as! PaymentMethodsCell
        cell.lblNamePayment.text = paymentMethods[indexPath.row].localized
        if(selectedID == indexPath.row){
            cell.imgPayment.image = UIImage(named: "fillDot")
        }else{
            cell.imgPayment.image = UIImage(named: "emptyDot")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedID = indexPath.row
        tableview.reloadData()
    }
}
