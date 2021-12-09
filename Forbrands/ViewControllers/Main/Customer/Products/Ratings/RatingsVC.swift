//
//  RatingsVC.swift
//  Forbrands
//
//  Created by osamaaassi on 05/08/2021.
//

import UIKit

class RatingsVC: SuperViewController {

    @IBOutlet weak var tableview:UITableView!
    var reviews = [Reviews]()
    var productID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        getRatings()
        tableview.registerCell(id: "RatingsCVC")
        
        // Do any additional setup after loading the view.
     
    }
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setTitle("Ratings".localized, sender: self, large: false)
        navgtion.setCustomBackButtonForViewController(sender: self)
       
    }
    
    func getRatings(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.reviewsByID,nestedParams: productID.description ,isAuthRequired:  true).start(){  (response, error) in
            do {
                
                let Status =  try JSONDecoder().decode(BaseDataResponse<ReviewsByID>.self, from: response.data!)
                if Status.code == 200{
                    let obj = Status.data
                    if(obj?.reviews != nil){
                        obj?.reviews?.forEach{self.reviews.append($0)}
                        self.tableview.reloadData()

                    }
                    
                    
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }

}

extension RatingsVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "RatingsCVC", for: indexPath) as! RatingsCVC
     
            cell.obj = reviews[indexPath.row]
            return cell
      
    }
    
    
    
}
