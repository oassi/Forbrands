//
//  HomeCell.swift
//  Forbrands
//
//  Created by osamaaassi on 08/08/2021.
//

import UIKit

class HomeCell: UICollectionViewCell {

    
    @IBOutlet weak var lblTitle:         UILabel!
    @IBOutlet weak var lblPrice:         UILabel!
    @IBOutlet weak var lblDiscount:      UILabel!
    @IBOutlet weak var lblDiscountPrice: UILabel!
    @IBOutlet weak var lblState:         UILabel!
    @IBOutlet weak var img:              UIImageView!
    @IBOutlet weak var viewBut:          UIView!
    @IBOutlet weak var viewDiscountBut:  UIView!
    
    var addToCard : (() -> ())?
    var isFavorites : (() -> ())?
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
