//
//  CardVC.swift
//  Forbrands
//
//  Created by osamaaassi on 06/08/2021.
//

import UIKit
import FittedSheets
class CardVC: SuperViewController {
    
    @IBOutlet weak var tableview:UITableView!
    @IBOutlet weak var lblPromeCode:UITextField!
    @IBOutlet weak var lblPromeCodeDescountPrice:UILabel!
    @IBOutlet weak var lblTotlaPrice:UILabel!
    @IBOutlet weak var viewDescount:UIView!
    @IBOutlet weak var deleteView:UIView!
    @IBOutlet var footerTable: UIView!
    var cart = [Cart]()
    var productsId = [Int]()
    var amounts = [Int]()
    var discountCode : DiscountCode?
    
    var total:Double = 0
    var discont:Double = 0
    var isDiscount:Bool = false
    var totalAfterDiscont :Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
       // getToCart()
       
       
        // Do any additional setup after loading the view.
       
    }
  
    override func viewWillAppear(_ animated: Bool) {
        guard CurrentUser.typeSelect != userType.Guest else {
            App.logout(self)
            return
        }
        tableview.registerCell(id: "CardCVC")
        getToCart()
        if( UserDefaults.standard.bool(forKey: "ordersComplete")){
            self.tabBarController?.selectedIndex = 0
            UserDefaults.standard.set(false, forKey: "ordersComplete")
        }else{
            
        }
      
       // tableview.reloadData()

    }
    

    
    func updataCard() {
        cart.removeAll()
        getToCart()
//        card.removeAll()
//        card = loads()
       // lblTotlaPrice.text = "0"
       // card.forEach{ self.lblTotlaPrice.text = String((($0.price ?? 0) * $0.count) + Int(  self.lblTotlaPrice.text ?? "0")!) }
    }
    
    @objc func didRefersh() {
        //let vc = LoginViewController().navigationController()
        //self.goToRoot(vc)
    }
    
    func getToCart(){
        cart.removeAll()
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.listCart ,isAuthRequired:  true).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataArrayResponse<Cart>.self, from: response.data!)
                if Status.code == 200{
                    guard let data = Status.data else {   return    }
                    self.cart += data
                    if self.cart.count == 0{
                        self.tableview.tableHeaderView = nil
                        
                        _=self.showEmptyView(emptyView: self.emptyView, parentView: self.tableview, refershSelector: #selector(self.didRefersh))
                    } else{
                        self.tableview.tableFooterView = self.footerTable
                        self.lblTotlaPrice.text = self.totalCart(self.cart).description
                    }
                    self.tableview.delegate = self
                    self.tableview.dataSource = self
                    self.tableview.reloadData()
                    
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
    func totalCart(_ obj:[Cart]) -> Double {
        var total:Int = 0
        for i in obj {
            total +=  Int(i.total?.description ?? "0")!
        }
        self.totalAfterDiscont = Double( Double(total) - ( Double(total) * Double(self.discont) ))
        self.total = Double(total)
        return totalAfterDiscont
    }
//    func productsAndAmounts() {
//        productsId.removeAll()
//        amounts.removeAll()
//        card.forEach{
//            productsId.append($0.id)
//            amounts.append($0.count)
//        }
//    }
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setRightButtons([navgtion.notificaltionBut!,navgtion.favoritesBut!], sender: self)
    }
    
    override func didClickRightButton(_sender: UIBarButtonItem) {
        guard CurrentUser.typeSelect != userType.Guest else {
            App.logout(self)
            return
        }
        switch _sender.tag {
        case 77:
            let vc:FavoritesVC = FavoritesVC.loadFromNib()
            vc.isCard = true
            vc.hidesBottomBarWhenPushed = true
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        case 66:
            let vc:NotificationsVC = NotificationsVC.loadFromNib()
            vc.hidesBottomBarWhenPushed = true
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    @IBAction func deletePromoCode (_ sender : UIButton){
        deletePromoCode()
    }
   
   
    
    
    @IBAction func tapPurchase (_ sender : UIButton){
        guard !cart.isEmpty else {
            showAlert(title: "", message: "The basket must contain at least one product".localized)
            return
        }
        let vc:AddressesVC = AddressesVC.loadFromNib()
        vc.isCard = true
        vc.isDiscount = isDiscount
        vc.amounts = totalAfterDiscont
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func tapPromoCode (_ sender : UIButton){
        
        let controller = PopPromoCodeVC()
        let sheet = SheetViewController(controller: controller, sizes: [.fixed(235)])
        sheet.extendedLayoutIncludesOpaqueBars = false
        self.present(sheet, animated: false, completion: nil)

        controller.delegetPromocode = {  [weak self] promoCode in
            self?.addPromoCode(promoCode)
        }
    }
    
    
    func addPromoCode(_ promoCode:String){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.addPromoCode, parameters: ["code" : "\(promoCode)"] ,isAuthRequired:  true).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<DiscountCode>.self, from: response.data!)
                
                if Status.code == 200{
                    self.discountCode = Status.data
                    self.viewDescount.isHidden = false
                    self.lblPromeCode.text =  promoCode
                    self.discont = Double(Status.data?.discount ?? 0) / 100
                    let totalAfterDiscont = String( self.total - ( self.total * self.discont ))
                    self.lblTotlaPrice.text = totalAfterDiscont
                    self.lblPromeCodeDescountPrice.text =  self.discountCode?.discount?.description ?? ""
                    self.deleteView.isHidden = false
                    self.isDiscount = true
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
    func deletePromoCode(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.deletePromoCode, parameters: ["id" : "\(discountCode?.id ?? 0)"] ,isAuthRequired:  true).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<DiscountCode>.self, from: response.data!)
                if Status.code == 200{
                    self.viewDescount.isHidden = true
                    self.lblPromeCode.text = ""
                    self.discont = 0
                    self.lblTotlaPrice.text = String(self.total)
                    self.deleteView.isHidden = true
                    self.isDiscount = false
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }

}


extension CardVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "CardCVC", for: indexPath) as!
            CardCVC
        let obj = cart[indexPath.row]
        cell.obj = obj
        cell.deleteToCard = {[weak self] in
            guard let strongSelf = self else { return }
            var parameters = [String : String]()
            parameters["id"] = (obj.id?.description ?? "0")
    
            App.removeProductCart(strongSelf, parameters: parameters) { (delete) in
                strongSelf.getToCart()
            }
//            for (k,i) in strongSelf.card.enumerated() {
//                if ( i.id == obj.id){
//                    strongSelf.card.remove(at: k)
//                    save(strongSelf.card)
//                    strongSelf.totlaCard()
//                    strongSelf.tableview.reloadData()
//                }
//            }
        }
        cell.updataCard = { [weak self] id in
            guard let strongSelf = self else { return }
            var parameters = [String : String]()
            parameters["product_id"] = (obj.productId?.description ?? "0")
            parameters["quantity"] = id.description
            App.addCart(strongSelf, parameters: parameters){ (updata) in
                strongSelf.getToCart()
            }
            
//            self?.totlaCard()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc:DetailsProductUserVC = DetailsProductUserVC.loadFromNib()
        vc.productId = cart[indexPath.row].productId ?? 0
        vc.isCart = true
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


