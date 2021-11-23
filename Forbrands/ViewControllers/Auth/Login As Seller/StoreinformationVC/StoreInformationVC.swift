//
//  StoreInformationVC.swift
//  Forbrands
//
//  Created by osamaaassi on 09/08/2021.
//

import UIKit

class StoreInformationVC: SuperViewController {

    @IBOutlet weak var lblStorName: UITextField!
    @IBOutlet weak var lblStoreLink: UITextField!
    @IBOutlet weak var lblIban: UITextField!
    @IBOutlet weak var lblCommercialRegistrationNo: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var paymentMethods = ["Pay when receiving","Pay by mada","STC Pay","Master Card","Visa"]
    var arrSelectedIndex = [IndexPath]()
    var arrSelectedData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        
        collectionView.register(UINib(nibName: "PaymentMethodsCVC", bundle: nil), forCellWithReuseIdentifier: "PaymentMethodsCVC")
    }
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
    }

    @IBAction func tapAdvertiseWithUs(_ sender: UIButton) {
        let vc:AdvertiseWithUsVC = AdvertiseWithUsVC.loadFromNib()
        vc.modalPresentationStyle = .fullScreen
        vc.tabBarController?.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(vc, animated: true)
       
    }

}
extension StoreInformationVC: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return paymentMethods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaymentMethodsCVC", for: indexPath) as! PaymentMethodsCVC
        cell.lblNamePayment.text = paymentMethods[indexPath.row]
        
        if arrSelectedIndex.contains(indexPath) {
            cell.butPayment.setImage(UIImage(named: "doneTrue"), for: .normal)
            }else {
                cell.butPayment.setImage(UIImage(named: "emptyDot"), for: .normal)
             }
       
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let strData = paymentMethods[indexPath.item]
               if arrSelectedIndex.contains(indexPath) {
                   arrSelectedIndex = arrSelectedIndex.filter { $0 != indexPath}
                    arrSelectedData = arrSelectedData.filter { $0 != strData}
               }
               else {
                   arrSelectedIndex.append(indexPath)
                   arrSelectedData.append(strData)
               }
               collectionView.reloadData()
    }

    
}

extension StoreInformationVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width =  (self.view.frame.size.width - 40)/2
        return CGSize(width: width, height: 23)
    }
    
}
