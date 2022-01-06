//
//  PopEvaluationServiceVC.swift
//  Forbrands
//
//  Created by osamaaassi on 16/08/2021.
//

import UIKit
import Cosmos
class PopEvaluationServiceVC: SuperViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var commants: UITextField!
    @IBOutlet weak var ViewRate: CosmosView!
    @IBOutlet var heighttableViewCell: NSLayoutConstraint!
    var selected = 0
    var orderId:Int!
    var isDetalis = false
    var comment:String?
    var rateDeleget : (() -> ())?
    var rateOrderDeleget : ((_ rating : Reviews) -> ())?
    var paymentMethods = ["Fast service","Original products","Committed to a date","Respected delegate","Simple method","Always available"]
    override func viewDidLoad() {
        super.viewDidLoad()
//        commants.placeholder = "write here".localized
        collectionView.register(UINib(nibName: "EvaluationCVC", bundle: nil), forCellWithReuseIdentifier: "EvaluationCVC")
        // Do any additional setup after loading the view.
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableviewRelodData()
    }
    func tableviewRelodData(){
        self.heighttableViewCell.constant = CGFloat(60 * (paymentMethods.count/2)) + 10
        collectionView.reloadData()
    }
    
    @IBAction func send(_ sender : UIButton){
        
        if (ViewRate.rating != 0){
            if(commants.text != nil){
                comment = "\(comment?.description ?? "") \(commants.text ?? "")"
            }
            let rating = ViewRate.rating.description
            var parameters = [String : Any]()
            parameters["order_id"] = orderId.description
            parameters["rating"] = rating
            parameters["comment"] = comment
            _ = WebRequests.setup(controller: self).prepare(api: Endpoint.addReview,parameters:parameters ,isAuthRequired: true).start(){  (response, error) in
                do {
                    let Status =  try JSONDecoder().decode(BaseDataResponse<Reviews>.self, from: response.data!)
                    if Status.code == 200{
                        if(Status.data != nil && self.isDetalis){
                            self.rateOrderDeleget?(Status.data!)
                        }else{
                            self.rateDeleget?()
                        }
                     
                        self.dismiss(animated: true, completion: nil)
                    }
                }catch let jsonErr {
                    print("Error serializing  respone json", jsonErr)
                }
            }
        }
        
    }

}

extension PopEvaluationServiceVC: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return paymentMethods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:EvaluationCVC = collectionView.dequeue(cellForItemAt: indexPath)
        cell.lblTitle.text = paymentMethods[indexPath.row].localized
        
        if  selected == indexPath.row {
            cell.viewBackgroun.backgroundColor = UIColor(named: "primary")
            cell.lblTitle.textColor = .white
            comment = paymentMethods[selected].localized
            
            }else {
                cell.viewBackgroun.backgroundColor = .white
                cell.lblTitle.textColor = UIColor(named: "primary")
             }
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
              selected = indexPath.row
        comment = paymentMethods[selected].localized
              collectionView.reloadData()
    }

    
}
extension PopEvaluationServiceVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width =  (self.view.frame.size.width - 40)/2
        return CGSize(width: width, height: 60)
    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UICollectionViewCell, forRowAt indexPath: IndexPath) {
//        self.heighttableViewCell.constant = CGFloat(60 * paymentMethods.count) + 10
//    }
    
}
