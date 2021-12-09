//
//  FavoritesCVC.swift
//  Forbrands
//
//  Created by osamaaassi on 06/08/2021.
//

import UIKit

class FavoritesCVC: UITableViewCell {

    @IBOutlet weak var lblTitle:         UILabel!
    @IBOutlet weak var lblDescrption:    UILabel!
    @IBOutlet weak var lblPrice:         UILabel!
    @IBOutlet weak var lblDiscount:      UILabel!
    @IBOutlet weak var lblDiscountPrice: UILabel!
    @IBOutlet weak var lblState:         UILabel!
    @IBOutlet weak var viewBut:          UIView!
    @IBOutlet weak var img:              UIImageView!
    @IBOutlet weak var titleButCard:     UILabel!
    @IBOutlet weak var favoritesBut:     UIButton!
    @IBOutlet weak var imgBut:           UIImageView!


    var isFavorites : (() -> ())?
    var addToCard : (() -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    var obj : Product?{
        didSet{
            let objs =  obj
            lblTitle.text = MOLHLanguage.isArabic() ? objs?.nameAr ?? "" : objs?.nameEn ?? ""
            lblDescrption.text = MOLHLanguage.isArabic() ? objs?.detailsAr ?? "" : objs?.detailsEn ?? ""
          
            
            if(objs?.price == nil || objs?.price == "0"){
                lblPrice.text = objs!.oldPrice?.description ?? ""
                lblDiscountPrice.text = "0"
            }else{
                lblPrice.text = objs!.price?.description ?? ""
                lblDiscountPrice.text = objs!.oldPrice?.description ?? ""
            }
            
            
            if(objs?.images?.count != 0){
                img.sd_custom(url: "\(App.IMG_URL.img_URL)\(objs!.images![0] )" ,defultImage: UIImage(named: "defultImg") )
            }
            
            if objs?.status == "1" {
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
                favoritesBut.setImage(UIImage(named: "starFill"), for: .normal)
            }
            
        }
    }
    
    var objPro : Product?{
        didSet{
           
            lblTitle.text = MOLHLanguage.isArabic() ? objPro?.nameAr ?? "" : objPro?.nameEn ?? ""
            lblDescrption.text = MOLHLanguage.isArabic() ? objPro?.detailsAr ?? "" : objPro?.detailsEn ?? ""
            
            if(objPro?.price == nil || objPro?.price == "0"){
                lblPrice.text = objPro!.oldPrice?.description ?? ""
                lblDiscountPrice.text = "0"
            }else{
                lblPrice.text = objPro!.price?.description ?? ""
                lblDiscountPrice.text = objPro!.oldPrice?.description ?? ""
            }
            
            
            if(objPro?.images?.count != 0){
                img.sd_custom(url: "\(App.IMG_URL.img_URL)\(objPro!.images![0] )" ,defultImage: UIImage(named: "defultImg") )
            }
            
            if objPro?.status == "1" {
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
                let nameImg = objPro?.favorite == true ? "starFill" : "myFavorites"
                favoritesBut.setImage(UIImage(named: nameImg), for: .normal)
            }
            
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tapAddtoCard(_ sender: UIButton) {
        addToCard?()
    }
    
    @IBAction func tapAddFavorites(_ sender: UIButton) {
        isFavorites?()
    }
    
}
