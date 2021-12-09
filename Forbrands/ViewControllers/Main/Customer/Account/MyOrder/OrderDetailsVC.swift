//
//  OrderDetailsVC.swift
//  Forbrands
//
//  Created by osamaaassi on 16/08/2021.
//

import UIKit
import Cosmos
import FittedSheets
class OrderDetailsVC: SuperViewController {

    @IBOutlet var lblOrderNumber: UILabel!
    @IBOutlet var lblRequiredToPay: UILabel!
    @IBOutlet var lblOrderDate1: UILabel!
    @IBOutlet var lblTotal: UILabel!
    @IBOutlet var lblShippingExpensesPrice: UILabel!
    @IBOutlet var lblPaymentMethods: UILabel!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblAddress: UILabel!
    
    
    @IBOutlet var viewCancel: UIStackView!
    @IBOutlet var viewDetails: UIStackView!
    @IBOutlet var viewAddress: UIStackView!
    @IBOutlet var viewDetailsOrder: UIStackView!
    
    @IBOutlet var lblOrderNumber1: UILabel!
    @IBOutlet var lblTotalBeforeDiscount: UILabel!
    @IBOutlet var lblTotalDiscount: UILabel!
    @IBOutlet var lblPromDiscount: UILabel!
    
    @IBOutlet var lblOrderNumber2: UILabel!
    @IBOutlet var lblOrderDate2: UILabel!
    @IBOutlet var lblTotlas: UILabel!
    
    @IBOutlet weak var viewRate: CosmosView!
    @IBOutlet var viewEvaluation: UIStackView!
    @IBOutlet var lblEvaluation: UILabel!
    @IBOutlet var reviewsBut: UIButton!
    
    
    @IBOutlet var lblStatusOrder: UILabel!
    @IBOutlet var viewStatusOrder: UIView!
    @IBOutlet var lblDate: UILabel!
    
    
    //Underway
    @IBOutlet var imgUnderway: UIImageView!
    @IBOutlet var viewUnderway: UIView!
    @IBOutlet var lblUnderway: UILabel!
    //Charging
    @IBOutlet var imgCharging: UIImageView!
    @IBOutlet var lblCharging: UILabel!
    //Received
    @IBOutlet var imgReceived: UIImageView!
    @IBOutlet var viewReceived: UIView!
    @IBOutlet var lblReceived: UILabel!
    
    
    
    @IBOutlet var tableview1: UITableView!
    @IBOutlet var tableview2: UITableView!
    @IBOutlet var heighttableViewCell1: NSLayoutConstraint!
    @IBOutlet var heighttableViewCell2: NSLayoutConstraint!
    
    //color
    @IBOutlet var lblTotalDiscount1: UILabel!
    @IBOutlet var lblPromDiscount1: UILabel!
    @IBOutlet var currency1: UILabel!
    @IBOutlet var currency2: UILabel!
    
    var current = false
    var ordersId : String?
    var orders : CustomerOrders?
    var products = [Product]()
    var reviews: Reviews?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        tableview1.registerCell(id: "CurrentTableViewCell")
        tableview2.registerCell(id: "CurrentTableViewCell")
        if(CurrentUser.typeSelect == userType.Seller){
            viewEvaluation.isHidden = true
            lblTotalDiscount.textColor = getColorApp()
            lblPromDiscount.textColor = getColorApp()
            lblTotalDiscount1.textColor = getColorApp()
            lblPromDiscount1.textColor = getColorApp()
            currency1.textColor = getColorApp()
            currency2.textColor = getColorApp()
        }
        
        
        lblOrderNumber.text = orders?.orderId ?? ""
        lblRequiredToPay.text = orders?.totalPrice ?? "0"
        lblOrderDate1.text = orders?.orderDate ?? ""
        lblTotal.text = orders?.totalPrice ?? ""
        
        lblShippingExpensesPrice.text = orders?.deliveryPrice ?? "0"
        lblPaymentMethods.text = MOLHLanguage.isArabic() ? orders?.payMethod?.nameAr ?? "undefined".localized : orders?.payMethod?.nameEn ?? "undefined".localized
        lblName.text = orders?.address?.fullName ?? ""
        lblAddress.text = "Street: \(orders?.address?.street ?? "") - building: \(orders?.address?.building?.description ?? "") - floor: \(orders?.address?.floor?.description ?? "") - special mark: \(orders?.address?.specialMark ?? "") "
        lblDate.text = orders?.deliverDate ?? "undefined".localized
        
        switch  orders?.orderProcess?.description {
        case "-1":
            viewCancel.isHidden = false
            viewDetails.isHidden = true
            viewAddress.isHidden = true
            viewDetailsOrder.isHidden = true
        default:
            viewCancel.isHidden = true
            viewDetails.isHidden = false
            viewAddress.isHidden = false
            viewDetailsOrder.isHidden = false
        }
        
        
        lblOrderNumber2.text = orders?.orderId ?? ""
        lblOrderDate2.text = orders?.orderDate ?? ""
        lblTotlas.text = orders?.totalPrice ?? "0"
        self.lblTotlas.text = "0"
        
