//
//  AddImgProductCVC.swift
//  Forbrands
//
//  Created by osamaaassi on 11/08/2021.
//

import UIKit

class AddImgProductCVC: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    var addImgDeleget : ((_ sender: UIButton) -> ())!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func tapDeleteButton(_ sender: UIButton) {
        addImgDeleget?(sender)
    }

}
