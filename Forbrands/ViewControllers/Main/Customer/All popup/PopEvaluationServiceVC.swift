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
    
    var paymentMethods = ["Pay when receiving","Pay by mada","STC Pay","Master Card","Visa","Visa"]
    override func viewDidLoad() {
        super.viewDidLoad()
        commants.placeholder = "wirte here".localized
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
        dismiss(animated: true, completion: nil)
    }

}

extension PopEvaluationServiceVC: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return paymentMethods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:EvaluationCVC = collectionView.dequeue(cellForItemAt: indexPath)
        cell.lblTitle.text = paymentMethods[indexPath.row]
        
        if  selected == indexPath.row {
            cell.viewBackgroun.backgroundColor = UIColor(named: "primary")
            cell.lblTitle.textColor = .white
            
            }else {
                cell.viewBackgroun.backgroundColor = .white
                cell.lblTitle.textColor = UIColor(named: "primary")
             }
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
              selected = indexPath.row
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
