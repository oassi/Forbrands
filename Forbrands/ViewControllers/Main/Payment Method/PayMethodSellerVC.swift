//
//  PayMethodSellerVC.swift
//  Forbrands
//
//  Created by osamaaassi on 02/09/2021.
//

import UIKit

class PayMethodSellerVC: SuperViewController {
    @IBOutlet weak var tableview:UITableView!
    @IBOutlet weak var saveBut:UIButton!
    var paymentMethods = [PayMethods]()
    var payMeth = [String]()
    var arrSelectedIndex = [IndexPath]()
    var arrSelectedData = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        tableview.registerCell(id: "PaymentMethodsCell")
        getPayMethodsByStore()
        getPayMethods()
        
//        if( CurrentUser.userInfo?.store?.payMethods != nil){
//            var payMethods =  CurrentUser.userInfo!.store!.payMethods!
//            payMethods = removeCharacters(payMethods,characters: "[")
//            payMethods = removeCharacters(payMethods,characters: "]")
//            payMeth =  (payMethods.split(separator: ",")).map((String.init))
//        }
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if(CurrentUser.typeSelect == userType.Seller){
            changBackgroundColorButApp(saveBut)
        }
       
    }

    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
    }
    @IBAction func tapSave(_ sender: UIButton) {
        var parameters = [String : Any]()
            parameters["pay_methods"] = arrSelectedData
        
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.updatePayMethodByStore,parameters:parameters ,isAuthRequired: true).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(StatusStruct.self, from: response.data!)
                if Status.code == 200{
                    self.navigationController?.popViewController(animated: true)
                    
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
        
    }
    
    func getPayMethods(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.payMethods ,isAuthRequired:  false).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<PayMethodObj>.self, from: response.data!)
                 if Status.code == 200{
                    if(Status.data?.payMethods != nil){
                        self.paymentMethods += Status.data!.payMethods!
                        self.tableview.reloadData()
                    }
                   
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
    func getPayMethodsByStore(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.payMethodsByStore,nestedParams: "\(CurrentUser.userInfo?.store?.id ?? 0)" ,isAuthRequired:  true).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataArrayResponse<PayMethods>.self, from: response.data!)
                 if Status.code == 200{
                    if(Status.data != nil){
                        Status.data?.forEach{self.payMeth.append($0.id!.description)}
                        self.tableview.reloadData()
                    }
                   
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }

    
   
}

extension PayMethodSellerVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentMethods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "PaymentMethodsCell", for: indexPath) as! PaymentMethodsCell
        let obj = paymentMethods[indexPath.row]
        cell.lblNamePayment.text = MOLHLanguage.isArabic() ? obj.nameAr  ?? "": obj.nameEn ?? ""

        if(payMeth.count != 0){
            for i in payMeth {
                if( Int(i) == (obj.id!)){
                    arrSelectedIndex.append(indexPath)
                    arrSelectedData.append(obj.id!)
                    let pay : [String] =  payMeth.enumerated().filter{ $0.element != obj.id?.description}.map{ $0.element}
                    payMeth = pay
                   cell.imgPayment.image = UIImage(named: "doneTrue")
                }

            }
        }
        if arrSelectedIndex.contains(indexPath) {
            cell.imgPayment.image = UIImage(named: "doneTrue")
        }else {
            cell.imgPayment.image = UIImage(named: "emptyDot")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let strData = (paymentMethods[indexPath.row])
        if arrSelectedIndex.contains(indexPath) {
            arrSelectedIndex = arrSelectedIndex.filter { $0 != indexPath}
            arrSelectedData.removeAll { $0 == strData.id}

        }
        else {
            arrSelectedIndex.append(indexPath)
            arrSelectedData.append(strData.id ?? 0)
        }
        tableview.reloadData()
    }
}




