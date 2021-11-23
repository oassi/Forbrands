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
    var isCard = false
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        navButtons()
     
       
    }
    override func viewWillAppear(_ animated: Bool) {
        let titleBut = isCard ? "Continue" : "save"
        butSave.setTitle(titleBut.localized, for: .normal)
        
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
            let vc:CheckoutVC = CheckoutVC.loadFromNib()
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
       
      
    }

}

extension AddressesVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "AddAddressCVC", for: indexPath) as! AddAddressCVC
        
        cell.editAddress = { [weak self ] in
            let vc:AddAddressVC = AddAddressVC.loadFromNib()
            vc.hidesBottomBarWhenPushed = true
            vc.modalPresentationStyle = .fullScreen
            self?.navigationController?.pushViewController(vc, animated: true)
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
    }
}


