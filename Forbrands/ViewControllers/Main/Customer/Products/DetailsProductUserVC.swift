//
//  DetailsProductUserVC.swift
//  Forbrands
//
//  Created by osamaaassi on 16/08/2021.
//

import UIKit
import Cosmos
import FittedSheets
import FSPagerView

class DetailsProductUserVC: SuperViewController {
    
    
    @IBOutlet weak var collectionview1:    UICollectionView!
    @IBOutlet weak var collectionview2:    UICollectionView!
    @IBOutlet weak var collectionview3:    UICollectionView!
    @IBOutlet weak var collectionview4:    UICollectionView!
    @IBOutlet weak var viewCollectionview2: UIStackView!
    
    @IBOutlet weak var lblStoreName:       UILabel!
    @IBOutlet weak var lblStatus:          UILabel!
    @IBOutlet weak var lblTitle:           UILabel!
    @IBOutlet weak var lblDescrption:      UILabel!
    @IBOutlet weak var lblPrice:           UILabel!
    @IBOutlet weak var lblDiscountPrice:   UILabel!
    @IBOutlet weak var lblProductDetails:  UILabel!
    @IBOutlet weak var lblRate:            UILabel!
    @IBOutlet weak var lblReviews:         UILabel!
    @IBOutlet weak var lblCount :          UILabel!
    @IBOutlet weak var lblIsReturn :       UILabel!
    @IBOutlet weak var favoritesBut:       UIButton!
    @IBOutlet weak var ViewRate:           CosmosView!
    @IBOutlet weak var ViewReviewsProduct: CosmosView!
    
    
    
    var sizes = [String]()
    var idSelection:Int = 0
    
    var product = [Product]()
    var productId = 0
    var isCart:Bool = false
    var isAds:Bool = false
    
