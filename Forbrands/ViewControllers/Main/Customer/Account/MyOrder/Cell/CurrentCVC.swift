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
    @IBOutlet var imgUnderway: UIImageView!
    @IBOutlet var viewUnderway: UIView!
    //Charging
    @IBOutlet var imgCharging: UIImageView!
    //Received
    @IBOutlet var imgReceived: UIImageView!
    @IBOutlet var viewReceived: UIView!
    
    @IBOutlet var TotalPaid: UILabel!
    @IBOutlet var lblDay: UILabel!
    @IBOutlet var lblExpectedDeliveryDate: UILabel!
    
    var viewOrderDetails : (()->())!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableview.registerCell(id: "CurrentTableViewCell")
        tableview.delegate = self
        tableview.dataSource = self
        
        UIView.animate(withDuration: 1) {
            self.heighttableViewCell.constant = 105
            self.contentView.layoutIfNeeded()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func tableviewRelodData(){
        self.heighttableViewCell.constant = 2 * 105
        tableview.reloadData()
    }
    
    @IBAction func tapViewOrderDetails(_ sender: UIButton) {
        viewOrderDetails?()
    }
    
}

extension CurrentCVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "CurrentTableViewCell", for: indexPath) as! CurrentTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.heighttableViewCell.constant = 2 * 105
    }
    
}
