//
//  ViewCategoriesSellerVC.swift
//  Forbrands
//
//  Created by osamaaassi on 11/08/2021.
//

import UIKit

class ViewCategoriesSellerVC: UICollectionViewCell {

    @IBOutlet weak var lblTilte         : UILabel!
    @IBOutlet weak var lblPrice         : UILabel!
    @IBOutlet weak var lblDescountPrice : UILabel!
    @IBOutlet weak var img              : UIImageView!
    @IBOutlet weak var viewDescount     : UIView!
    
    var deleteDeleget : (() -> ())!
    var editDeleget : (() -> ())!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func tapIsAvailbleButton(_ sender: UIButton) {
        if(!sender.isSelected){
            sender.isSelected = true
        }else{
            sender.isSelected = false
        }
    }
    @IBAction func tapDeleteButton(_ sender: UIButton) {
        deleteDeleget?()
    }
    @IBAction func tapEditButton(_ sender: UIButton) {
        editDeleget?()
    }
}
