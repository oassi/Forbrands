//
//  RatingsProductCVC.swift
//  Forbrands
//
//  Created by osamaaassi on 13/08/2021.
//

import UIKit
import Cosmos
class RatingsProductCVC: UICollectionViewCell {

    @IBOutlet var lblName:       UILabel!
    @IBOutlet var lblDate:       UILabel!
    @IBOutlet var lblComment:    UILabel!
    @IBOutlet var img:           UIImageView!
    @IBOutlet weak var ViewRate: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
