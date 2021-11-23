//
//  RatingsVC.swift
//  Forbrands
//
//  Created by osamaaassi on 05/08/2021.
//

import UIKit

class RatingsVC: SuperViewController {

    @IBOutlet weak var tableview:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        tableview.registerCell(id: "RatingsCVC")
        
        // Do any additional setup after loading the view.
     
    }
    
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setTitle("Ratings".localized, sender: self, large: false)
        navgtion.setCustomBackButtonForViewController(sender: self)
       
    }

}

extension RatingsVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "RatingsCVC", for: indexPath) as! RatingsCVC
        return cell
    }
    
    
    
}
