//
//  SearchResultSellerCVC.swift
//  Forbrands
//
//  Created by osamaaassi on 11/08/2021.
//

import UIKit

class SearchResultSellerCVC: UITableViewCell {

    
    @IBOutlet weak var lblTitle:         UILabel!
    @IBOutlet weak var lblDescrption:    UILabel!
    @IBOutlet weak var lblPrice:         UILabel!
    @IBOutlet weak var lblDiscount:      UILabel!
    @IBOutlet weak var img:              UIImageView!

    var deleteDeleget : (() -> ())!
    var editDeleget : (() -> ())!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tapIsAvailbleButton(_ sender: UIButton) {
        if(!sender.isSelected){
            sender.isSelected = true
        }else{
            sender.isSelected = false
        }
    }
    @IBAction func tapDeleteButton(_ sender: UIButton) {
        deleteDeleget?()
    }
    @IBAction func tapEditButton(_ sender: UIButton) {
        editDeleget?()
    }
    
}
