//
//  CategoryCVC.swift
//  Forbrands
//
//  Created by osamaaassi on 06/08/2021.
//

import UIKit

class CategoryCVC: UICollectionViewCell {

    @IBOutlet weak var lblTitle:     UILabel!
    @IBOutlet weak var viewCategory: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var obj : CategoriesHome?{
        didSet{
            lblTitle.text = MOLHLanguage.isArabic() ? obj?.nameAr ?? "Categories".localized : obj?.nameEn ?? "Categories".localized
        }
    }
    

}
