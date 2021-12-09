//
//  OrderSellerVC.swift
//  Forbrands
//
//  Created by osamaaassi on 10/08/2021.
//

import UIKit

class OrderSellerVC: SuperViewController {
    @IBOutlet var tableview: UITableView!
    
    @IBOutlet var currentButton: UIButton!
    @IBOutlet var viewCurrent: UIView!
    @IBOutlet var previousButton: UIButton!
    @IBOutlet var viewPrevious: UIView!
    
    var traderOrdersCurrnt = [CustomerOrders]()
    var traderOrdersPrevious = [CustomerOrders]()
    var isPrevious = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.registerCell(id: "CurrentCVC")
        tableview.registerCell(id: "PreviousCVC")
        // Do any additional setup after loading the view.
    }
    
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setTitle("Orders".localized, sender: self, large: false)
        navgtion.navigationBar.layer.masksToBounds = true
        navigationController?.navigationBar.tintColor = getColorApp()
    }

    override func viewWillAppear(_ animated: Bool) {
        navButtons()
        changColorButApp(currentButton)
        viewCurrent.backgroundColor = getColorApp()
        viewPrevious.backgroundColor = UIColor(named: "background")
        previousButton.setTitleColor(UIColor(named: "derkGrey"), for: .normal)
        relodeData()
        isPrevious = false
//        tableview.reloadData()
      
       
    }
    
    @IBAction func tapCurrent(_ sender: UIButton) {
        changColorButApp(currentButton)
        viewCurrent.backgroundColor = getColorApp()
        viewPrevious.backgroundColor = UIColor(named: "background")
        previousButton.setTitleColor(UIColor(named: "derkGrey"), for: .normal)
        isPrevious = false
        tableview.reloadData()
    }
    
    @IBAction func tapPrevious(_ sender: UIButton) {
        isPrevious = true
        changColorButApp(previousButton)
        viewPrevious.backgroundColor =  getColorApp()
        viewCurrent.backgroundColor = UIColor(named: "background")
        currentButton.setTitleColor(UIColor(named: "derkGrey"), for: .normal)
        tableview.reloadData()
    }
    
    
    func relodeData() {
        traderOrdersCurrnt.removeAll()
        traderOrdersPrevious.removeAll()
        getOrders()
    }
    
    func getOrders(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.traderOrders ,isAuthRequired:  true).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataArrayResponse<CustomerOrders>.self, from: response.data!)
                if Status.code == 200 && Status.data != nil{
                    Status.data?.forEach{
                        if $0.status == 0 {
                            self.traderOrdersCurrnt.append($0)
                        }
                        if $0.status == 1{
                            self.traderOrdersPrevious.append($0)
                        }
                        self.tableview.reloadData()
                    }
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    

}

extension OrderSellerVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isPrevious ? traderOrdersPrevious.count :traderOrdersCurrnt.count
     }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(isPrevious){
            let cell = tableview.dequeueReusableCell(withIdentifier: "PreviousCVC", for: indexPath) as! PreviousCVC
            cell.lblDay.textColor = getColorApp()
            cell.lblOrderDetails.textColor = getColorApp()
            
            let obj = traderOrdersPrevious[indexPath.row]
            cell.obj = obj
            
            if(obj.reviews != nil && obj.orderProcess != "-1" ){
                cell.lblEvaluation.text = "Customer evaluation".localized
                cell.reviewsBut.isHidden = true
                cell.ViewRate.rating = Double(obj.reviews?.rating ?? "0.0") ?? 0.0
            }else{
                cell.viewRates.isHidden = true
            }
            
            cell.viewOrderDetails = { [weak self] in
                guard let strongSelf = self else {
                    return
                }
                let vc: OrderDetailsVC = OrderDetailsVC.loadFromNib()
                vc.orders = obj
                vc.modalPresentationStyle = .fullScreen
                strongSelf.navigationController?.pushViewController(vc, animated: true)
            }
            
         
            return cell
        }
        else{
            let cell = tableview.dequeueReusableCell(withIdentifier: "CurrentCVC", for: indexPath) as! CurrentCVC
            let obj = traderOrdersCurrnt[indexPath.row]
            cell.obj = obj
            
            cell.lblDay.textColor = getColorApp()
            changColorButApp(cell.viewOrderDetailsBut)
            
            cell.viewOrderDetails = { [weak self] in
                guard let strongSelf = self else {
                    return
                }
                let vc: OrderDetailsVC = OrderDetailsVC.loadFromNib()
                vc.orders = obj
                vc.modalPresentationStyle = .fullScreen
                strongSelf.navigationController?.pushViewController(vc, animated: true)
            }
            
            cell.changeOrderStatus = { [weak self] in
                guard let strongSelf = self else {
                    return
                }
                let vc: PopChangeOrderStatusVC = PopChangeOrderStatusVC.loadFromNib()
                vc.modalPresentationStyle = .overFullScreen
                vc.ordersId = obj.orderId ?? ""
                vc.rateDeleget = { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.relodeData()
                }
                strongSelf.present(vc, animated: false, completion: nil)
            }
            return cell
        }
    }
}
