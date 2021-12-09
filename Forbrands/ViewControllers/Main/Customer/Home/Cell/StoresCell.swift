//
//  StoresCell.swift
//  Forbrands
//
//  Created by osamaaassi on 18/08/2021.
//

import UIKit

class StoresCell: UICollectionViewCell {

    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var img:UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var objStore : StoresHome? {
        didSet{
            lblTitle.text = objStore?.name ?? ""
            
            img.sd_custom(url: "\(App.IMG_URL.img_URL)\(objStore?.image ?? "")" ,defultImage: UIImage(named: "defultImg") )
            
            
        }
    }
    
    
    var obj : CategoriesHome? {
        didSet{
            lblTitle.text = obj?.name ?? ""
            img.sd_custom(url: obj?.logo ?? "",defultImage: UIImage(named: "defultImg"))
        }
    }
}
