//
//  AddProductImgCVC.swift
//  Forbrands
//
//  Created by osamaaassi on 11/08/2021.
//

import UIKit

class AddProductImgCVC: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    var deleteDeleget : (() -> ())!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func tapDeleteButton(_ sender: UIButton) {
        deleteDeleget?()
    }
}
