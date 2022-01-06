//
//  CategoriesVC.swift
//  Forbrands
//
//  Created by osamaaassi on 18/08/2021.
//

import UIKit
import FittedSheets
class CategoriesVC: SuperViewController {
    @IBOutlet weak var tableview:UITableView!
    
    var categoryId : String = "0"
    var titleNav : String = "Categories"
    var productByCat = [Product]()
    var card =  loads()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        tableview.registerCell(id: "FavoritesCVC")
        // Do any additional setup after loading the view.
    }
    
    
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setTitle(titleNav.localized, sender: self, large: false)
        navgtion.setCustomBackButtonForViewController(sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadDataProduct()
       // reloadCard()
    }
    
    func reloadCard()  {
        card.removeAll()
        card = loads()
    }
    func reloadDataProduct()  {
        productByCat.removeAll()
        CurrentUser.typeSelect == userType.Guest ? getProductByCat() :  getProductByCatAuth()
    }
    
    func getProductByCatAuth(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.productsByCategoryAuth,nestedParams: categoryId ,isAuthRequired:  true).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataArrayResponse<Product>.self, from: response.data!)
                if Status.code == 200{
                    guard let obj = Status.data, !obj.isEmpty  else {
                        _=self.showEmptyView(emptyView: self.emptyView, parentView: self.tableview, refershSelector: #selector(self.didRefersh), firstLabel: "There are No Products! 🥲".localized)
                        return
                    }
                    self.productByCat += Status.data!
                    self.tableview.reloadData()
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    @objc func didRefersh() {  }
    func getProductByCat(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.productsByCategory,nestedParams: categoryId ,isAuthRequired:  true).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataArrayResponse<Product>.self, from: response.data!)
                if Status.code == 200{
                    guard let obj = Status.data, !obj.isEmpty  else {
                        _=self.showEmptyView(emptyView: self.emptyView, parentView: self.tableview, refershSelector: #selector(self.didRefersh), firstLabel: "There are No Products! 🥲".localized)
                        return
                    }
                    self.productByCat += Status.data!
                    self.tableview.reloadData()
                    
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
    
}
extension CategoriesVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productByCat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "FavoritesCVC", for: indexPath) as! FavoritesCVC
        let obj = productByCat[indexPath.row]
        cell.objPro = obj
        
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
//
//            if CurrentUser.typeSelect == userType.Guest{
//                App.logout(self)
//            }else{
//                if(obj.status == "1"){
//                    var isCard = true
//                    let cardItems : CardItem
//
//                    if(obj.price == nil || obj.price == "0"){
//                        cardItems = CardItem(id: obj.id ?? 0, nameAr: obj.nameAr ?? "", nameEn: obj.nameEn ?? "", detailsAr: obj.detailsAr ?? "", detailsEn: obj.detailsEn ?? "", oldPrice: Int(obj.price ?? "0"), price: Int(obj.oldPrice ?? "0"), images: obj.images?.first, count: 1)
//
//                    }else{
//                        cardItems = CardItem(id: obj.id ?? 0, nameAr: obj.nameAr ?? "", nameEn: obj.nameEn ?? "", detailsAr: obj.detailsAr ?? "", detailsEn: obj.detailsEn ?? "", oldPrice: Int(obj.oldPrice ?? "0"), price: Int(obj.price ?? "0"), images: obj.images?.first, count: 1)
//                    }
//                    if(!strongSelf.card.isEmpty){
//                        if (strongSelf.card.contains(where: { $0.id == obj.id })){
//                            strongSelf.showAlert(title: "", message: "The product is already in the basket".localized)
//                            isCard = false
//                        }
//                        else{
//                            strongSelf.card.append(cardItems)
//                            save(strongSelf.card)
//                        }
//
//                    }else{
//                        save([cardItems])
//                        strongSelf.reloadCard()
//
//                    }
//                    if(isCard){
//                        let controller = PopAddCardVC()
//                        controller.goTocard = { [weak self] in
//                            self?.tabBarController?.selectedIndex = 2
//                        }
//                        let sheet = SheetViewController(controller: controller, sizes: [.fixed(290)])
//                        sheet.extendedLayoutIncludesOpaqueBars = false
//                        strongSelf.present(sheet, animated: false, completion: nil)}
//
//                }else{
//                    let controller = PopNotAvailableProduectVC()
//                    let sheet = SheetViewController(controller: controller, sizes: [.fixed(220)])
//                    sheet.extendedLayoutIncludesOpaqueBars = false
//                    strongSelf.present(sheet, animated: false, completion: nil)
//                }
//            }
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc:DetailsProductUserVC = DetailsProductUserVC.loadFromNib()
        vc.productId = productByCat[indexPath.row].id ?? 0
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
 
}
