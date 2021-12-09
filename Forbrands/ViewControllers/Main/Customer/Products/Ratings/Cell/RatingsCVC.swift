//
//  RatingsCVC.swift
//  Forbrands
//
//  Created by osamaaassi on 05/08/2021.
//

import UIKit
import Cosmos
class RatingsCVC: UITableViewCell {

    @IBOutlet var lblName:       UILabel!
    @IBOutlet var lblDate:       UILabel!
    @IBOutlet var lblComment:    UILabel!
    @IBOutlet var img:           UIImageView!
    @IBOutlet weak var ViewRate: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        
//        ViewRate.rating = Double(comments?.ratingStar ?? "0.0" )!
    }
    
    var obj : Reviews? {
        didSet{
            lblName.text =  obj?.userName ?? ""
            lblDate.text =  obj?.date ?? ""
            lblComment.text =  obj?.comment ?? ""
            ViewRate.rating =  Double(obj?.rating ?? "0.0")!
            img.sd_custom(url: "\(App.IMG_URL.img_URL)\(obj?.userImage ?? "" )" ,defultImage: UIImage(named: "defultImg") )
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
