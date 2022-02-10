//
//  HomeCell.swift
//  Forbrands
//
//  Created by osamaaassi on 08/08/2021.
//

import UIKit

class HomeCell: UICollectionViewCell {

    
    @IBOutlet weak var lblTitle:         UILabel!
    @IBOutlet weak var lblPrice:         UILabel!
    @IBOutlet weak var lblDiscount:      UILabel!
    @IBOutlet weak var lblDiscountPrice: UILabel!
    @IBOutlet weak var lblState:         UILabel!
    @IBOutlet weak var img:              UIImageView!
    @IBOutlet weak var titleButCard:     UILabel!
    @IBOutlet weak var viewBut:          UIView!
    @IBOutlet weak var viewDiscountBut:  UIView!
    @IBOutlet weak var favoritesBut:     UIButton!
    @IBOutlet weak var imgBut:           UIImageView!
    
    var addToCard : (() -> ())?
    var isFavorites : (() -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var obj : Product?{
        didSet{
            lblTitle.text = obj?.nameAr ?? obj?.nameEn ?? ""
            
            if(obj?.price == nil || obj?.price == "0"){
                lblPrice.text = obj!.oldPrice?.description ?? ""
                lblDiscountPrice.text = "0"
            }else{
                lblPrice.text = obj!.price?.description ?? ""
                lblDiscountPrice.text = obj!.oldPrice?.description ?? ""
            }
            
            
            if(obj?.images?.count != 0){
                img.sd_custom(url: "\(App.IMG_URL.img_URL)\(obj!.images?[0] ?? "" )" ,defultImage: UIImage(named: "defultImg") )
            }
            if obj?.status == "1" {
                lblState.text = "available".localized
                lblState.textColor =  UIColor(named: "green")
                titleButCard.text = "Add to card".localized
                titleButCard.textColor =  UIColor(named: "white")
                viewBut.backgroundColor = UIColor(named: "primary")
                imgBut.isHidden = false
            }
            else{
                lblState.text = "unavailable at the moment".localized
                lblState.textColor =  UIColor(named: "redBut")

                titleButCard.text = "Notify me upon arrival".localized
                titleButCard.textColor =  UIColor(named: "primary")
                viewBut.backgroundColor = UIColor(named: "grey")
                imgBut.isHidden = true

            }
            if CurrentUser.typeSelect != userType.Guest{
                let nameImg = obj?.favorite == true ? "starFill" : "myFavorites"
                favoritesBut.setImage(UIImage(named: nameImg), for: .normal)
            }
        }
    }

    @IBAction func tapAddtoCard(_ sender: UIButton) {
        addToCard?()
    }
    
    @IBAction func tapAddFavorites(_ sender: UIButton) {
        isFavorites?()
    }
}
