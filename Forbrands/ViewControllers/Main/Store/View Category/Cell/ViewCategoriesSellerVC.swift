//
//  ViewCategoriesSellerVC.swift
//  Forbrands
//
//  Created by osamaaassi on 11/08/2021.
//

import UIKit

class ViewCategoriesSellerVC: UICollectionViewCell {

    @IBOutlet weak var lblTilte             : UILabel!
    @IBOutlet weak var lblPrice             : UILabel!
    @IBOutlet weak var lblDescountPrice     : UILabel!
    @IBOutlet weak var img                  : UIImageView!
    @IBOutlet weak var viewDescount         : UIView!
    @IBOutlet weak var editBut              : UIButton!
    @IBOutlet weak var isAvailbleButton     : UIButton!
    
    var deleteDeleget : (() -> ())!
    var editDeleget : (() -> ())!
    var changeStatusDeleget : (() -> ())!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    var obj : ProductsByStoreCat? {
        didSet{
            lblTilte.text = obj?.name ?? ""
            
            
            if(obj?.price == nil || obj?.price == 0){
                lblPrice.text = obj?.oldPrice?.description ?? ""
                lblDescountPrice.text = "0"
            }else{
                lblPrice.text = obj?.price?.description ?? ""
                lblDescountPrice.text = obj?.oldPrice?.description ?? ""
            }
            
            
            img.sd_custom(url: "\(App.IMG_URL.img_URL)\(obj?.images ?? "")" ,defultImage: UIImage(named: "defultImg") )
            
            isAvailbleButton.isSelected = obj?.status == 1 ? true : false
           
        }
        
    }
    
    @IBAction func tapIsAvailbleButton(_ sender: UIButton) {
//        if(!sender.isSelected){
//            sender.isSelected = true
//        }else{
//            sender.isSelected = false
//        }
        changeStatusDeleget?()
    }
    @IBAction func tapDeleteButton(_ sender: UIButton) {
        deleteDeleget?()
    }
    @IBAction func tapEditButton(_ sender: UIButton) {
        editDeleget?()
    }
}
