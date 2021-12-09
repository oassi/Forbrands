//
//  AddAddressCVC.swift
//  Forbrands
//
//  Created by osamaaassi on 05/08/2021.
//

import UIKit

class AddAddressCVC: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAddressOne: UILabel!
    @IBOutlet weak var lblAddressTwo: UILabel!
    @IBOutlet weak var lblAddressThree: UILabel!
    @IBOutlet weak var lblMoble: UILabel!
    @IBOutlet weak var addressSelectImg: UIImageView!
    
    var editAddress : (() -> ())?
    
    @IBOutlet weak var deleteButton: UIButton!
    var deleteButtonAction: (()-> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
        // Configure the view for the selected state
    }
    
    var addressList : AddressList? {
        didSet{
            lblAddressOne.text = addressList?.stateName ?? ""
            lblAddressTwo.text = "\(addressList?.cityName ?? "") , \(addressList?.street ?? "")"
            lblAddressThree.text = "Floor".localized + " \(addressList?.floor?.description ?? "") , " + "Apartment".localized + " \(addressList?.apartment?.description ?? "") , " + "Building".localized + " \(addressList?.building?.description ?? "")"
            lblMoble.text = (addressList?.phone ?? "")
        }
    }
    
    
    
    
    @IBAction func tapEditAdders(_ sender: UIButton) {
        editAddress?()
    }
    @IBAction func deleteButton(_ sender: Any) {
        deleteButtonAction?()
    }
}
