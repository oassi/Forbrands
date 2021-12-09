//
//  RatingsProductCVC.swift
//  Forbrands
//
//  Created by osamaaassi on 13/08/2021.
//

import UIKit
import Cosmos
class RatingsProductCVC: UICollectionViewCell {

    @IBOutlet var lblName:       UILabel!
    @IBOutlet var lblDate:       UILabel!
    @IBOutlet var lblComment:    UILabel!
    @IBOutlet var img:           UIImageView!
    @IBOutlet weak var ViewRate: CosmosView!
    
    
    var obj : Reviews? {
        didSet{
            lblName.text =  obj?.userName ?? ""
            lblDate.text =  obj?.date ?? ""
            lblComment.text =  obj?.comment ?? ""
            ViewRate.rating =  Double(obj?.rating ?? "0")!
            img.sd_custom(url: "\(App.IMG_URL.img_URL)\(obj?.userImage ?? "" )" ,defultImage: UIImage(named: "defultImg") )
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
