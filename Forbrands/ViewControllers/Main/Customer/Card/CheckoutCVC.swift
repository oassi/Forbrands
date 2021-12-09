//
//  CheckoutCVC.swift
//  Forbrands
//
//  Created by osamaaassi on 14/08/2021.
//

import UIKit

class CheckoutCVC: UITableViewCell {

    @IBOutlet weak var name:UILabel!
    @IBOutlet weak var price:UILabel!
    @IBOutlet weak var oldprice:UILabel!
    @IBOutlet weak var amount:UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var product : Products? {
        didSet {
            name.text = product?.name ?? ""
            price.text = product?.price?.description ?? ""
            amount.text = product?.amount?.description ?? ""
            oldprice.text = product?.oldprice?.description ?? ""
        }
    }
    
}
