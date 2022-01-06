//
//  MyOrderVC.swift
//  Forbrands
//
//  Created by osamaaassi on 15/08/2021.
//

import UIKit
import FittedSheets
class MyOrderVC: SuperViewController {
    
    @IBOutlet var tableview: UITableView!
    @IBOutlet var currentButton: UIButton!
    @IBOutlet var viewCurrent: UIView!
    @IBOutlet var previousButton: UIButton!
    @IBOutlet var viewPrevious: UIView!
    var isPrevious = false
    var customerOrdersCurrnt = [CustomerOrders]()
    var customerOrdersPrevious = [CustomerOrders]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.registerCell(id: "CurrentCVC")
        tableview.registerCell(id: "PreviousCVC")
        tableview.dataSource = self
        tableview.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navButtons()
        relodeData()
    }
    
    func relodeData() {
        customerOrdersCurrnt.removeAll()
        customerOrdersPrevious.removeAll()
        getOrders()
    }
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setTitle("My Orders".localized, sender: self, large: false)
        navgtion.setCustomBackButtonForViewController(sender: self)
        navgtion.navigationBar.layer.masksToBounds = true
    }
    
    @IBAction func tapCurrent(_ sender: UIButton) {
        currentButton.setTitleColor(UIColor(named: "primary"), for: .normal)
        viewCurrent.backgroundColor = UIColor(named: "primary")
        viewPrevious.backgroundColor = UIColor(named: "background")
        previousButton.setTitleColor(UIColor(named: "derkGrey"), for: .normal)
        isPrevious = false
        tableview.reloadData()
        
    }
    @IBAction func tapPrevious(_ sender: UIButton) {
        previousButton.setTitleColor(UIColor(named: "primary"), for: .normal)
        viewPrevious.backgroundColor = UIColor(named: "primary")
        viewCurrent.backgroundColor = UIColor(named: "background")
        currentButton.setTitleColor(UIColor(named: "derkGrey"), for: .normal)
        isPrevious = true
        tableview.reloadData()
    }
    
    func getOrders(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.customerOrders ,isAuthRequired:  true).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataArrayResponse<CustomerOrders>.self, from: response.data!)
                if Status.code == 200 && Status.data != nil{
                    Status.data?.forEach{
                        if $0.status == 0 {
                            self.customerOrdersCurrnt.append($0)
                        }
                        if $0.status == 1{
                            self.customerOrdersPrevious.append($0)
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



extension MyOrderVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isPrevious ? customerOrdersPrevious.count :customerOrdersCurrnt.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(isPrevious){
            let cell = tableview.dequeueReusableCell(withIdentifier: "PreviousCVC", for: indexPath) as! PreviousCVC
            let obj = customerOrdersPrevious[indexPath.row]
            cell.obj = obj
           
            
            if(obj.reviews != nil && obj.orderProcess != "-1" ){
                cell.lblEvaluation.text = "Your evaluation of the service".localized
                cell.reviewsBut.isHidden = true
                cell.ViewRate.rating = Double(obj.reviews?.rating ?? "0.0") ?? 0.0
            }else{
                if(obj.orderProcess == "-1"){
                    cell.viewRates.isHidden = true
                }else{
                    cell.viewRates.isHidden = false
                    cell.reviewsBut.isHidden = false
                    cell.lblEvaluation.text = "your opinion matters".localized
                    cell.ViewRate.rating = 0.0
                }
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
            cell.eveluationDeleget = { [weak self] in
                guard let strongSelf = self else { return }
                
                let controller = PopEvaluationServiceVC()
                controller.orderId = obj.id ?? 0
                controller.rateDeleget = { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.relodeData()
                }
                let sheet = SheetViewController(controller: controller, sizes: [.fixed(600)])
                sheet.extendedLayoutIncludesOpaqueBars = false
                strongSelf.present(sheet, animated: false, completion: nil)
                
            }
            return cell
        }
        else {
            let cell = tableview.dequeueReusableCell(withIdentifier: "CurrentCVC", for: indexPath) as! CurrentCVC
            let obj = customerOrdersCurrnt[indexPath.row]
            cell.obj = obj
            cell.viewOrderDetails = { [weak self] in
                guard let strongSelf = self else {
                    return
                }
                let vc: OrderDetailsVC = OrderDetailsVC.loadFromNib()
                vc.ordersId = obj.orderId
                vc.orders = obj
                vc.current = true
                vc.modalPresentationStyle = .fullScreen
                strongSelf.navigationController?.pushViewController(vc, animated: true)
            }
            
            cell.deleteDeleget = { [weak self] in
            guard let strongSelf = self else {  return }
                
                
                strongSelf.showAlertWithCancel(title: "Are you sure to delete the product?".localized, message: "", okAction: "Delete".localized) { _ in
                    print( "Delete Prodect")
                }
            }
            
            
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    //        self.heighttableViewCell.constant = self.tableview1.contentSize.height
    //    }
    
}

