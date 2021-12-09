//
//  StoresCVC.swift
//  Forbrands
//
//  Created by osamaaassi on 06/08/2021.
//

import UIKit

class StoresCVC: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var img:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var obj : StoresHome? {
        didSet{
            lblTitle.text = obj?.name ?? ""
            img.sd_custom(url: "\(App.IMG_URL.img_URL)\(obj?.image ?? "")" ,defultImage: UIImage(named: "defultImg") )
        }
        
    }
}