    var productAndReviews : ProductAndReviews?
    var relatedproducts = [ProductAndReviews]()
    var imgProduct = [String]()
    var reviews = [Reviews]()
    var favorite : Bool?
    var card =  loads()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        registerCell()
        getProduct()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        reloadCard()
    }
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
        navigationController?.navigationBar.tintColor = getColorApp()
    }
    
    override func backButtonAction(_sender: UIBarButtonItem) {
        if isAds{
            if CurrentUser.userInfo == nil {
                register(LoginVC.loadFromNib().navigationController())
            }else{
                if(CurrentUser.userInfo!.roleName == "Trader"
                   && CurrentUser.userInfo!.store == nil
                   && CurrentUser.userTrader == nil){
                    UserDefaults.standard.set(true, forKey: "isNotCompleteData")
                    register(StoreInformationVC.loadFromNib().navigationController())
                }else{
                    register(TTabBarController())
                }
            }
        }else{
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    func register<T>(_ a: T) {
        let vc = a
        (vc as! UIViewController).modalPresentationStyle = .fullScreen
        self.goToRoot(vc as! UIViewController)
    }
    
    func reloadCard()  {
        card.removeAll()
        card = loads()
    }
    private  func registerCell(){
        let nib1 = UINib(nibName: "PackageSizeCVC", bundle: .main)
        let nib2 = UINib(nibName: "RatingsProductCVC", bundle: .main)
        let nib3 = UINib(nibName: "DetailsProducCVC", bundle: .main)
        collectionview1.register(nib1, forCellWithReuseIdentifier: "PackageSizeCVC")
        collectionview2.register(nib2, forCellWithReuseIdentifier: "RatingsProductCVC")
        collectionview3.register(nib3, forCellWithReuseIdentifier: "DetailsProducCVC")
        collectionview4.register(nib3, forCellWithReuseIdentifier: "DetailsProducCVC")
        
    }
    @IBOutlet weak var pagerView: FSPagerView!{
        didSet{
            self.pagerView.automaticSlidingInterval = 3.0
            self.pagerView.isScrollEnabled = true
            self.pagerView.register(UINib(nibName: "SliderProducatCell", bundle: Bundle.main), forCellWithReuseIdentifier: "SliderProducatCell")
        }
    }
    
    
    
    @IBAction func tapShowAllRatings(_ sender: UIButton) {
        let vc:RatingsVC = RatingsVC.loadFromNib()
        vc.productID = productId
        poushVC(vc,.fullScreen,true)
        
    }
    @IBAction func tapEvaluation(_ sender: UIButton) {
        let controller = PopEvaluationServiceVC()
        let sheet = SheetViewController(controller: controller, sizes: [.fixed(600)])
        sheet.extendedLayoutIncludesOpaqueBars = false
        self.present(sheet, animated: false, completion: nil)
    }
    
    @IBAction func tapShareApp(_ sender: UIButton) {
        let shareAll = ["\(lblStoreName.text ?? "")",
                        "\(lblDescrption.text ?? "")",
                        "\(lblTitle.text ?? "")",
                        "\(lblPrice.text ?? "")",
                        "\(lblProductDetails.text ?? "")",
                        "\(imgProduct.first ?? "")"] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll as [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        
        
    }
    @IBAction func tapIsFavorite(_ sender: UIButton) {
        
        if(favorite == false){
            App.fav(self, id: productId.description ) { [weak self] bool in
                if bool{
                    self?.getProduct()
                }
            }
        }else{
            App.unFav(self, id: productId.description) { [weak self] bool in
                if bool{
                    self?.getProduct()
                }
            }
        }
        
    }
    
    @IBAction func tappPlusCount(_ sender: UIButton) {
        if (lblCount.text! >= "1"){
            lblCount.text = String(Int(lblCount.text!)! + 1)
        }
    }
    @IBAction func tappMinCount(_ sender: UIButton) {
        if (lblCount.text! > "1"){
            lblCount.text = String(Int(lblCount.text!)! - 1)
        }
    }
    
    //    func addPro() -> CardItem {
    //        let cardItems : CardItem
    //
    //        if(productAndReviews?.price == nil || productAndReviews?.price == "0"){
    //            cardItems = CardItem(id: productAndReviews?.id ?? 0, nameAr: productAndReviews?.nameAr ?? "", nameEn: productAndReviews?.nameEn ?? "", detailsAr: productAndReviews?.detailsAr ?? "", detailsEn: productAndReviews?.detailsEn ?? "", oldPrice: Int(productAndReviews?.price ?? "0"), price: Int(productAndReviews?.oldPrice ?? "0"), images: productAndReviews?.images?.first, count: Int(lblCount.text!)!)
    //
    //        }else{
    //            cardItems = CardItem(id: productAndReviews?.id ?? 0, nameAr: productAndReviews?.nameAr ?? "", nameEn: productAndReviews?.nameEn ?? "", detailsAr: productAndReviews?.detailsAr ?? "", detailsEn: productAndReviews?.detailsEn ?? "", oldPrice: Int(productAndReviews?.oldPrice ?? "0"), price: Int(productAndReviews?.price ?? "0"), images: productAndReviews?.images?.first, count: Int(lblCount.text!)!)
    //        }
    //        return cardItems
    //    }
    @IBAction func tapAddToCard(_ sender: UIButton) {
        if CurrentUser.typeSelect == userType.Guest || CurrentUser.typeSelect == userType.Seller || CurrentUser.userInfo == nil{
            App.logout(self)
        }else{
            if(productAndReviews?.status == 1){
                var parameters = [String : String]()
                parameters["product_id"] = productAndReviews?.id?.description ?? "0"
                parameters["quantity"] = lblCount.text?.description
                App.addCart(self, parameters: parameters) { bool in
                    let controller = PopAddCardVC()
                    controller.goTocard = { [weak self] in
                        if self!.isCart {
                            self?.navigationController?.popViewController(animated: true)
                        }
                        else if self!.isAds {
                            let vc = TTabBarController()
                            vc.modalPresentationStyle = .fullScreen
                            vc.selectedIndex = 2
                            self?.goToRoot(vc)
                        }
                        
                        else{
                            self?.tabBarController?.selectedIndex = 2
                        }
                        
                    }
                    let sheet = SheetViewController(controller: controller, sizes: [.fixed(290)])
                    sheet.extendedLayoutIncludesOpaqueBars = false
                    self.present(sheet, animated: false, completion: nil)}
            }
            else{
                let controller = PopNotAvailableProduectVC()
                let sheet = SheetViewController(controller: controller, sizes: [.fixed(220)])
                sheet.extendedLayoutIncludesOpaqueBars = false
                self.present(sheet, animated: false, completion: nil)
            }
        }
        
        //        if CurrentUser.typeSelect == userType.Guest{
        //            App.logout(self)
        //        }else{
        //            if(productAndReviews?.status == 1){
        //                var isCard = true
        //                let cardItems =  addPro()
        //                if(!self.card.isEmpty){
        //                    if (self.card.contains(where: { $0.id == productAndReviews?.id })){
        //                        for (k,i) in card.enumerated(){
        //                            if(i.id == productAndReviews?.id){
        //                                card[k] = addPro()
        //                                save(card)
        //                            }
        //                        }
        //
        //                        self.showAlert(title: "", message: "Updata Card".localized)
        //                        isCard = true
        //                    }
        //                    else{
        //                        self.card.append(cardItems)
        //                        save(self.card)
        //                    }
        //
        //                }else{
        //                    save([cardItems])
        //                    self.reloadCard()
        //
        //                }
        //                if(isCard){
        //                    let controller = PopAddCardVC()
        //                    controller.goTocard = { [weak self] in
        //                        self?.tabBarController?.selectedIndex = 2
        //                    }
        //                    let sheet = SheetViewController(controller: controller, sizes: [.fixed(290)])
        //                    sheet.extendedLayoutIncludesOpaqueBars = false
        //                    self.present(sheet, animated: false, completion: nil)}
        //
        //            }else{
        //                let controller = PopNotAvailableProduectVC()
        //                let sheet = SheetViewController(controller: controller, sizes: [.fixed(220)])
        //                sheet.extendedLayoutIncludesOpaqueBars = false
        //                self.present(sheet, animated: false, completion: nil)
        //            }
        //        }
        //
        //
        
        
        //        let controller = PopAddCardVC()
        //        controller.goTocard = { [weak self] in
        //            self?.tabBarController?.selectedIndex = 2
        //        }
        //        let sheet = SheetViewController(controller: controller, sizes: [.fixed(290)])
        //        sheet.extendedLayoutIncludesOpaqueBars = false
        //        self.present(sheet, animated: false, completion: nil)
    }
    
    
    func getProduct(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.getProduct,nestedParams: productId.description ,isAuthRequired:  false).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<ProductAndRelated>.self, from: response.data!)
                
                guard  Status.code == 200, let obj = Status.data?.product else{
                    self.showAlert(title: Status.title ?? "", message: Status.message ?? "")
                    return
                }
                self.productAndReviews = obj
                self.lblStoreName.text = obj.storeName ?? ""
                self.lblTitle.text = obj.nameAr ?? ""
                self.lblDescrption.text = obj.nameEn ?? ""
                self.lblStatus.text = obj.status == 1 ? "available".localized : "unavailable".localized
                
                self.lblIsReturn.text = obj.returnProduct == "1" ? "returnable".localized : "not returnable".localized
                
                if(obj.price == "0"){
                    self.lblPrice.text = obj.oldPrice ?? "0"
                    self.lblDiscountPrice.text = "\(obj.price ?? "0") "+"SAR".localized
                }else{
                    self.lblPrice.text = obj.price ?? "0"
                    self.lblDiscountPrice.text = "\(obj.oldPrice ?? "0") "+"SAR".localized
                }
                
                
                self.lblProductDetails.text = MOLHLanguage.isArabic() ? obj.detailsAr ?? "" : obj.detailsEn ?? ""
                self.lblRate.text = obj.reviewsAverage?.description ?? "0"
                self.ViewRate.rating  = Double(obj.reviewsAverage ?? "0")!
                self.lblReviews.text = obj.reviewsCount?.description ?? "0"
                if(obj.images != nil && obj.images!.count > 0){
                    obj.images!.forEach{
                        self.imgProduct.append("\(App.IMG_URL.img_URL)" + $0)
                    }
                    self.pagerView.reloadData()
                }
                if(obj.reviews != nil && obj.reviews!.count > 0){
                    obj.reviews?.forEach{ self.reviews.append($0)}
                    self.viewCollectionview2.isHidden = false
                    self.collectionview2.reloadData()
                }else{
                    self.viewCollectionview2.isHidden = true
                }
                
                if(obj.sizes != nil && obj.sizes!.count > 0){
                    obj.sizes?.forEach{ self.sizes.append($0)}
                    self.collectionview1.reloadData()
                }
                
                if CurrentUser.typeSelect != userType.Guest{
                    self.favorite = obj.favorite
                    let nameImg = obj.favorite == true ? "starFill" : "myFavorites"
                    self.favoritesBut.setImage(UIImage(named: nameImg), for: .normal)
                }
                
                
                
                
                guard let objRelatedProducts = Status.data?.relatedproducts , objRelatedProducts.count > 0 else {
                    return
                }
                
                objRelatedProducts.forEach{ self.relatedproducts.append($0) }
                self.collectionview3.reloadData()
                
                
                
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
    
    
    fileprivate func poushVC(_ vc:UIViewController ,_ modaStyle:UIModalPresentationStyle ,_ hidesBottomBar :Bool , _ typePush:Bool = true){
        vc.modalPresentationStyle = modaStyle
        vc.hidesBottomBarWhenPushed = hidesBottomBar
        if(typePush){
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            self.present(vc, animated: false, completion: nil)
        }
    }
    
}


extension DetailsProductUserVC: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == collectionview1) {
            return sizes.count
        }
        if (collectionView == collectionview2) {
            return reviews.count
        }
        if (collectionView == collectionview3) {
            return relatedproducts.count
        }
        if (collectionView == collectionview4) {
            return 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == collectionview1){
            let cell :PackageSizeCVC = collectionView.dequeue(cellForItemAt: indexPath)
            cell.lblSize.text = sizes[indexPath.row]
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
            let cell :RatingsProductCVC = collectionView.dequeue(cellForItemAt: indexPath)
            let obj = reviews[indexPath.row]
            cell.obj = obj
            return cell
        }
        if(collectionView == collectionview3){
            let cell :DetailsProducCVC = collectionView.dequeue(cellForItemAt: indexPath)
            let obj = relatedproducts[indexPath.row]
            cell.obj = obj
            
            cell.addToCard = { [weak self] in
                guard let strongSelf = self else { return }
                if CurrentUser.typeSelect == userType.Guest{
                    App.logout(self)
                }else{
                    if(obj.status == 1){
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
            
            return cell
        }
        if(collectionView == collectionview4){
            let cell :DetailsProducCVC = collectionView.dequeue(cellForItemAt: indexPath)
            cell.addToCard = { [weak self] in
                guard let strongSelf = self else { return }
                let controller = PopAddCardVC()
                controller.goTocard = { [weak self] in
                    self?.tabBarController?.selectedIndex = 2
                }
                let sheet = SheetViewController(controller: controller, sizes: [.fixed(290)])
                sheet.extendedLayoutIncludesOpaqueBars = false
                strongSelf.present(sheet, animated: false, completion: nil)
            }
            
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
        if (collectionView  == collectionview3) {
            
            let vc:DetailsProductUserVC = DetailsProductUserVC.loadFromNib()
            let obj = relatedproducts[indexPath.row]
            vc.productId = obj.id ?? 0
            vc.hidesBottomBarWhenPushed = true
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        }
        if (collectionView  == collectionview4) {
            
        }
    }
}

extension DetailsProductUserVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == collectionview1){
            let width =  (self.view.frame.size.width - 40 )/3
            return CGSize(width: width, height:54)
        }
        if(collectionView == collectionview2){
            let width =  (self.view.frame.size.width )/1.2
            return CGSize(width: width, height:117)
        }
        let width =  (self.view.frame.size.width )/2.4
        return CGSize(width: width, height: 270)
        
    }
}

extension DetailsProductUserVC:FSPagerViewDelegate,FSPagerViewDataSource{
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imgProduct.count
    }
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "SliderProducatCell", at: index) as! SliderProducatCell
        cell.imgProducta.sd_custom(url: (imgProduct[index]))
        //self.pageControlle.currentPage = pagerView.currentIndex
        cell.imgProducta?.contentMode = .scaleToFill
        return cell
    }
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        // self.pageControlle.currentPage = pagerView.currentIndex
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        //self.pageControlle.currentPage = targetIndex
    }
}
