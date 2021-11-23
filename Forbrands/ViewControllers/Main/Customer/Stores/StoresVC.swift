//
//  StoresVC.swift
//  Forbrands
//
//  Created by osamaaassi on 06/08/2021.
//

import UIKit

class StoresVC: SuperViewController, UISearchBarDelegate, UITextFieldDelegate,UIScrollViewDelegate {

    @IBOutlet weak var collectionview1:UICollectionView!
    @IBOutlet weak var collectionview2:UICollectionView!
    @IBOutlet weak var scrollView:UIScrollView!
    
    var searchBar = UISearchBar()
    var searchValue:String?
    var idSelection = 0
    
    var lest = ["الكل","عطور نسائي","عطور رجالي","معطرات منازل","4","5","6","7","8","9","10"]
    var lest2 = ["1","2","3","4","5","6","7","8","9","10"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.keyboardDismissMode = .onDrag
        searchBar.delegate = self
        scrollView.delegate = self
        registerCell()
        navButtons()
        
       // setupNavBar()
        // Do any additional setup after loading the view.
    }
    
    
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setRightButtons([navgtion.notificaltionBut!,navgtion.favoritesBut!], sender: self)
        
        let search =   navgtion.setupSearchBar(serach: searchBar)
        search.delegate = self
        search.searchTextField.delegate = self
        let leftNavBarButton = UIBarButtonItem(customView:search)
        navgtion.setLeftsButtons([leftNavBarButton], sender: self)
    }
 
    override func viewWillDisappear(_ animated: Bool) {
        searchBar.endEditing(true)
    }
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let vc:SearchVC = SearchVC.loadFromNib()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
        return true
    }

    


    override func didClickRightButton(_sender: UIBarButtonItem) {
        switch _sender.tag {
        case 77:
            let vc:FavoritesVC = FavoritesVC.loadFromNib()
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        case 66:
            let vc:NotificationsVC = NotificationsVC.loadFromNib()
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    private  func registerCell(){
        let nib1 = UINib(nibName: "CategoryCVC", bundle: .main)
        let nib2 = UINib(nibName: "StoresCVC", bundle: .main)
        collectionview1.register(nib1, forCellWithReuseIdentifier: "CategoryCVC")
        collectionview2.register(nib2, forCellWithReuseIdentifier: "StoresCVC")
    }
    
}

extension StoresVC: UICollectionViewDelegate,UICollectionViewDataSource{
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == collectionview1) {
            return lest.count
        }
        if (collectionView == collectionview2) {
            return lest2.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == collectionview1){
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
        if(collectionView == collectionview2){
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "StoresCVC", for: indexPath) as! StoresCVC
            
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
            let vc:MyStoreVC = MyStoreVC.loadFromNib()
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
}

extension StoresVC: UICollectionViewDelegateFlowLayout{
    
  
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var widths : CGFloat = 80
        if(collectionView == collectionview1){
            let text = lest[indexPath.item]
            widths = estimateFrameForText(text).width + 50
            return CGSize(width: widths, height:41)
        }
        if(collectionView == collectionview2){
            let width =  (self.view.frame.size.width - 40)/2
            return CGSize(width: width, height:190)
        }
        return CGSize(width: 0, height: 0)
         
    }
    


}

