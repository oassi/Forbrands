//
//  HomeVC.swift
//  Forbrands
//
//  Created by osamaaassi on 06/08/2021.
//

import UIKit
import FSPagerView
import AVKit
class HomeVC: SuperViewController,UISearchBarDelegate, UITextFieldDelegate {
    @IBOutlet var pageControl: FSPageControl!
    @IBOutlet weak var collectionview1:UICollectionView!
    @IBOutlet weak var collectionview2:UICollectionView!
    @IBOutlet weak var collectionview3:UICollectionView!
    @IBOutlet weak var collectionview4:UICollectionView!
    @IBOutlet weak var collectionview5:UICollectionView!
    @IBOutlet weak var collectionview6:UICollectionView!
    
    @IBOutlet var heighttableViewCell: NSLayoutConstraint!
    
    
    
    var adsTpo =  [AdsHome]()
    var adsCenter =  [AdsHome]()
    var storesTop = [StoresHome]()
    var storesBut = [StoresHome]()
    var products = [Product]()
    var storesWithVideo = [StoresWithVideoHome]()
    var categories = [CategoriesHome]()
    
    
    var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        
        registerCell()
       
        // Do any additional setup after loading the view.
    }
    private  func registerCell(){
        let nib1 = UINib(nibName: "StoresCell", bundle: .main)
        let nib2 = UINib(nibName: "ProductsCVC", bundle: .main)
        let nib6 = UINib(nibName: "ProductsRTLCVC", bundle: .main)
        let nib4 = UINib(nibName: "AdsProductHomeCVC", bundle: .main)
        let nib5 = UINib(nibName: "StoresWithVideoCVC", bundle: .main)
        collectionview1.register(nib1, forCellWithReuseIdentifier: "StoresCell")
        collectionview2.register(nib1, forCellWithReuseIdentifier: "StoresCell")
        collectionview3.register(nib2, forCellWithReuseIdentifier: "ProductsCVC")
        collectionview3.register(nib6, forCellWithReuseIdentifier: "ProductsRTLCVC")
        collectionview4.register(nib4, forCellWithReuseIdentifier: "AdsProductHomeCVC")
        collectionview5.register(nib5, forCellWithReuseIdentifier: "StoresWithVideoCVC")
        collectionview6.register(nib1, forCellWithReuseIdentifier: "StoresCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        reloadDate()
   
    }
 
    func reloadDate(){
        adsTpo.removeAll()
        adsCenter.removeAll()
        storesTop.removeAll()
        storesBut.removeAll()
        products.removeAll()
        getHomeList()
        storesWithVideo.removeAll()
        categories.removeAll()
       
    }
    
    
//    func tableviewRelodData(){
//        self.heighttableViewCell.constant = CGFloat(150 * products.count)
//        collectionview3.reloadData()
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchBar.endEditing(true)
        
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
  
    @IBOutlet weak var pagerView: FSPagerView!{
        didSet{
            self.pagerView.automaticSlidingInterval = 3.0
            self.pagerView.isScrollEnabled = true
            self.pagerView.register(UINib(nibName: "SliderProducatCell", bundle: Bundle.main), forCellWithReuseIdentifier: "SliderProducatCell")
        }
    }
    
    @IBOutlet weak var pageControlle: FSPageControl!{
        didSet{
            self.pageControlle.numberOfPages = adsTpo.count
            self.pageControlle.contentHorizontalAlignment = .center
            pageControlle.setImage(UIImage(named: "emptyDotSlide"), for: .normal)
            pageControlle.setImage(UIImage(named: "fillDotSlide"), for: .selected)
        }
    }
    @IBAction func tapAll(_ sender : UIButton){
        self.tabBarController?.selectedIndex = 1

    }
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let vc:SearchVC = SearchVC.loadFromNib()
        poushVC(vc,.fullScreen)
        return true
    }

    override func didClickRightButton(_sender: UIBarButtonItem) {
        guard CurrentUser.typeSelect != userType.Guest else {
            App.logout(self)
            return
        }
        switch _sender.tag {
        case 77:
            let vc:FavoritesVC = FavoritesVC.loadFromNib()
            poushVC(vc,.fullScreen)

        case 66:
            let vc:NotificationsVC = NotificationsVC.loadFromNib()
            poushVC(vc,.fullScreen)
        default:
            break
        }
    }
    
    
    func getHomeList(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.homePage ,isAuthRequired:  false).start(){  (response, error) in
            do {
                
                let Status =  try JSONDecoder().decode(BaseDataResponse<HomePage>.self, from: response.data!)
                if Status.code == 200{
                    if (Status.data != nil) {
                        
                        if let ad = Status.data?.ads , !ad.isEmpty {
                                ad.forEach{
                                $0.position == "top" ? self.adsTpo.append($0): self.adsCenter.append($0)
                            }
                            self.pagerView.reloadData()
                            self.pageControlle.numberOfPages = self.adsTpo.count
                        }
                        if let storeTop = Status.data?.stores , !storeTop.isEmpty {
                            let splitStore = storeTop.devided()
                             self.storesTop += splitStore.left
                             self.storesBut += splitStore.right
                        }
                        
                        if let product = Status.data?.products , !product.isEmpty {
                            self.products += product
                        }
                        if let storesWithVideo = Status.data?.storesWithVideo , !storesWithVideo.isEmpty {
                            self.storesWithVideo += storesWithVideo
                        }
                        if let categories = Status.data?.categories , !categories.isEmpty {
                            self.categories += categories
                        }
                    }
                    self.heighttableViewCell.constant = CGFloat(150 * self.products.count)
                    
                    self.collectionview1.reloadData()
                    self.collectionview2.reloadData()
                    self.collectionview3.reloadData()
                    self.collectionview4.reloadData()
                    self.collectionview5.reloadData()
                    self.collectionview6.reloadData()
                    
                    
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    

}




extension HomeVC: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == collectionview1) {
            return storesTop.count
        }
        if (collectionView == collectionview2) {
            return storesBut.count
        }
        if (collectionView == collectionview3) {
            return products.count
        }
        if (collectionView == collectionview4) {
            return adsCenter.count
        }
        if (collectionView == collectionview5) {
            return storesWithVideo.count
        }
        if (collectionView == collectionview6) {
            return categories.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(collectionView == collectionview1 || collectionView == collectionview2){
            let cell :StoresCell = collectionView.dequeue(cellForItemAt: indexPath)
            if(collectionView == collectionview1){
                cell.objStore = storesTop[indexPath.row]
                return cell
            }
            else{
                cell.objStore = storesBut[indexPath.row]
                return cell
            }
            
            
        }
        if(collectionView == collectionview3){
            if(indexPath.row % 2 == 0){
                let cell :ProductsCVC = collectionView.dequeue(cellForItemAt: indexPath)
                 cell.obj = products[indexPath.row]
                  return cell
            }
            else{
                let cell :ProductsRTLCVC = collectionView.dequeue(cellForItemAt: indexPath)
                cell.obj = products[indexPath.row]
                return cell
            }
        }
        
        if(collectionView == collectionview4){
            let cell :AdsProductHomeCVC = collectionView.dequeue(cellForItemAt: indexPath)
            cell.obj = adsCenter[indexPath.row]
            return cell
        }
        if(collectionView == collectionview5){
            let cell :StoresWithVideoCVC = collectionView.dequeue(cellForItemAt: indexPath)
            cell.obj = storesWithVideo[indexPath.row]
            return cell
        }
        if(collectionView == collectionview6){
            let cell :StoresCell = collectionView.dequeue(cellForItemAt: indexPath)
            cell.obj = categories[indexPath.row]
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == collectionview1 || collectionView == collectionview2){
           let vc :MyStoreVC = MyStoreVC.loadFromNib()
            if(collectionView == collectionview1){
                vc.imgStore = storesTop[indexPath.row].image ?? ""
                vc.id = storesTop[indexPath.row].id?.description ?? "0"
            }
            if(collectionView == collectionview2){
                vc.imgStore = storesBut[indexPath.row].image ?? ""
                vc.id = storesBut[indexPath.row].id?.description ?? "0"
            }
            poushVC(vc,.fullScreen, false)
        }
        if(collectionView == collectionview3){
           let vc :DetailsProductUserVC = DetailsProductUserVC.loadFromNib()
            vc.productId = products[indexPath.row].id ?? 0
            poushVC(vc,.fullScreen)

        }
        
        if(collectionView == collectionview4){
            if  adsCenter[indexPath.row].productId != nil && adsCenter[indexPath.row].productId != 0 {
                let vc :DetailsProductUserVC = DetailsProductUserVC.loadFromNib()
                vc.productId =  adsCenter[indexPath.row].productId ?? 0
                poushVC(vc,.fullScreen)
            } else if  adsCenter[indexPath.row].link != nil && adsCenter[indexPath.row].productId == 0 {
                let vc :webViewAdsVC = webViewAdsVC.loadFromNib()
                vc.url =  adsCenter[indexPath.row].link ?? ""
                poushVC(vc,.fullScreen)
            }
            
        }
        
        if(collectionView == collectionview5){
            if let url =  storesWithVideo[indexPath.row].videoLink, !url.isEmpty {
                playVideoButton(url)
            }
         
         


        }
        if(collectionView == collectionview6){
            let vc:CategoriesVC = CategoriesVC.loadFromNib()
            
            if MOLHLanguage.isArabic(){
                vc.titleNav = categories[indexPath.row].nameAr ?? ""
            }else{
                vc.titleNav = categories[indexPath.row].nameEn ?? ""
            }
            
           
            vc.categoryId =  categories[indexPath.row].id?.description ?? "0"
            poushVC(vc,.fullScreen, false)
          
        }
        
        
    }
    
    func playVideoButton(_ url:String = "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4") {
        guard let url = URL(string: url) else { return }
        let player = AVPlayer(url:url)
        let controller = AVPlayerViewController()
        controller.player = player
        present(controller, animated: true) {
               player.play()
           }
    }
    
    
}


