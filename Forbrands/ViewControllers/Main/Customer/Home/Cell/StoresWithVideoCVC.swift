//
//  StoresWithVideoCVC.swift
//  Forbrands
//
//  Created by osamaaassi on 18/08/2021.
//

import UIKit

class StoresWithVideoCVC: UICollectionViewCell {

    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblDetail:UILabel!
    @IBOutlet weak var img:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var obj : StoresWithVideoHome? {
        didSet{
            lblName.text = obj?.name ?? ""
            lblDetail.text = obj?.detail ?? ""
   
            if let imgs = obj?.image , !imgs.isEmpty{
                self.img.sd_custom(url: "\(App.IMG_URL.img_URL)\(imgs)" ,defultImage: UIImage(named: "defultImg") )
            }else{
                img.image = UIImage(named: "defultImg")
            }
        }
    }

    
}
