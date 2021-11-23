//
//  SizeProductCVC.swift
//  Forbrands
//
//  Created by osamaaassi on 11/08/2021.
//

import UIKit

class SizeProductCVC: UICollectionViewCell {
    @IBOutlet weak var lblSize: UILabel!
    var deleteDeleget : (() -> ())!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func tapDeleteButton(_ sender: UIButton) {
        deleteDeleget?()
    }
}
