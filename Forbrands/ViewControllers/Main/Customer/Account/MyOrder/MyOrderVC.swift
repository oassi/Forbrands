//
//  MyOrderVC.swift
//  Forbrands
//
//  Created by osamaaassi on 15/08/2021.
//

import UIKit

class MyOrderVC: SuperViewController {
    
    @IBOutlet var tableview1: UITableView!
    @IBOutlet var tableview2: UITableView!
    @IBOutlet var currentButton: UIButton!
    @IBOutlet var viewCurrent: UIView!
    @IBOutlet var previousButton: UIButton!
    @IBOutlet var viewPrevious: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview1.registerCell(id: "CurrentCVC")
        tableview2.registerCell(id: "PreviousCVC")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navButtons()
    }
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setTitle("My Order".localized, sender: self, large: false)
        if(CurrentUser.typeSelect ==  userType.User){
            navgtion.setCustomBackButtonForViewController(sender: self)
        }
        navgtion.navigationBar.layer.masksToBounds = true
    }
    
    @IBAction func tapCurrent(_ sender: UIButton) {
        currentButton.setTitleColor(UIColor(named: "primary"), for: .normal)
        viewCurrent.backgroundColor = UIColor(named: "primary")
        viewPrevious.backgroundColor = UIColor(named: "background")
        previousButton.setTitleColor(UIColor(named: "derkGrey"), for: .normal)
        tableview1.isHidden = false
        tableview2.isHidden = true
        
        
    }
    @IBAction func tapPrevious(_ sender: UIButton) {
        previousButton.setTitleColor(UIColor(named: "primary"), for: .normal)
        viewPrevious.backgroundColor = UIColor(named: "primary")
        viewCurrent.backgroundColor = UIColor(named: "background")
        currentButton.setTitleColor(UIColor(named: "derkGrey"), for: .normal)
        tableview1.isHidden = true
        tableview2.isHidden = false
    }
}



extension MyOrderVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == tableview1){
            return 2
        }
        if(tableView == tableview2){
            return 2
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(tableView == tableview1){
            let cell = tableview1.dequeueReusableCell(withIdentifier: "CurrentCVC", for: indexPath) as! CurrentCVC
            cell.viewOrderDetails = { [weak self] in
                guard let strongSelf = self else {
                    return
                }
                let vc: OrderDetailsVC = OrderDetailsVC.loadFromNib()
                vc.modalPresentationStyle = .fullScreen
                strongSelf.navigationController?.pushViewController(vc, animated: true)
                
            }
            return cell
        }
        if(tableView == tableview2){
            let cell = tableview2.dequeueReusableCell(withIdentifier: "PreviousCVC", for: indexPath) as! PreviousCVC
            cell.eveluationDeleget = { [weak self] in
                guard let strongSelf = self else {
                    return
                }
                let vc: PopEvaluationServiceVC = PopEvaluationServiceVC.loadFromNib()
                vc.modalPresentationStyle = .overFullScreen
                strongSelf.present(vc, animated: true, completion: nil)
                
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    //        self.heighttableViewCell.constant = self.tableview1.contentSize.height
    //    }
    
}
