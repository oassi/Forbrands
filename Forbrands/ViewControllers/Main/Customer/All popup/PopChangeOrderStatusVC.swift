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
    var paymentMethods = ["Underway","Charging","Received"]
    var selectedID = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.registerCell(id: "PaymentMethodsCell")
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        tableviewRelodData()
    }
    func tableviewRelodData(){
        self.heighttableViewCell.constant = CGFloat(55 * paymentMethods.count)
        tableview.reloadData()
    }
    
    @IBAction func tapSave(_ sender: UIButton) {
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
