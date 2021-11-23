//
//  FavoritesCVC.swift
//  Forbrands
//
//  Created by osamaaassi on 06/08/2021.
//

import UIKit

class FavoritesCVC: UITableViewCell {

    @IBOutlet weak var lblTitle:         UILabel!
    @IBOutlet weak var lblDescrption:    UILabel!
    @IBOutlet weak var lblPrice:         UILabel!
    @IBOutlet weak var lblDiscount:      UILabel!
    @IBOutlet weak var lblDiscountPrice: UILabel!
    @IBOutlet weak var lblState:         UILabel!
    @IBOutlet weak var isAddImage:       UIImageView!
    @IBOutlet weak var viewBut:          UIView!
    
    var isFavorites : (() -> ())?
    var addToCard : (() -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tapAddtoCard(_ sender: UIButton) {
        addToCard?()
    }
    
    @IBAction func tapAddFavorites(_ sender: UIButton) {
        isFavorites?()
    }
    
}
