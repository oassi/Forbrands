//
//  CurrentCVC.swift
//  Forbrands
//
//  Created by osamaaassi on 15/08/2021.
//

import UIKit

class CurrentCVC: UITableViewCell {

    @IBOutlet var heighttableViewCell: NSLayoutConstraint!
    @IBOutlet var tableview: UITableView!
    
    @IBOutlet var lblOrderNumber: UILabel!
    @IBOutlet var lblOrderDate: UILabel!
    
    //Underway
    @IBOutlet var lblUnderway: UILabel!
    @IBOutlet var imgUnderway: UIImageView!
    @IBOutlet var viewUnderway: UIView!
    //Charging
    @IBOutlet var imgCharging: UIImageView!
    //Received
    @IBOutlet var imgReceived: UIImageView!
    @IBOutlet var viewReceived: UIView!
    
    @IBOutlet var TotalPaid: UILabel!
    @IBOutlet var lblDay: UILabel!
    
    @IBOutlet var viewDetailsIsUser: UIView!
    @IBOutlet var viewDetailsIsSeller: UIView!
    @IBOutlet var viewOrderDetailsBut : UIButton!
    
    var products = [Product]()
    
    var viewOrderDetails : (()->())!
    var changeOrderStatus : (()->())!
    
    var deleteDeleget: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableview.registerCell(id: "CurrentTableViewCell")
                
        if(CurrentUser.typeSelect == userType.User){
            viewDetailsIsUser.isHidden = false
            viewDetailsIsSeller.isHidden = true
        }
        else{
            viewDetailsIsUser.isHidden = true
            viewDetailsIsSeller.isHidden = false
            
        }
        UIView.animate(withDuration: 1) {
            self.heighttableViewCell.constant =  100
            self.contentView.layoutIfNeeded()
        }
    }
    
    var obj : CustomerOrders? {
        didSet{
            lblOrderNumber.text = obj?.orderId ?? "0"
            lblOrderDate.text = obj?.orderDate ?? "undefined".localized
            TotalPaid.text = obj?.totalPrice ?? "0"
            lblDay.text = obj?.deliverDate ?? "undefined".localized
            
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
          
            if(obj?.products != nil && obj?.products?.count != 0){
                obj!.products!.forEach{
                    products.append($0)
                }
                self.heighttableViewCell.constant = CGFloat((obj!.products!.count) * 100)
                tableview.reloadData()

            }
            tableview.delegate = self
            tableview.dataSource = self
          
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    
    @IBAction func tapViewOrderDetails(_ sender: UIButton) {
        viewOrderDetails?()
    }
    @IBAction func tapChangeOrderStatus(_ sender: UIButton) {
        changeOrderStatus?()
    }
    
    
}

extension CurrentCVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "CurrentTableViewCell", for: indexPath) as! CurrentTableViewCell
            cell.obj = products[indexPath.row]
        
//        if (self.obj?.orderProcess == "1" || self.obj?.orderProcess == "2" || self.obj?.orderProcess == "3" || self.obj?.orderProcess == "-1"){
//            cell.deleteProdectBut.isHidden = true
//        }else{
//            cell.deleteProdectBut.isHidden = false
//        }
        
        cell.deleteDeleget = { [weak self] in
            guard let strongSelf =  self else {  return }
            strongSelf.deleteDeleget?()
            
        }
        return cell
    }
    
    
}
