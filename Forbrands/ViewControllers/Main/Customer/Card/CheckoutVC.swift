//
//  CheckoutVC.swift
//  Forbrands
//
//  Created by osamaaassi on 14/08/2021.
//

import UIKit

class CheckoutVC: SuperViewController {

    @IBOutlet weak var tableview:UITableView!
    @IBOutlet var heighttableViewCell: NSLayoutConstraint!
    
    @IBOutlet weak var orderId:UILabel!
    @IBOutlet weak var total:UILabel!
    @IBOutlet weak var oldtotal:UILabel!
    @IBOutlet weak var totalDiscount:UILabel!
    @IBOutlet weak var payment:UILabel!
    @IBOutlet weak var promocode:UILabel!
    @IBOutlet weak var shoping:UILabel!
     
    var products = [Products]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // navButtons()
        tableview.registerCell(id: "CheckoutCVC")
        getItems()
        // Do any additional setup after loading the view.
        UIView.animate(withDuration: 2) {
            self.heighttableViewCell.constant = 80
            self.view.layoutIfNeeded()
        }
        
//
//        self.heighttableViewCell.constant = 200
//        self.tableview.reloadData()
    }
    
    
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setTitle("Complete the order".localized, sender: self, large: false)
        navgtion.setCustomBackButtonForViewController(sender: self)
    }
    @IBAction func tapPaymentMethods (_ sender : UIButton){
//        let vc:PopPaymentVC = PopPaymentVC.loadFromNib()
//        vc.paySelected = { [weak self] selected in
//            if(selected == 1){
//                    _ = WebRequests.setup(controller: self).prepare(api: Endpoint.tabby ,isAuthRequired:  false).start(){  (response, error) in
//                        do {
//                            let Status =  try JSONDecoder().decode(TabbayResponse.self, from: response.data!)
//                            SocialNetworkUrl(scheme: Status.webUrl ?? "" , page:  Status.webUrl ?? "").openPage()
//                        }catch let jsonErr {
//                            print("Error serializing  respone json", jsonErr)
//                        }
//                    }
//            }
//        }
//        vc.modalPresentationStyle = .overFullScreen
//        present(vc, animated: true, completion: nil)
    }
    
    func getItems() {
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.ordersComplete ,isAuthRequired:  true).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<OrdersComplete>.self, from: response.data!)
                if Status.code == 200{
                    let obj = Status.data
                    self.orderId.text = obj?.orderId?.description ?? "0"
                    self.total.text = obj?.total?.description ?? "0"
                    self.oldtotal.text = obj?.oldtotal?.description ?? "0"
                    self.payment.text = obj?.payment?.description ?? "0"
                    self.promocode.text = obj?.promocode?.description ?? "0"
                    self.totalDiscount.text =  String( (obj?.oldtotal ?? 0) -  (obj?.total ?? 0))
                    self.shoping.text = obj?.shoping?.description ?? "0"
                    
                    if let products = obj?.products ,  !products.isEmpty{
                        self.products = products
                        self.heighttableViewCell.constant = CGFloat((products.count * 100))
                        self.tableview.reloadData()
                    }
                    
                    
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
    @IBAction func tapSave (_ sender : UIButton){
        DispatchQueue.main.async {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                let vc = TTabBarController()
                        vc.modalPresentationStyle = .fullScreen
                        vc.title = "sfds"
                        self.goToRoot(vc)
            })}
        
        UserDefaults.standard.set("0", forKey: "countCart")

      
    }

}
extension CheckoutVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "CheckoutCVC", for: indexPath) as! CheckoutCVC
        cell.product = products[indexPath.row]
        return cell
    }

    
}
