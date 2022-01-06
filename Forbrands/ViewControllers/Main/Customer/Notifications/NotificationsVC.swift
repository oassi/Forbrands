//
//  NotificationsVC.swift
//  Forbrands
//
//  Created by osamaaassi on 05/08/2021.
//

import UIKit

class NotificationsVC: SuperViewController {

    @IBOutlet weak var tableview:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        tableview.registerCell(id: "NotificationsCVC")
        // Do any additional setup after loading the view.
        
        _=self.showEmptyView(emptyView: self.emptyView, parentView: self.tableview , refershSelector: #selector(self.didRefersh),firstLabel: "No notifications".localized)
        self.tableview.reloadData()
    

        
    }
  
    @objc func didRefersh() {
        print("didRefersh")
    }
    
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setTitle("Notifications".localized, sender: self, large: false)
        navgtion.setCustomBackButtonForViewController(sender: self)
    }

}

extension NotificationsVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "NotificationsCVC", for: indexPath) as! NotificationsCVC
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let vc:NotificationDisplayVC = NotificationDisplayVC.loadFromNib()
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
