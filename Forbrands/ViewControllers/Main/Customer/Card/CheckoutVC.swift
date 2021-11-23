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
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        tableview.registerCell(id: "CheckoutCVC")
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
        let vc:PopPaymentVC = PopPaymentVC.loadFromNib()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
    }

}
extension CheckoutVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "CheckoutCVC", for: indexPath) as! CheckoutCVC
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.heighttableViewCell.constant = self.tableview.contentSize.height
    }
    
    
}
