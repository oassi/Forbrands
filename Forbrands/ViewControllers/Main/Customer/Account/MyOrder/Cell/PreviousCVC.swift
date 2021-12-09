//
//  PreviousCVC.swift
//  Forbrands
//
//  Created by osamaaassi on 15/08/2021.
//

import UIKit
import Cosmos

class PreviousCVC: UITableViewCell {
    @IBOutlet weak var ViewRate: CosmosView!
    @IBOutlet var viewRates: UIView!
    
    @IBOutlet var heighttableViewCell: NSLayoutConstraint!
    @IBOutlet var tableview: UITableView!
    
    @IBOutlet var lblOrderNumber: UILabel!
    @IBOutlet var lblOrderDate: UILabel!
    @IBOutlet var lblEvaluation: UILabel!
    //Underway
    
    @IBOutlet var lblUnderway: UILabel!
    @IBOutlet var imgUnderway: UIImageView!
    @IBOutlet var viewUnderway: UIView!
    //Charging
    @IBOutlet var imgCharging: UIImageView!
    //Received
    @IBOutlet var imgReceived: UIImageView!
    @IBOutlet var viewReceived: UIView!
    
    @IBOutlet var Total: UILabel!
    @IBOutlet var lblDay: UILabel!
    @IBOutlet var lblOrderDetails : UILabel!
    @IBOutlet var viewExpectedData: UIView!
    @IBOutlet var reviewsBut: UIButton!
    var viewOrderDetails : (()->())!
    var eveluationDeleget : (()->())!
    
    var products = [Product]()
    
    var obj : CustomerOrders? {
        didSet{
            lblOrderNumber.text = obj?.orderId ?? ""
            lblOrderDate.text = obj?.orderDate ?? "undefined".localized
            lblDay.text = obj?.deliverDate ?? "undefined".localized
            Total.text = obj?.totalPrice ?? "0"
            
            
            if (obj?.orderProcess == "1"){
                imgUnderway.image = UIImage(named: "doneTrue")
                imgCharging.image = UIImage(named: "onRequest")
                imgReceived.image = UIImage(named: "onRequest")
                viewUnderway.backgroundColor = UIColor(named: "green")
                viewReceived.backgroundColor = UIColor(named: "derkGrey")
              
            }else if (obj?.orderProcess == "2"){
                imgUnderway.image = UIImage(named: "doneTrue")
                imgCharging.image = UIImage(named: "doneTrue")
                imgReceived.image = UIImage(named: "onRequest")
                viewUnderway.backgroundColor = UIColor(named: "green")
                viewReceived.backgroundColor = UIColor(named: "green")
            }
            else if (obj?.orderProcess == "3"){
                imgUnderway.image = UIImage(named: "doneTrue")
                imgCharging.image = UIImage(named: "doneTrue")
                imgReceived.image = UIImage(named: "doneTrue")
                viewUnderway.backgroundColor = UIColor(named: "green")
                viewReceived.backgroundColor = UIColor(named: "green")
               
            }
            else if (obj?.orderProcess == "-1"){
                lblUnderway.text = "the order has been canceled".localized
                imgUnderway.image = UIImage(named: "cancelledOrder")
                imgCharging.image = UIImage(named: "exitSearch")
                imgReceived.image = UIImage(named: "exitSearch")
                imgReceived.image = UIImage(named: "exitSearch")
                viewUnderway.backgroundColor = UIColor(named: "derkGrey")
                viewReceived.backgroundColor = UIColor(named: "derkGrey")
               
            }
            else{
                imgUnderway.image = UIImage(named: "onRequest")
                imgCharging.image = UIImage(named: "onRequest")
                imgReceived.image = UIImage(named: "onRequest")
                viewUnderway.backgroundColor = UIColor(named: "derkGrey")
                viewReceived.backgroundColor = UIColor(named: "derkGrey")
            }
            if(obj?.products != nil){
                obj!.products!.forEach{products.append($0)}
                self.heighttableViewCell.constant = CGFloat((obj!.products!.count) * 100)
                tableview.reloadData()

            }
            
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        tableview.registerCell(id: "CurrentTableViewCell")
        tableview.delegate = self
        tableview.dataSource = self
        
        UIView.animate(withDuration: 1) {
            self.heighttableViewCell.constant = 100
            self.contentView.layoutIfNeeded()
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func tapEveluation(_ sender: UIButton) {
        eveluationDeleget?()
    }
    @IBAction func tapViewOrderDetails(_ sender: UIButton) {
        viewOrderDetails?()
    }
    
}

extension PreviousCVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "CurrentTableViewCell", for: indexPath) as! CurrentTableViewCell
        cell.obj = products[indexPath.row]
        return cell
    }
    
   
    
}
