//
//  ProductsCVC.swift
//  Forbrands
//
//  Created by osamaaassi on 18/08/2021.
//

import UIKit

class ProductsCVC: UICollectionViewCell {

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
            
            
            if let imgs = obj?.images , !imgs.isEmpty , !imgs[0].isEmpty{
                self.img.sd_custom(url: "\(App.IMG_URL.img_URL)\(imgs[0])" ,defultImage: UIImage(named: "defultImg") )
            }
            
        }
    }

}
