//
//  CardVC.swift
//  Forbrands
//
//  Created by osamaaassi on 06/08/2021.
//

import UIKit

class CardVC: SuperViewController {
    
    @IBOutlet weak var tableview:UITableView!
    @IBOutlet weak var lblPromeCode:UITextField!
    @IBOutlet weak var lblPromeCodeDescountPrice:UILabel!
    @IBOutlet weak var lblTotlaPrice:UILabel!
    @IBOutlet weak var viewDescount:UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        tableview.registerCell(id: "CardCVC")
        // Do any additional setup after loading the view.
    }
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setRightButtons([navgtion.notificaltionBut!,navgtion.favoritesBut!], sender: self)
    }
    
    override func didClickRightButton(_sender: UIBarButtonItem) {
        switch _sender.tag {
        case 77:
            let vc:FavoritesVC = FavoritesVC.loadFromNib()
            vc.hidesBottomBarWhenPushed = true
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        case 66:
            let vc:NotificationsVC = NotificationsVC.loadFromNib()
            vc.hidesBottomBarWhenPushed = true
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    @IBAction func deletePromoCode (_ sender : UIButton){
        viewDescount.isHidden = true
        lblPromeCode.text = ""
    
    }
    @IBAction func tapPurchase (_ sender : UIButton){
        let vc:AddressesVC = AddressesVC.loadFromNib()
        vc.isCard = true
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func tapPromoCode (_ sender : UIButton){
        
        let vc:PopPromoCodeVC = PopPromoCodeVC.loadFromNib()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
    
    
    }
    

}


extension CardVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "CardCVC", for: indexPath) as! CardCVC
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
