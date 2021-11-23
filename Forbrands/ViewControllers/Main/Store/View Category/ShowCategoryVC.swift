//
//  ShowCategoryVC.swift
//  Forbrands
//
//  Created by osamaaassi on 11/08/2021.
//

import UIKit

class ShowCategoryVC: SuperViewController {
    @IBOutlet weak var collectionview:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        registerCell()
        // Do any additional setup after loading the view.
    }
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setTitle("Men's perfume".localized, sender: self, large: false)
        navgtion.setRightButtons([navgtion.searchNavBut!], sender: self)
        navgtion.setCustomBackButtonForViewController(sender: self)
    }
    private  func registerCell(){
        let nib1 = UINib(nibName: "ViewCategoriesSellerVC", bundle: .main)
        collectionview.register(nib1, forCellWithReuseIdentifier: "ViewCategoriesSellerVC")
    }
    @IBAction func tapAddProductButton(_sender: UIButton) {
        let vc:AddProductVC = AddProductVC.loadFromNib()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func didClickRightButton(_sender: UIBarButtonItem) {
        let vc:SearchSellerVC = SearchSellerVC.loadFromNib()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension ShowCategoryVC : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewCategoriesSellerVC", for: indexPath) as! ViewCategoriesSellerVC
        
        cell.deleteDeleget = {   [weak self]  in
            guard let strongSelf = self else { return }
            strongSelf.showAlertWithCancel(title: "Do you want to delete this product?".localized, message: "", okAction: "Delete") { (UIAlertAction) in
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc:DetailsProductVC = DetailsProductVC.loadFromNib()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
}

extension ShowCategoryVC:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width =  (self.view.frame.size.width )/2
        return CGSize(width: width, height:302)
    }
}
