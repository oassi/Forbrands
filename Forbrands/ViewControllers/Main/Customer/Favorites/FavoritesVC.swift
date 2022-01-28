//
//  FavoritesVC.swift
//  Forbrands
//
//  Created by osamaaassi on 06/08/2021.
//

import UIKit
import FittedSheets

class FavoritesVC: SuperViewController {

    @IBOutlet weak var tableview:UITableView!
    var favoriteList = [FavoriteList]()
    var card =  loads()
    var isCard = false
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        tableview.registerCell(id: "FavoritesCVC")
        // Do any additional setup after loading the view.
    }

    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setTitle("Favorites".localized, sender: self, large: false)
        navgtion.setCustomBackButtonForViewController(sender: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        reloadDataFavoriteList()
       // reloadCard()
    }
    
    func reloadDataFavoriteList() {
        favoriteList.removeAll()
        getFavList()
        

    }
    func reloadCard()  {
        card.removeAll()
        card = loads()
    }
    
    @objc func didRefersh() {
        print("didRefersh")
    }
    
    func getFavList(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.favList ,isAuthRequired:  true).start(){  (response, error) in
            
            do {
                let Status =  try JSONDecoder().decode(BaseDataArrayResponse<FavoriteList>.self, from: response.data!)
                
                if Status.code == 200{
                    guard let data = Status.data else {   return    }
                    
                    self.favoriteList += data
                    
                    if self.favoriteList.count == 0{
                        self.tableview.tableHeaderView = nil
                        _=self.showEmptyView(emptyView: self.emptyView, parentView: self.tableview, refershSelector: #selector(self.didRefersh))
                    }
                    
                    self.tableview.reloadData()

                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }

}

extension FavoritesVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "FavoritesCVC", for: indexPath) as! FavoritesCVC
        let obj = favoriteList[indexPath.row]
        let objPorduct = obj.product
        cell.obj = objPorduct
        cell.isFavorites = {[weak self] in
            guard let strongSelf = self else { return }
            App.unFav(strongSelf, id: obj.productId?.description ?? "") { bool in
                if bool{
                    strongSelf.reloadDataFavoriteList()
                }
            }
        }
        
        cell.addToCard = { [weak self] in
            guard let strongSelf = self else { return }
            if CurrentUser.typeSelect == userType.Guest{
                App.logout(self)
            }else{
                if(objPorduct?.status == "1"){
                    var parameters = [String : String]()
                    parameters["product_id"] = objPorduct?.id?.description ?? "0"
                    parameters["quantity"] = "1"
                    App.addCart(strongSelf, parameters: parameters) { bool in
                        let controller = PopAddCardVC()
                        controller.goTocard = { [weak self] in
                            guard let strongSelf = self else { return }
                            if strongSelf.isCard == true {
                                strongSelf.navigationController?.popViewController(animated: true)
                            }else{
                                strongSelf.tabBarController?.selectedIndex = 2

                            }
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
        //                    var isCard = true
        //                    let cardItems : CardItem
//
//                    if(objPorduct?.price == nil || objPorduct?.price == "0"){
//                        cardItems = CardItem(id: objPorduct?.id ?? 0, nameAr: objPorduct?.nameAr ?? "", nameEn: objPorduct?.nameEn ?? "", detailsAr: objPorduct?.detailsAr ?? "", detailsEn: objPorduct?.detailsEn ?? "", oldPrice: Int(objPorduct?.price ?? "0"), price: Int(objPorduct?.oldPrice ?? "0"), images: objPorduct?.images?.first, count: 1)
//
//                    }else{
//                        cardItems = CardItem(id: objPorduct?.id ?? 0, nameAr: objPorduct?.nameAr ?? "", nameEn: objPorduct?.nameEn ?? "", detailsAr: objPorduct?.detailsAr ?? "", detailsEn: objPorduct?.detailsEn ?? "", oldPrice: Int(objPorduct?.oldPrice ?? "0"), price: Int(objPorduct?.price ?? "0"), images: objPorduct?.images?.first, count: 1)
//                    }
//                    if(!strongSelf.card.isEmpty){
//                        if (strongSelf.card.contains(where: { $0.id == objPorduct?.id })){
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
//
//
//                }else{
//                    let controller = PopNotAvailableProduectVC()
//                    let sheet = SheetViewController(controller: controller, sizes: [.fixed(220)])
//                    sheet.extendedLayoutIncludesOpaqueBars = false
//                    strongSelf.present(sheet, animated: false, completion: nil)
//                }
        
        
     
 
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc:DetailsProductUserVC = DetailsProductUserVC.loadFromNib()
        vc.productId = favoriteList[indexPath.row].productId ?? 0
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
