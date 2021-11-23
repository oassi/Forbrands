//
//  PaymentMethodsCell.swift
//  Forbrands
//
//  Created by osamaaassi on 13/08/2021.
//

import UIKit

class PaymentMethodsCell: UITableViewCell {

    @IBOutlet weak var lblNamePayment: UILabel!
    @IBOutlet weak var imgPayment: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
        // Configure the view for the selected state
    }
    
}
