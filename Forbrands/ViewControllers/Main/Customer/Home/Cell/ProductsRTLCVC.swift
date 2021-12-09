//
//  ProductsRTLCVC.swift
//  Forbrands
//
//  Created by osamaaassi on 28/08/2021.
//

import UIKit

class ProductsRTLCVC: UICollectionViewCell {

    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblCategory:UILabel!
    @IBOutlet weak var lblDescription:UILabel!
    @IBOutlet weak var img:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var obj : Product? {
        didSet{
            guard obj != nil else {
                return
            }
            lblName.text =  MOLHLanguage.isArabic() ? obj?.nameAr ?? "" : obj?.nameEn ?? ""
            lblDescription.text =  MOLHLanguage.isArabic() ? obj?.detailsAr ?? "" : obj?.detailsEn ?? ""
            lblCategory.text = obj?.category ?? ""
            
            if(obj?.images?.count != 0){
                img.sd_custom(url: "\(App.IMG_URL.img_URL)\(obj!.images?[0] ?? "" )" ,defultImage: UIImage(named: "defultImg") )
            }
        }
    }

}
