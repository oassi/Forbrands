//
//  StoresSellerVC.swift
//  Forbrands
//
//  Created by osamaaassi on 10/08/2021.
//

import UIKit

class StoresSellerVC: SuperViewController {
    @IBOutlet weak var collectionview:UICollectionView!
    
    @IBOutlet weak var appProdcut:UILabel!
    @IBOutlet weak var img:UIImageView!
    var imgStore:String?
    
    var categories = [CategoriesHome]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        // Do any additional setup after loading the view.
        
      //  NotificationCenter.default.addObserver(self, selector: #selector(self.colorChange(_:)), name: Notification.Name("colorChange"), object: nil)

    }
    override func viewWillAppear(_ animated: Bool) {
        colorChang()
        navButtons()
        relodeData()
  
        
    }
  
    func relodeData() {
        categories.removeAll()
        getMyStore()
    }
    func colorChang() {
        appProdcut.textColor = getColorApp()
        img.tintColor = getColorApp()
    }
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navigationController?.navigationBar.tintColor = getColorApp()
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
        UserDefaults.standard.set(object: [String](), forKey: "sizeLest")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func getMyStore(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.myStoreSeller ,isAuthRequired:  true).start(){ (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<MyStoreSeller>.self, from: response.data!)
                if Status.code == 200{
                    if let img =  Status.data?.image {
                        self.imgStore = img
                    }
                    if let categorie = Status.data?.categories{
                        categorie.forEach{self.categories.append($0) }
                    }
                    self.collectionview.reloadData()
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
    
    
}
extension StoresSellerVC : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "CategorySellerCVC", for: indexPath) as! CategorySellerCVC
         
        let obj = categories[indexPath.row]
        cell.obj = obj
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc:ShowCategoryVC = ShowCategoryVC.loadFromNib()
        vc.CategoryId =  categories[indexPath.row].id?.description ?? "0"
        vc.titleNav = categories[indexPath.row].name ?? "Categories"
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //header View
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            case UICollectionView.elementKindSectionHeader:
                guard let headerView = collectionView.dequeueReusableSupplementaryView( ofKind: kind, withReuseIdentifier: "\(HeaderStoreSellerCell.self)", for: indexPath) as? HeaderStoreSellerCell  else { fatalError("Invalid view type") }
                
            headerView.imgView.sd_custom(url: "\(App.IMG_URL.img_URL)\(imgStore ?? "")" ,defultImage: UIImage(named: "defultImg") )
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
