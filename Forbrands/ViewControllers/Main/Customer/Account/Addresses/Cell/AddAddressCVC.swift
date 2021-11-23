//
//  AddAddressCVC.swift
//  Forbrands
//
//  Created by osamaaassi on 05/08/2021.
//

import UIKit

class AddAddressCVC: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAddressOne: UILabel!
    @IBOutlet weak var lblAddressTwo: UILabel!
    @IBOutlet weak var lblAddressThree: UILabel!
    @IBOutlet weak var lblMoble: UILabel!
    @IBOutlet weak var addressSelectImg: UIImageView!
    
    var editAddress : (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tapEditAdders(_ sender: UIButton) {
        editAddress?()
    }
   
}
