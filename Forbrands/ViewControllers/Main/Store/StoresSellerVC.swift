//
//  StoresSellerVC.swift
//  Forbrands
//
//  Created by osamaaassi on 10/08/2021.
//

import UIKit

class StoresSellerVC: SuperViewController {
    @IBOutlet weak var collectionview:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        registerCell()
        // Do any additional setup after loading the view.
    }
    
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navigationController?.navigationBar.tintColor = UIColor(named: "primary")
        navgtion.setLeftsButtons([navgtion.titleNavStore!], sender: self)
        navgtion.setRightButtons([navgtion.notificaltionBut!], sender: self)
       
    }

    private  func registerCell(){
        let nib1 = UINib(nibName: "CategorySellerCVC", bundle: .main)
        collectionview.register(nib1, forCellWithReuseIdentifier: "CategorySellerCVC")
        
        collectionview.register(UINib(nibName: "HeaderStoreSellerCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: "HeaderStoreSellerCell")
    }
    
    override func didClickRightButton(_sender: UIBarButtonItem) {
        switch _sender.tag {
        case 66:
            let vc:NotificationsVC = NotificationsVC.loadFromNib()
            vc.hidesBottomBarWhenPushed = true
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }

    @IBAction func tapAddProductButton(_sender: UIButton) {
        let vc:AddProductVC = AddProductVC.loadFromNib()
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension StoresSellerVC : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "CategorySellerCVC", for: indexPath) as! CategorySellerCVC
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc:ShowCategoryVC = ShowCategoryVC.loadFromNib()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //header View
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            case UICollectionView.elementKindSectionHeader:
                guard let headerView = collectionView.dequeueReusableSupplementaryView( ofKind: kind, withReuseIdentifier: "\(HeaderStoreSellerCell.self)", for: indexPath) as? HeaderStoreSellerCell  else { fatalError("Invalid view type") }
            
            headerView.imgView.image = #imageLiteral(resourceName: "img")
            return headerView
        default:
            assert(false, "Invalid element type")
            return UICollectionReusableView()
        }
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: (view.frame.size.width), height:(view.frame.size.width/2))
    }
    
}

extension StoresSellerVC:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width =  (self.view.frame.size.width)/2
        return CGSize(width: width, height:140)
    }
}