extension HomeVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        if(collectionView == collectionview1 || collectionView == collectionview2){
            let width =  (self.view.frame.size.width - 40)/3.1
            return CGSize(width: width, height:115)
        }
        if(collectionView == collectionview3){
            let width =  (self.view.frame.size.width - 60)
            return CGSize(width: width, height:142)
        }
        if(collectionView == collectionview4){
            let width =  (self.view.frame.size.width - 20)/1.14
            return CGSize(width: width, height:138)
        }
        if(collectionView == collectionview5){
            let width =  (self.view.frame.size.width - 20)/1.6
            return CGSize(width: width, height:270)
        }
        if(collectionView == collectionview6){
            let width =  (self.view.frame.size.width - 40)/2
            return CGSize(width: width, height:104)
        }
        
        return CGSize(width: 0, height: 0)
         
    }
 

}

extension HomeVC{
    fileprivate func poushVC(_ vc:UIViewController ,_ modaStyle:UIModalPresentationStyle ,_ hidesBottomBar :Bool = true , _ typePush:Bool = true){
        vc.modalPresentationStyle = modaStyle
        vc.hidesBottomBarWhenPushed = hidesBottomBar
        if(typePush){
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            self.present(vc, animated: false, completion: nil)
        }
    }
}




extension HomeVC:FSPagerViewDelegate,FSPagerViewDataSource{
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return adsTpo.count
    }
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "SliderProducatCell", at: index) as! SliderProducatCell
        if !adsTpo.isEmpty {
            cell.imgProducta.sd_custom(url: adsTpo[index].image ?? "")
            self.pageControlle.currentPage = pagerView.currentIndex
            cell.imgProducta?.contentMode = .scaleToFill
            return cell
        }
        return FSPagerViewCell()
       
    }
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
       
        if  adsTpo[index].productId != nil && adsTpo[index].productId != 0 {
            let vc :DetailsProductUserVC = DetailsProductUserVC.loadFromNib()
            vc.productId =  adsTpo[index].productId ?? 0
            poushVC(vc,.fullScreen)
        }
        else if  adsTpo[index].link != nil && adsTpo[index].productId == 0 {
            let vc :webViewAdsVC = webViewAdsVC.loadFromNib()
            vc.url =  adsTpo[index].link ?? ""
            poushVC(vc,.fullScreen)
        }
        

        
        print("sada")
    }
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControlle.currentPage = pagerView.currentIndex
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControlle.currentPage = targetIndex
    }
}


extension Array {
    func devided() -> (left: [Element], right:[Element]) {
        let half = count / 2 + count % 2
        let leftSplit = self[0..<half]
        let rightSplit = self[half..<count]

        return (left: Array(leftSplit), right: Array(rightSplit))
    }
}
