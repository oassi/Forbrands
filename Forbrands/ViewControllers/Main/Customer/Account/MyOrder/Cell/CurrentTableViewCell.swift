//
//  CurrentTableViewCell.swift
//  Forbrands
//
//  Created by osamaaassi on 15/08/2021.
//

import UIKit

class CurrentTableViewCell: UITableViewCell {

    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblCount: UILabel!
    @IBOutlet var img: UIImageView!
    @IBOutlet var deleteProdectBut: UIButton!
    var deleteDeleget: (()->())?

    var obj :Product?{
        didSet{
            lblTitle.text = MOLHLanguage.isArabic() ? obj?.nameAr ?? "" : obj?.nameEn ?? ""
            lblCount.text =  obj?.amount?.description ?? ""
            if(obj?.images?.count != 0 && obj?.images != nil){
                img.sd_custom(url: "\(App.IMG_URL.img_URL)\(obj!.images?[0] ?? "")" ,defultImage: UIImage(named: "defultImg") )
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func deleteProdect(_ sender:UIButton){
        deleteDeleget?()
    }
    
}