        orders?.products?.forEach{
            lblTotlas.text =  String((Int($0.price ?? "0")! * Int($0.amount ?? 1)) + Int( self.lblTotlas.text ?? "0")! )
        }
        
        if(orders?.products != nil){
            orders!.products!.forEach{
                products.append($0)
            }
            self.heighttableViewCell2.constant = CGFloat((orders!.products!.count) * 100)
            tableview2.reloadData()
        }
        if(orders?.reviews != nil){
            reviews = orders!.reviews!
        }
        if(reviews != nil && orders?.orderProcess != "-1" ){
            lblEvaluation.text = "Your evaluation of the service".localized
            reviewsBut.isHidden = true
            viewRate.rating = Double(reviews!.rating ?? "0.0") ?? 0.0
        }else{
            if(orders?.orderProcess == "-1"){
                viewRate.isHidden = true
            }else{
               viewRate.isHidden = false
               reviewsBut.isHidden = false
               lblEvaluation.text = "your opinion matters".localized
               viewRate.rating = 0.0
            }
        }
        
        
        
        if (orders?.orderProcess == "1"){
            imgUnderway.image = UIImage(named: "doneTrue")
            imgCharging.image = UIImage(named: "onRequest")
            imgReceived.image = UIImage(named: "onRequest")
            viewUnderway.backgroundColor = UIColor(named: "green")
            viewReceived.backgroundColor = UIColor(named: "derkGrey")
          
        }else if (orders?.orderProcess == "2"){
            imgUnderway.image = UIImage(named: "doneTrue")
            imgCharging.image = UIImage(named: "doneTrue")
            imgReceived.image = UIImage(named: "onRequest")
            viewUnderway.backgroundColor = UIColor(named: "green")
            viewReceived.backgroundColor = UIColor(named: "green")
        }
        else if (orders?.orderProcess == "3"){
            imgUnderway.image = UIImage(named: "doneTrue")
            imgCharging.image = UIImage(named: "doneTrue")
            imgReceived.image = UIImage(named: "doneTrue")
            viewUnderway.backgroundColor = UIColor(named: "green")
            viewReceived.backgroundColor = UIColor(named: "green")
        }
        else if (orders?.orderProcess == "-1"){
            lblUnderway.text = "the order has been canceled".localized
            imgUnderway.image = UIImage(named: "cancelledOrder")
            imgCharging.image = UIImage(named: "exitSearch")
            imgReceived.image = UIImage(named: "exitSearch")
            imgReceived.image = UIImage(named: "exitSearch")
            viewUnderway.backgroundColor = UIColor(named: "derkGrey")
            viewReceived.backgroundColor = UIColor(named: "derkGrey")
           
        }
        else{
            imgUnderway.image = UIImage(named: "onRequest")
            imgCharging.image = UIImage(named: "onRequest")
            imgReceived.image = UIImage(named: "onRequest")
            viewUnderway.backgroundColor = UIColor(named: "derkGrey")
            viewReceived.backgroundColor = UIColor(named: "derkGrey")
        }
        
        

    }


    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setTitle("Order details".localized, sender: self, large: false)
        navgtion.setCustomBackButtonForViewController(sender: self)
        if(current){
            navgtion.setRightButtons([navgtion.cancelOrders!], sender: self)
        }
        navgtion.navigationBar.layer.masksToBounds = false
    }
    
    override func didClickRightButton(_sender: UIBarButtonItem) {
        switch _sender.tag {
        case 110:
            var parameters = [String : String]()
            parameters["order_id"] = ordersId ?? ""
            parameters["order_process"] = "-1"
            
            _ = WebRequests.setup(controller: self).prepare(api: Endpoint.cancelOreder,parameters:parameters ,isAuthRequired: true).start(){  (response, error) in
                do {
                    let Status =  try JSONDecoder().decode(StatusStruct.self, from: response.data!)
                    if Status.code == 200{
                        self.showAlert(title: "", message: Status.message ?? "")
                        self.navigationController?.popViewController(animated: true)
                        
                    }
                }catch let jsonErr {
                    print("Error serializing  respone json", jsonErr)
                }
            }
        default:
            break
        }
    }
    
    @IBAction func tapEveluation(_ sender: UIButton) {
        let controller = PopEvaluationServiceVC()
        controller.orderId = orders?.id ?? 0
        controller.isDetalis = true
        controller.rateOrderDeleget = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.reviews = $0
            strongSelf.lblEvaluation.text = "Your evaluation of the service".localized
            strongSelf.reviewsBut.isHidden = true
            strongSelf.viewRate.rating = Double($0.rating ?? "0.0") ?? 0.0
            
        }
        let sheet = SheetViewController(controller: controller, sizes: [.fixed(600)])
        sheet.extendedLayoutIncludesOpaqueBars = false
        self.present(sheet, animated: false, completion: nil)
    }

}


extension OrderDetailsVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  (tableview1 == tableView) ? 0 : products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == tableview2){
            let cell = tableview2.dequeueReusableCell(withIdentifier: "CurrentTableViewCell", for: indexPath) as! CurrentTableViewCell
            
            cell.obj = products[indexPath.row]
            
            return cell
            
        }
       
        return UITableViewCell()
    }
    
    
}
