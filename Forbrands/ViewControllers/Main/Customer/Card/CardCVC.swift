//
//  CardCVC.swift
//  Forbrands
//
//  Created by osamaaassi on 09/08/2021.
//

import UIKit

class CardCVC: UITableViewCell {

    @IBOutlet weak var lblTitle:         UILabel!
    @IBOutlet weak var lblDescrption:    UILabel!
    @IBOutlet weak var lblPrice:         UILabel!
    @IBOutlet weak var lblDiscountPrice: UILabel!
    @IBOutlet weak var img:              UIImageView!
    @IBOutlet weak var lblCount :        UILabel!
    var deleteToCard : (()->())?
    var updataCard : ((_ id:Int) ->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var obj : Cart?{
        didSet{
            guard obj != nil else {
                return
            }
            lblTitle.text = obj?.name ?? ""
            lblDescrption.text = obj?.category ?? ""
            lblCount.text = obj?.quantity?.description ?? "1"
            
            if(obj?.price == nil || obj?.price == 0){
                lblPrice.text = obj!.oldPrice?.description ?? ""
                lblDiscountPrice.text = "0"
            }else{
                lblPrice.text = obj!.price?.description ?? ""
                lblDiscountPrice.text = obj!.oldPrice?.description ?? ""
            }
            if let imgs = obj?.images , !imgs.isEmpty {
                img.sd_custom(url: "\(App.IMG_URL.img_URL)\(imgs.first ?? "" )" )

            }
           
        
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
        // Configure the view for the selected state
    }
    
    @IBAction func tapDeleteCard(_ sender: UIButton) {
        deleteToCard?()
    }
    @IBAction func tappPlusCount(_ sender: UIButton) {
        if (lblCount.text! >= "1"){
            lblCount.text = String(Int(lblCount.text!)! + 1)
            updataCard?(Int(lblCount.text?.description ?? "0")!)
//            obj?.count = Int(lblCount.text!)!
//            var card =  loads()
//            for (k,i) in card.enumerated(){
//                if(i.id == obj?.id){
//                    card[k] = obj!
//                    save(card)
//                    updataCard?()
//                }
//            }
            
        }
    }
    @IBAction func tappMinCount(_ sender: UIButton) {
        if (lblCount.text! > "1"){
            lblCount.text = String(Int(lblCount.text!)! - 1)
            updataCard?(Int(lblCount.text?.description ?? "0")!)
          
            
            
//            obj?.count = Int(lblCount.text!)!
//            var card =  loads()
//            for (k,i) in card.enumerated(){
//                if(i.id == obj?.id){
//                    card[k] = obj!
//                    save(card)
//                    updataCard?()
//                }
//            }
        }
    }
    
}
