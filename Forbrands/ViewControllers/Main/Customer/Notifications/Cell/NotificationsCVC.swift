//
//  NotificationsCVC.swift
//  Forbrands
//
//  Created by osamaaassi on 05/08/2021.
//

import UIKit

class NotificationsCVC: UITableViewCell {

    @IBOutlet weak var lblTitle:      UILabel!
    @IBOutlet weak var lblDescrption: UILabel!
    @IBOutlet weak var lblDate:       UILabel!
    @IBOutlet weak var img:           UIImageView!
    @IBOutlet weak var viewIsNew:     UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
