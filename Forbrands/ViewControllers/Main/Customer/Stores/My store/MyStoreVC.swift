//
//  MyStoreVC.swift
//  Forbrands
//
//  Created by osamaaassi on 07/08/2021.
//

import UIKit

class MyStoreVC: SuperViewController {
    
    @IBOutlet weak var collectionview1:UICollectionView!
    @IBOutlet weak var collectionview2:UICollectionView!
    var lest = ["الكل","عطور نسائي","عطور رجالي","معطرات منازل","4","5","6","7","8","9","10"]
    var idSelection = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        registerCell()
        
        // Do any additional setup after loading the view.
    }

    private  func registerCell(){
        let nib1 = UINib(nibName: "CategoryCVC", bundle: .main)
        collectionview1.register(nib1, forCellWithReuseIdentifier: "CategoryCVC")
        
        let nib = UINib(nibName: "HomeCell", bundle: nil)
        collectionview2.register(nib, forCellWithReuseIdentifier: "HomeCell")
        
        collectionview2.register(UINib(nibName: "HeaderStoreCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: "HeaderStoreCell")

    }
    
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setTitle(" ".localized, sender: self, large: false)
        navgtion.setCustomBackButtonForViewController(sender: self)
    }


}

extension MyStoreVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == collectionview1) {
            return 10
        }
        if (collectionView == collectionview2) {
            return 10
        }
        return 0
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == collectionview1) {
            
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCVC", for: indexPath) as! CategoryCVC
            cell.lblTitle.text = lest[indexPath.row]
            
            if (idSelection == indexPath.row){
                cell.lblTitle.textColor = .white
                cell.viewCategory.backgroundColor = UIColor(named: "primary")
            }
            else{
                cell.lblTitle.textColor = UIColor(named: "primary")
                cell.viewCategory.backgroundColor = UIColor(named: "background")
            }
            
            return cell
        }
        
        if (collectionView == collectionview2) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
            
            cell.addToCard = { [weak self] in
                guard let strongSelf = self else { return }
                let vc:PopAddCardVC = PopAddCardVC.loadFromNib()
                vc.modalPresentationStyle = .overFullScreen
                strongSelf.present(vc, animated: false)
            }
            return cell
        }
        
      
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1
        switch kind {
        // 2
        case UICollectionView.elementKindSectionHeader:
            // 3
            guard let headerView = collectionView.dequeueReusableSupplementaryView( ofKind: kind, withReuseIdentifier: "\(HeaderStoreCell.self)", for: indexPath) as? HeaderStoreCell  else { fatalError("Invalid view type") }
            
            headerView.imgView.image = #imageLiteral(resourceName: "img")

            return headerView
        default:
            // 4
            assert(false, "Invalid element type")
            return UICollectionReusableView()
        }
    }
    
   

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var widths : CGFloat = 80
        if(collectionView == collectionview1){
            let text = lest[indexPath.item]
            widths = estimateFrameForText(text).width + 50
            return CGSize(width: widths, height:41)
        }
        if (collectionView == collectionview2) {
            let width =  (self.view.frame.size.width)/2
            return CGSize(width: width, height:290)
         
        }
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if (collectionView == collectionview2) {
            return CGSize(width: (view.frame.size.width), height:(view.frame.size.width/2))
        }
        return CGSize(width: 0, height:0)
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView  == collectionview1) {
            idSelection = indexPath.row
            collectionview1.reloadData()
        }
        
//        if (collectionView  == collectionview2) {
//            let vc:MyStoreVC = MyStoreVC.loadFromNib()
//            vc.hidesBottomBarWhenPushed = true
//            vc.modalPresentationStyle = .fullScreen
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
    }
    

}   
