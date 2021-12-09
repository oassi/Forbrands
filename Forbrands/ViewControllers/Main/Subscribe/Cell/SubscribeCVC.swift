//
//  SubscribeCVC.swift
//  Forbrands
//
//  Created by osamaaassi on 28/08/2021.
//

import UIKit

class SubscribeCVC: UITableViewCell {

    
    @IBOutlet weak var lblFeatures: UILabel!
    @IBOutlet weak var img: UIImageView!
    
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
