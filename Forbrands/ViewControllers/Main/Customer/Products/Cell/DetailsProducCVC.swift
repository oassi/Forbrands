//
//  DetailsProducCVC.swift
//  Forbrands
//
//  Created by osamaaassi on 16/08/2021.
//

import UIKit

class DetailsProducCVC: UICollectionViewCell {

    @IBOutlet weak var lblTitle:         UILabel!
    @IBOutlet weak var lblPrice:         UILabel!
    @IBOutlet weak var lblDiscount:      UILabel!
    @IBOutlet weak var lblDiscountPrice: UILabel!
    @IBOutlet weak var lblState:         UILabel!
    @IBOutlet weak var img:              UIImageView!
    @IBOutlet weak var viewDiscount:     UIView!
    
    var isFavorites : (() -> ())?
    var addToCard : (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func tapAddtoCard(_ sender: UIButton) {
        addToCard?()
    }
    
    @IBAction func tapAddFavorites(_ sender: UIButton) {
        isFavorites?()
    }
    

}
