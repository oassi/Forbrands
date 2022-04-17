//
//  AddressesVC.swift
//  Forbrands
//
//  Created by osamaaassi on 05/08/2021.
//

import UIKit

class AddressesVC: SuperViewController {

    @IBOutlet weak var tableview:UITableView!
    @IBOutlet var butSave: UIButton!
    
    var addressList = [AddressList]()
    
    var selecded = 0
   
//    var productsId :Int?
    var isCard = false
    var isDiscount = false
    var amounts : Double = 0
    var addressID = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        registerCell()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let titleBut = isCard ? "Continue" : "save"
        butSave.setTitle(titleBut.localized, for: .normal)
        getMyAddresses()
        
    }
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
        navgtion.setTitle("Addresses".localized, sender: self, large: false)
        navgtion.navigationBar.tintColor = .black
    }

    
    private  func registerCell(){
        let nib1 = UINib(nibName: "AddAddressCVC", bundle: .main)
        tableview.register(nib1, forCellReuseIdentifier: "AddAddressCVC")
    }

    @IBAction func tapAddAdders(_ sender: UIButton) {
        let vc:AddAddressVC = AddAddressVC.loadFromNib()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
      
    }
    @IBAction func tapSaveAdders(_ sender: UIButton) {
        if(isCard){
            
            let vc:PayMethodVC = PayMethodVC.loadFromNib()
            vc.amounts = amounts
            vc.addressID = addressID
            vc.isDiscount = isDiscount
            
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
            
//            var parameters: [String: Any] = [:]
//            parameters["address_id"] = addressID.description
//            let arrProductsId = "[\(productsId.map{String($0)}.joined(separator: ","))]"
//            parameters["products"] =  arrProductsId
//            let arrAmounts = "[\(amounts.map{String($0)}.joined(separator: ","))]"
//            parameters["amounts"] =  arrAmounts
//
//            _ = WebRequests.setup(controller: self).prepare(api: Endpoint.addOrders,parameters: parameters ,isAuthRequired:  true).start(){  (response, error) in
//                do {
//                    let Status =  try JSONDecoder().decode(StatusStruct.self, from: response.data!)
//                    if Status.code == 200{
//                        UserDefaults.standard.removeObject(forKey: "CurrentCardItemasf")
//                        let vc:CheckoutVC = CheckoutVC.loadFromNib()
//                        vc.modalPresentationStyle = .fullScreen
//                        self.navigationController?.pushViewController(vc, animated: true)
//                    }
//                }catch let jsonErr {
//                    print("Error serializing  respone json", jsonErr)
//                }
//            }

            
      
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func getMyAddresses(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.addressList ,isAuthRequired: true).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataArrayResponse<AddressList>.self, from: response.data!)
                if Status.code == 200{
                    guard (Status.data != nil) else {
                        return
                    }
                    self.addressList.removeAll()
                    self.addressList += Status.data!
                    self.addressID = Status.data?.first?.id ?? 0
                    self.tableview.reloadData()
                }
            }catch let jsonErr {
                print("Error serializing respone json", jsonErr)
            }
        }
    }
    
    func deleteAddress(id:String, index:Int){
        App.deleteAddress(self, id: id) { bool in
            self.addressList.remove(at: index)
            self.tableview.reloadData()
        }
    }

}

extension AddressesVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "AddAddressCVC", for: indexPath) as! AddAddressCVC
        let address = addressList[indexPath.row]
        cell.lblTitle.text = indexPath.row == 0 ? "Primary address".localized : "Another Address".localized
        cell.deleteButton.isHidden = indexPath.row == 0 ? true : false
        
        cell.addressList = address
        
        let img = selecded == indexPath.row ? UIImage(named: "fillDot") : UIImage(named: "emptyChecked")
        cell.addressSelectImg.image = img

        cell.editAddress = { [weak self ] in
            let vc:AddAddressVC = AddAddressVC.loadFromNib()
            vc.hidesBottomBarWhenPushed = true
            vc.modalPresentationStyle = .fullScreen
            vc.addressInfo = address
            vc.isEdit = true
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        cell.deleteButtonAction = {
            self.deleteAddress(id: address.id?.description ?? "", index: indexPath.row)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        selecded = indexPath.row
        addressID = addressList[indexPath.row].id ?? 0
        tableview.reloadData()
    }
    
  
}


