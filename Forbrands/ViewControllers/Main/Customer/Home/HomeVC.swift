//
//  HomeVC.swift
//  Forbrands
//
//  Created by osamaaassi on 06/08/2021.
//

import UIKit

class HomeVC: SuperViewController,UISearchBarDelegate, UITextFieldDelegate {

    var searchBar = UISearchBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        searchBar.endEditing(true)
    }
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setRightButtons([navgtion.notificaltionBut!,navgtion.favoritesBut!], sender: self)
        let search =   navgtion.setupSearchBar(serach: searchBar)
        search.delegate = self
        search.searchTextField.delegate = self
        let leftNavBarButton = UIBarButtonItem(customView:search)
        navgtion.setLeftsButtons([leftNavBarButton], sender: self)
    }
  

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let vc:SearchVC = SearchVC.loadFromNib()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
        return true
    }

    override func didClickRightButton(_sender: UIBarButtonItem) {
        switch _sender.tag {
        case 77:
            let vc:FavoritesVC = FavoritesVC.loadFromNib()
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        case 66:
            let vc:NotificationsVC = NotificationsVC.loadFromNib()
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }

}
