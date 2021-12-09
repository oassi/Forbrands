//
//  AdsProductHomeCVC.swift
//  Forbrands
//
//  Created by osamaaassi on 18/08/2021.
//

import UIKit

class AdsProductHomeCVC: UICollectionViewCell {

    @IBOutlet weak var img:UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var obj : AdsHome? {
        didSet{
            img.sd_custom(url: obj?.image ?? "")
        }
    }

}
