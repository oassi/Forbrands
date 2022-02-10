//
//  ShowCategoryVC.swift
//  Forbrands
//
//  Created by osamaaassi on 11/08/2021.
//

import UIKit

class ShowCategoryVC: SuperViewController {
    @IBOutlet weak var collectionview:UICollectionView!
    @IBOutlet weak var appProdcut:UILabel!
    @IBOutlet weak var img:UIImageView!
    
    var productsByStore = [ProductsByStoreCat]()
    var CategoryId : String = "0"
    var titleNav : String = "Categories"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        registerCell()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        relodeData()
        colorChang()
    }
    
    func relodeData() {
        productsByStore.removeAll()
        getCategories()
    }
    
    func colorChang() {
        appProdcut.textColor = getColorApp()
        img.tintColor = getColorApp()
    }
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setTitle(titleNav.localized, sender: self, large: false)
        navgtion.setRightButtons([navgtion.searchNavBut!], sender: self)
        navgtion.setCustomBackButtonForViewController(sender: self)
    }
    private  func registerCell(){
        let nib1 = UINib(nibName: "ViewCategoriesSellerVC", bundle: .main)
        collectionview.register(nib1, forCellWithReuseIdentifier: "ViewCategoriesSellerVC")
    }
    @IBAction func tapAddProductButton(_sender: UIButton) {
        UserDefaults.standard.set(object: [String](), forKey: "sizeLest")
        let vc:AddProductVC = AddProductVC.loadFromNib()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    override func didClickRightButton(_sender: UIBarButtonItem) {
        let vc:SearchSellerVC = SearchSellerVC.loadFromNib()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didRefersh() {  }
    func getCategories(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.getProductsByStoreByCategory,nestedParams: CategoryId ,isAuthRequired:  true).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataArrayResponse<ProductsByStoreCat>.self, from: response.data!)
                if Status.code == 200{
                    guard let obj = Status.data, !obj.isEmpty  else {
                        _=self.showEmptyView(emptyView: self.emptyView, parentView: self.collectionview, refershSelector: #selector(self.didRefersh), firstLabel: "There are No Products! 🥲".localized)
                        return
                    }
                    
                    self.productsByStore += obj
                    self.collectionview.reloadData()
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
    
    
    
}

extension ShowCategoryVC : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsByStore.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewCategoriesSellerVC", for: indexPath) as! ViewCategoriesSellerVC
        let obj = productsByStore[indexPath.row]
        cell.obj = obj
        cell.editBut.backgroundColor = getColorApp()
        cell.deleteDeleget = {   [weak self]  in
            guard let strongSelf = self else { return }
            strongSelf.showAlertWithCancel(title: "Do you want to delete this product?".localized, message: "", okAction: "Delete".localized) { (UIAlertAction) in
                App.deleteProducts(strongSelf, id: obj.id?.description ?? "") { bool in
                    if bool{
                        strongSelf.relodeData()
                        strongSelf.collectionview.reloadData()
                    }
                }
            }
        }
        cell.editDeleget = {   [weak self]  in
            guard let strongSelf = self else { return }
            let vc:AddProductVC = AddProductVC.loadFromNib()
            vc.isEdit = true
            vc.productId = obj.id?.description ?? "0"
            vc.modalPresentationStyle = .fullScreen
            strongSelf.navigationController?.pushViewController(vc, animated: true)
        }
        
        
        cell.changeStatusDeleget = { [weak self]  in
            guard let strongSelf = self else { return }
            let stusts = obj.status == 1 ? "0" : "1"
            _ = WebRequests.setup(controller: self).prepare(api: Endpoint.productChangeStatus,nestedParams: "\(obj.id?.description ?? "")/\(stusts)" ,isAuthRequired:  true).start(){  (response, error) in
                do {
                    let Status =  try JSONDecoder().decode(StatusAddressEdit.self, from: response.data!)
                    if Status.code == 200{
                        strongSelf.relodeData()
                    }
                }catch let jsonErr {
                    print("Error serializing  respone json", jsonErr)
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc:DetailsProductVC = DetailsProductVC.loadFromNib()
        vc.ProdectId = productsByStore[indexPath.row].id ?? 0
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
