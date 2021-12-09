//
//  SearchSellerVC.swift
//  Forbrands
//
//  Created by osamaaassi on 11/08/2021.
//

import UIKit

class SearchSellerVC: SuperViewController, UISearchBarDelegate {

    @IBOutlet weak var tableview:UITableView!
    lazy var searchBars:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 40))
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.registerCell(id: "SearchResultSellerCVC")
        navButtons()
        // Do any additional setup after loading the view.
        
    }
    
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonWithdismiss(sender: self)
        searchBars.delegate = self
        searchBars.tintColor = .black
        searchBars.searchTextField.textColor = .black
        searchBars.showsCancelButton = true
        searchBars.placeholder = "Search for".localized
        searchBars.sizeToFit()
        searchBars.searchTextField.backgroundColor =  UIColor(named: "searchbar")
        let leftNavBarButton = UIBarButtonItem(customView: searchBars)
        navgtion.setRightButtons([leftNavBarButton], sender: self)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBars.searchTextField.text = ""
        self.navigationController?.popViewController(animated: true)
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
