//
//  RatingsCVC.swift
//  Forbrands
//
//  Created by osamaaassi on 05/08/2021.
//

import UIKit
import Cosmos
class RatingsCVC: UITableViewCell {

    @IBOutlet var lblName:       UILabel!
    @IBOutlet var lblDate:       UILabel!
    @IBOutlet var lblComment:    UILabel!
    @IBOutlet var img:           UIImageView!
    @IBOutlet weak var ViewRate: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        
//        ViewRate.rating = Double(comments?.ratingStar ?? "0.0" )!
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
