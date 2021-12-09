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
    
    var categories = [CategoriesHome]()
    var storesHome = [StoresHome]()
    
    
    var searchBar = UISearchBar()
    var searchValue:String?
    var idSelection = 0
    
    
    
//    StoresHome
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
 
    override func viewWillAppear(_ animated: Bool) {
        reloadDate()
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

    func reloadDate()  {
        storesHome.removeAll()
        categories.removeAll()
        getStoresHome()
        getCategories()
    }
    
    func reloadStoreDate()  {
        storesHome.removeAll()
        getStoresHome()
    }


    override func didClickRightButton(_sender: UIBarButtonItem) {
        guard CurrentUser.typeSelect != userType.Guest else {
            App.logout(self)
            return
        }
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
    
    
    func getStoresHome(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.storesList ,isAuthRequired:  false).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataArrayResponse<StoresHome>.self, from: response.data!)
                if Status.code == 200{
                    guard Status.data != nil else {
                        return
                    }
                    self.storesHome += Status.data!
                    self.collectionview2.reloadData()
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
    func getCategories(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.categoriesList ,isAuthRequired:  false).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataArrayResponse<CategoriesHome>.self, from: response.data!)
                if Status.code == 200{
                    guard Status.data != nil else {
                        return
                    }
                    self.categories += Status.data!
                    self.collectionview1.reloadData()
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
    
    
}

extension StoresVC: UICollectionViewDelegate,UICollectionViewDataSource{
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == collectionview1) {
            return categories.count + 1
        }
        if (collectionView == collectionview2) {
            return storesHome.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == collectionview1){
            let cell :CategoryCVC = collectionView.dequeue(cellForItemAt: indexPath)
            
            if(indexPath.row == 0){
                cell.lblTitle.text = "All".localized
            }
            else{
                cell.obj = categories[indexPath.row-1]
            }
            
            
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
            let cell :StoresCVC = collectionView.dequeue(cellForItemAt: indexPath)
            cell.obj = storesHome[indexPath.row]
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView  == collectionview1) {
            idSelection = indexPath.row
            
            if(indexPath.row == 0 ){
                reloadStoreDate()
                collectionview1.reloadData()
            }else{
                collectionview1.reloadData()
                let vc:CategoriesVC = CategoriesVC.loadFromNib()
                vc.titleNav = categories[indexPath.row-1].name ?? "Categories"
                vc.categoryId =  categories[indexPath.row-1].id?.description ?? "0"
                vc.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(vc, animated: true)
            }
          

        }
        
        if (collectionView  == collectionview2) {
            let vc:MyStoreVC = MyStoreVC.loadFromNib()
            vc.imgStore = storesHome[indexPath.row].image ?? ""
            vc.id = storesHome[indexPath.row].id?.description ?? "0"
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
            let text :String
            if indexPath.row == 0{
                text = "All".localized
            }else{
                text = categories[indexPath.item-1].name?.description ?? ""
            }
            widths = estimateFrameForText(text).width + 50
            return CGSize(width: widths, height:41)
        }
        if(collectionView == collectionview2){
            let width =  (self.view.frame.size.width - 40)/2
            return CGSize(width: width, height:180)
        }
        return CGSize(width: 0, height: 0)
         
    }
    


}

