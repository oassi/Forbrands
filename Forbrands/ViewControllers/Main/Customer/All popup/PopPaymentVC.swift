//
//  PopPaymentVC.swift
//  Forbrands
//
//  Created by osamaaassi on 14/08/2021.
//

import UIKit

class PopPaymentVC: UIViewController {
    @IBOutlet weak var tableview:UITableView!
    @IBOutlet var heighttableViewCell: NSLayoutConstraint!
    var paymentMethods = ["Pay when receiving","Pay by mada","STC Pay","Master Card","Visa"]
    var selectedID = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.registerCell(id: "PaymentMethodsCell")
        UIView.animate(withDuration: 2) {
            self.heighttableViewCell.constant = 50
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func tapSave (_ sender : UIButton){
       dismiss(animated: true, completion: nil)
    }

}
extension PopPaymentVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentMethods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "PaymentMethodsCell", for: indexPath) as! PaymentMethodsCell
        cell.lblNamePayment.text = paymentMethods[indexPath.row]
        if(selectedID == indexPath.row){
            cell.imgPayment.image = UIImage(named: "fillDot")
        }else{
            cell.imgPayment.image = UIImage(named: "emptyDot")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedID = indexPath.row
        tableview.reloadData()
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.heighttableViewCell.constant = self.tableview.contentSize.height
       
    }
    
    
}
