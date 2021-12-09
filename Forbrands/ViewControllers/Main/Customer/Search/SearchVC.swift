//
//  SearchVC.swift
//  Forbrands
//
//  Created by osamaaassi on 06/08/2021.
//

import UIKit
import FittedSheets

class SearchVC: SuperViewController, UISearchBarDelegate {

    @IBOutlet weak var tableview:UITableView!
    lazy var searchBars:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 40))
    var productBySearch = [Product]()
    var card =  loads()
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        tableview.registerCell(id: "FavoritesCVC")
        // Do any additional setup after loading the view.
    }

    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonWithdismiss(sender: self)
        searchBars.delegate = self
        searchBars.tintColor = .black
        searchBars.searchTextField.textColor = .black
        searchBars.showsCancelButton = true
        searchBars.placeholder = "Search for".localized
        searchBars.sizeToFit()
        searchBars.searchTextField.backgroundColor =  UIColor(named: "searchbar")
        let leftNavBarButton = UIBarButtonItem(customView: searchBars)
        
        navgtion.setRightButtons([leftNavBarButton], sender: self)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBars.searchTextField.text = ""
        self.navigationController?.popViewController(animated: true)
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.productBySearch.removeAll()
        getSearch(searchBars.searchTextField.text ?? "")
        reloadCard()
       // searchBars.searchTextField.text = ""
        
    }
    override func viewWillAppear(_ animated: Bool) {
        reloadCard()
    }
    
    func reloadCard()  {
        card.removeAll()
        card = loads()
    }
    
    func getSearch(_ str : String)  {
        var parameters = [String : Any]()
        parameters["query"] = str
       
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.search,parameters:parameters ,isAuthRequired: false).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataArrayResponse<Product>.self, from: response.data!)
                if Status.code == 200 && Status.data != nil{
                    guard Status.data?.count != 0  else {
                        self.showAlert(title: "No Results".localized , message: "There are no search results".localized)
                        return
                    }
                    self.productBySearch += Status.data!
                    self.tableview.reloadData()
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
    }
   
    }
}

extension SearchVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productBySearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "FavoritesCVC", for: indexPath) as! FavoritesCVC
        let obj = productBySearch[indexPath.row]
        cell.objPro  = obj
        
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
                            strongSelf.productBySearch.removeAll()
                            strongSelf.getSearch(strongSelf.searchBars.searchTextField.text ?? "")
                            tableView.reloadData()
                        }
                    }
                }else{
                    App.unFav(strongSelf, id: obj.id?.description ?? "") { bool in
                        if bool{
                            strongSelf.productBySearch.removeAll()
                            strongSelf.getSearch(strongSelf.searchBars.searchTextField.text ?? "")
                            tableView.reloadData()
                        }
                    }
                }
            }
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc :DetailsProductUserVC = DetailsProductUserVC.loadFromNib()
         vc.productId = productBySearch[indexPath.row].id ?? 0
         vc.modalPresentationStyle = .fullScreen
         self.navigationController?.pushViewController(vc, animated: true)
    }
}
