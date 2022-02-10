//
//  DetailsProductVC.swift
//  Forbrands
//
//  Created by osamaaassi on 12/08/2021.
//

import UIKit
import Cosmos
import FSPagerView
class DetailsProductVC: SuperViewController {

    @IBOutlet weak var collectionview1:   UICollectionView!
    @IBOutlet weak var collectionview2:   UICollectionView!
    @IBOutlet weak var viewCollectionview2: UIStackView!
    @IBOutlet weak var lblStoreName:      UILabel!
    @IBOutlet weak var lblTitle:          UILabel!
    @IBOutlet weak var lblDescrption:     UILabel!
    @IBOutlet weak var lblPrice:          UILabel!
    @IBOutlet weak var lblDiscountPrice:  UILabel!
    @IBOutlet weak var lblProductDetails: UILabel!
    @IBOutlet weak var lblRate:           UILabel!
    @IBOutlet weak var lblReviews:        UILabel!
    @IBOutlet weak var isAvailbleButton:  UIButton!
    @IBOutlet weak var ViewRate:          CosmosView!
    var imgProduct = [String]()
    var reviews = [Reviews]()
    var sizes = [String]()
    var ProdectId:Int = 0

    var idSelection:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        registerCell()
        getProduct()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        lblStoreName.textColor = getColorApp()
    }
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
        navgtion.setRightButtons([navgtion.deletelProduct!,navgtion.editProduct!], sender: self)
        
    }
    private  func registerCell(){
        let nib1 = UINib(nibName: "PackageSizeCVC", bundle: .main)
        let nib2 = UINib(nibName: "RatingsProductCVC", bundle: .main)
        collectionview1.register(nib1, forCellWithReuseIdentifier: "PackageSizeCVC")
        collectionview2.register(nib2, forCellWithReuseIdentifier: "RatingsProductCVC")
    }
    
    override func didClickRightButton(_sender: UIBarButtonItem) {
        switch _sender.tag {
        case 120:
            print("deletel Product")
            self.showAlertWithCancel(title: "Do you want to delete this product?".localized, message: "", okAction: "Delete".localized) { (UIAlertAction) in
                App.deleteProducts(self, id: self.ProdectId.description) { bool in
                    if bool{
                        self.navigationController?.popViewController(animated: false)
                    }
                }
            }
        case 130:
            print("Edit Product")
            let vc:AddProductVC = AddProductVC.loadFromNib()
            vc.isEdit = true
            vc.productId = self.ProdectId.description
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
            
        default:
            break
        }
    }

    @IBOutlet weak var pagerView: FSPagerView!{
        didSet{
            self.pagerView.automaticSlidingInterval = 3.0
            self.pagerView.isScrollEnabled = true
            self.pagerView.register(UINib(nibName: "SliderProducatCell", bundle: Bundle.main), forCellWithReuseIdentifier: "SliderProducatCell")
        }
    }
    
    @IBAction func tapIsAvailbleButton(_ sender: UIButton) {
//        if(!sender.isSelected){
//            sender.isSelected = true
//        }else{
//            sender.isSelected = false
//        }
    }
    @IBAction func tapShowAllRatings(_ sender: UIButton) {
        let vc:RatingsVC = RatingsVC.loadFromNib()
        vc.productID = ProdectId
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getProduct(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.getProductTrader,nestedParams: ProdectId.description ,isAuthRequired:  false).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<ProductAndReviews>.self, from: response.data!)
                
                guard Status.code == 200, let obj =  Status.data else{
                    self.showAlert(title: Status.title ?? "", message: Status.message ?? "")
                    return
                }
                
                self.lblStoreName.text = obj.storeName ?? ""
                self.lblTitle.text = obj.nameAr ?? ""
                self.lblDescrption.text = obj.nameEn ?? ""
                self.isAvailbleButton.isSelected = obj.status == 1 ? true : false
                
                
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
                if(obj.images != nil){
                    obj.images!.forEach{
                        self.imgProduct.append("\(App.IMG_URL.img_URL)" + $0)
                    }
                    self.pagerView.reloadData()
                }
                if(obj.reviews != nil && obj.reviews!.count > 0){
                    self.viewCollectionview2.isHidden = false
                    obj.reviews?.forEach{ self.reviews.append($0)}
                    self.collectionview2.reloadData()
                }else{
                    self.viewCollectionview2.isHidden = true
                }
                if(obj.sizes != nil && obj.sizes!.count > 0){
                    obj.sizes?.forEach{ self.sizes.append($0)}
                    self.collectionview1.reloadData()
                }
                
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }

}

extension DetailsProductVC: UICollectionViewDelegate,UICollectionViewDataSource{
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == collectionview1) {
            return sizes.count
        }
        if (collectionView == collectionview2) {
            return reviews.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == collectionview1){
            let cell :PackageSizeCVC = collectionView.dequeue(cellForItemAt: indexPath)
            cell.lblSize.text = sizes[indexPath.row]
           
            if (idSelection == indexPath.row){
                cell.lblSize.textColor = getColorApp()
                cell.viewSize.borderColor = getColorApp()
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
        if(collectionView == collectionview1){
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


extension DetailsProductVC:FSPagerViewDelegate,FSPagerViewDataSource{
    
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
