//
//  SearchSellerVC.swift
//  Forbrands
//
//  Created by osamaaassi on 11/08/2021.
//

import UIKit

class SearchSellerVC: SuperViewController {

    @IBOutlet weak var tableview:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.registerCell(id: "SearchResultSellerCVC")
        // Do any additional setup after loading the view.
    }

}
extension SearchSellerVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "SearchResultSellerCVC", for: indexPath) as! SearchResultSellerCVC
        
        cell.deleteDeleget = {   [weak self]  in
            guard let strongSelf = self else { return }
            strongSelf.showAlertWithCancel(title: "Do you want to delete this product?".localized, message: "", okAction: "Delete") { (UIAlertAction) in
            }
        }
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
    
    
}
