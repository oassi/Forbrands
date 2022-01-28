//
//  MyStoreVC.swift
//  Forbrands
//
//  Created by osamaaassi on 07/08/2021.
//

import UIKit
import FittedSheets
class MyStoreVC: SuperViewController, UISearchBarDelegate {
    
    @IBOutlet weak var collectionview1:UICollectionView!
    @IBOutlet weak var collectionview2:UICollectionView!
    lazy var searchBars:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.bounds.width - 120, height: 40))
    
    var categories = [CategoriesHome]()
    var productByStoreAuth = [Product]()
    var imgStore : String?
    var id : String?
    var idSelection = 0
    var card =  loads()
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        registerCell()
        
        // Do any additional setup after loading the view.
        
        storePolicy(id?.description ?? "0")
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func reloadData()  {
        categories.removeAll()
        getCategories()
        
    }
    
    func reloadDataProduct()  {
        productByStoreAuth.removeAll()
        CurrentUser.typeSelect == userType.Guest ? getProductByStore() :  getProductByStoreAuth()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        reloadData()
        reloadDataProduct()
        reloadCard()
    }
    
    func reloadCard()  {
        card.removeAll()
        card = loads()
    }
    private  func registerCell(){
        let nib1 = UINib(nibName: "CategoryCVC", bundle: .main)
        collectionview1.register(nib1, forCellWithReuseIdentifier: "CategoryCVC")
        
        let nib = UINib(nibName: "HomeCell", bundle: nil)
        collectionview2.register(nib, forCellWithReuseIdentifier: "HomeCell")
        
        collectionview2.register(UINib(nibName: "HeaderStoreCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: "HeaderStoreCell")
        
    }
    func storePolicy( _ id:String){
            _ = WebRequests.setup(controller: self).prepare(api: Endpoint.storePolicy,parameters: ["id" : id ] ,isAuthRequired:  true).start(){ (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<StorePolicy>.self, from: response.data!)
                if Status.code == 200{
                    if Status.data != nil{
                        if Status.data?.statusPolicy != 0 {
                            let controller = PopStorePolicy()
                            controller.storePolicy = Status.data!.storePolicy
                            let sheet = SheetViewController(controller: controller, sizes: [.marginFromTop(200)])
                            sheet.extendedLayoutIncludesOpaqueBars = true
                            self.present(sheet, animated: false, completion: nil)
                        }
                    }
                  
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
    
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setTitle(" ".localized, sender: self, large: false)
        navgtion.setCustomBackButtonForViewController(sender: self)
        
        searchBars.delegate = self
        searchBars.tintColor = .black
        searchBars.searchTextField.textColor = .black
        searchBars.showsCancelButton = false
        searchBars.placeholder = "Search for".localized
        searchBars.sizeToFit()
        searchBars.searchTextField.backgroundColor =  UIColor(named: "searchbar")
        let leftNavBarButton = UIBarButtonItem(customView: searchBars)
        navgtion.setRightButtons([leftNavBarButton], sender: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchBars.endEditing(true)
    }
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let vc:SearchVC = SearchVC.loadFromNib()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
        return true
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
    
    func getProductByStoreAuth(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.productsByStoreAuth,nestedParams: id! ,isAuthRequired:  true).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataArrayResponse<Product>.self, from: response.data!)
                if Status.code == 200{
                    guard Status.data != nil else {
                        return
                    }
                    self.productByStoreAuth += Status.data!
                    self.collectionview2.reloadData()
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
    func getProductByStore(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.productsByStore,nestedParams: id! ,isAuthRequired:  false).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataArrayResponse<Product>.self, from: response.data!)
                if Status.code == 200{
                    guard Status.data != nil else {
                        return
                    }
                    self.productByStoreAuth += Status.data!
                    self.collectionview2.reloadData()
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
    
}

extension MyStoreVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == collectionview1) {
            return categories.count + 1
        }
        if (collectionView == collectionview2) {
            return productByStoreAuth.count
        }
        return 0
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == collectionview1) {
            
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
        
        if (collectionView == collectionview2) {
            let cell :HomeCell = collectionView.dequeue(cellForItemAt: indexPath)
            let obj = productByStoreAuth[indexPath.row]
            cell.obj = obj
            cell.addToCard = { [weak self] in
                guard let strongSelf = self else { return }
                if CurrentUser.typeSelect == userType.Guest{
                    App.logout(self)
                }else{
                    if(obj.status == "1"){
                        var parameters = [String : String]()
                        parameters["product_id"] = obj.id?.description ?? "0"
                        parameters["quantity"] = "1"
                        App.addCart(strongSelf, parameters: parameters) { bool in
                            let controller = PopAddCardVC()
                            controller.goTocard = { [weak self] in
                                self?.tabBarController?.selectedIndex = 2
                            }
                            let sheet = SheetViewController(controller: controller, sizes: [.fixed(290)])
                            sheet.extendedLayoutIncludesOpaqueBars = false
                            strongSelf.present(sheet, animated: false, completion: nil)}
                    }
                    else{
                        let controller = PopNotAvailableProduectVC()
                        let sheet = SheetViewController(controller: controller, sizes: [.fixed(220)])
                        sheet.extendedLayoutIncludesOpaqueBars = false
                        strongSelf.present(sheet, animated: false, completion: nil)
                    }
                }
                
            }
        
//                if CurrentUser.typeSelect == userType.Guest{
//                    App.logout(self)
//                }else{
//                    if(obj.status == "1"){
//                        var isCard = true
//                        let cardItems : CardItem
//
//                        if(obj.price == nil || obj.price == "0"){
//                            cardItems = CardItem(id: obj.id ?? 0, nameAr: obj.nameAr ?? "", nameEn: obj.nameEn ?? "", detailsAr: obj.detailsAr ?? "", detailsEn: obj.detailsEn ?? "", oldPrice: Int(obj.price ?? "0"), price: Int(obj.oldPrice ?? "0"), images: obj.images?.first, count: 1)
//
//                        }else{
//                            cardItems = CardItem(id: obj.id ?? 0, nameAr: obj.nameAr ?? "", nameEn: obj.nameEn ?? "", detailsAr: obj.detailsAr ?? "", detailsEn: obj.detailsEn ?? "", oldPrice: Int(obj.oldPrice ?? "0"), price: Int(obj.price ?? "0"), images: obj.images?.first, count: 1)
//                        }
//                        if(!strongSelf.card.isEmpty){
//                            if (strongSelf.card.contains(where: { $0.id == obj.id })){
//                                strongSelf.showAlert(title: "", message: "The product is already in the basket".localized)
//                                isCard = false
//                            }
//                            else{
//                                strongSelf.card.append(cardItems)
//                                save(strongSelf.card)
//                            }
//
//                        }else{
//                            save([cardItems])
//                            strongSelf.reloadCard()
//
//                        }
//                        if(isCard){
//                            let controller = PopAddCardVC()
//                            controller.goTocard = { [weak self] in
//                                self?.tabBarController?.selectedIndex = 2
//                            }
//                            let sheet = SheetViewController(controller: controller, sizes: [.fixed(290)])
//                            sheet.extendedLayoutIncludesOpaqueBars = false
//                            strongSelf.present(sheet, animated: false, completion: nil)}
//
//                    }else{
//                        let controller = PopNotAvailableProduectVC()
//                        let sheet = SheetViewController(controller: controller, sizes: [.fixed(220)])
//                        sheet.extendedLayoutIncludesOpaqueBars = false
//                        strongSelf.present(sheet, animated: false, completion: nil)
//                    }
//                }
//            }
            cell.isFavorites = {[weak self] in
                guard let strongSelf = self else { return }
                if(obj.favorite != nil){
                    if(obj.favorite == false){
                        App.fav(strongSelf, id: obj.id?.description ?? "") { bool in
                            if bool{
                                strongSelf.reloadDataProduct()
                            }
                        }
                    }else{
                        App.unFav(strongSelf, id: obj.id?.description ?? "") { bool in
                            if bool{
                                strongSelf.reloadDataProduct()
                            }
                        }
                    }
                }
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
            let img = App.IMG_URL.img_URL + (imgStore ?? "")
            headerView.imgView.sd_custom(url: img)
            
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
            let text :String
            if indexPath.row == 0{
                text = "All".localized
            }else{
                if MOLHLanguage.isArabic() {
                    text = categories[indexPath.item-1].nameAr ?? "Categories".localized
                }else{
                    text = categories[indexPath.item-1].nameEn ?? "Categories".localized
                }
            }
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
            if(indexPath.row == 0 ){
                reloadDataProduct()
                collectionview1.reloadData()
            }else{
                collectionview1.reloadData()
                let vc:CategoriesVC = CategoriesVC.loadFromNib()
                vc.titleNav = MOLHLanguage.isArabic() ? categories[indexPath.row-1].nameAr ?? "Categories".localized : categories[indexPath.row-1].nameEn ?? "Categories".localized

                vc.categoryId =  categories[indexPath.row-1].id?.description ?? "0"
                vc.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        
        
        if (collectionView  == collectionview2) {
            let vc:DetailsProductUserVC = DetailsProductUserVC.loadFromNib()
            vc.productId = productByStoreAuth[indexPath.row].id ?? 0
            vc.hidesBottomBarWhenPushed = true
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}   
