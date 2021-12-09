//
//  CategorySellerCVC.swift
//  Forbrands
//
//  Created by osamaaassi on 10/08/2021.
//

import UIKit

class CategorySellerCVC: UICollectionViewCell {
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var img:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    var obj : CategoriesHome?{
        didSet{
            lblTitle.text = obj?.name ?? ""
            img.sd_custom(url: (obj?.logo ?? ""),defultImage: UIImage(named: "defultImg"))

        }
    }

}
