//
//  DetailsProductVC.swift
//  Forbrands
//
//  Created by osamaaassi on 12/08/2021.
//

import UIKit
import Cosmos
class DetailsProductVC: SuperViewController {

    @IBOutlet weak var collectionview1:UICollectionView!
    @IBOutlet weak var collectionview2:UICollectionView!
    
    @IBOutlet var lblStoreName: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet weak var lblDescrption:    UILabel!
    @IBOutlet weak var lblPrice:         UILabel!
    @IBOutlet weak var lblDiscountPrice:      UILabel!
    @IBOutlet var lblProductDetails: UILabel!
    @IBOutlet var lblRate: UILabel!
    @IBOutlet var lblReviews: UILabel!
    @IBOutlet weak var ViewRate: CosmosView!
    
    
    var lest = ["100","200","3000","4","5","6","7","8","9","10"]
    var idSelection:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        registerCell()
        // Do any additional setup after loading the view.
    }
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
    }
    private  func registerCell(){
        let nib1 = UINib(nibName: "PackageSizeCVC", bundle: .main)
        let nib2 = UINib(nibName: "RatingsProductCVC", bundle: .main)
        collectionview1.register(nib1, forCellWithReuseIdentifier: "PackageSizeCVC")
        collectionview2.register(nib2, forCellWithReuseIdentifier: "RatingsProductCVC")
    }


    @IBAction func tapIsAvailbleButton(_ sender: UIButton) {
        if(!sender.isSelected){
            sender.isSelected = true
        }else{
            sender.isSelected = false
        }
    }
    @IBAction func tapShowAllRatings(_ sender: UIButton) {
        let vc:RatingsVC = RatingsVC.loadFromNib()
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
   

}

extension DetailsProductVC: UICollectionViewDelegate,UICollectionViewDataSource{
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == collectionview1) {
            return 5
        }
        if (collectionView == collectionview2) {
            return 5
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == collectionview1){
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "PackageSizeCVC", for: indexPath) as! PackageSizeCVC
            cell.lblSize.text = lest[indexPath.row]
            
           
            if (idSelection == indexPath.row){
                cell.lblSize.textColor = UIColor(named: "primary")
                cell.viewSize.borderColor = UIColor(named: "primary")
            }
            else{
                cell.lblSize.textColor = UIColor(named: "alert")
                cell.viewSize.borderColor = UIColor(named: "alert")
            }
            
            return cell
        }
        if(collectionView == collectionview2){
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "RatingsProductCVC", for: indexPath) as! RatingsProductCVC

            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView  == collectionview1) {
            idSelection = indexPath.row
            collectionview1.reloadData()
        }
        
        if (collectionView  == collectionview2) {
//            let vc:MyStoreVC = MyStoreVC.loadFromNib()
//            vc.hidesBottomBarWhenPushed = true
//            vc.modalPresentationStyle = .fullScreen
//            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
}

extension DetailsProductVC: UICollectionViewDelegateFlowLayout{
    
  
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
      //  var widths : CGFloat = 80
        if(collectionView == collectionview1){
//            let text = lest[indexPath.item]
//            widths = estimateFrameForText(text).width + 50
            let width =  (self.view.frame.size.width - 40 )/3
            return CGSize(width: width, height:54)
        }
        if(collectionView == collectionview2){
            let width =  (self.view.frame.size.width )/1.2
            return CGSize(width: width, height:117)
        }
        return CGSize(width: 0, height: 0)
         
    }
    


}
