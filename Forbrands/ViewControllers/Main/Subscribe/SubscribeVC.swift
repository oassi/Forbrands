//
//  SubscribeVC.swift
//  Forbrands
//
//  Created by osamaaassi on 13/08/2021.
//

import UIKit

class SubscribeVC: SuperViewController {
    
    @IBOutlet weak var tableview:UITableView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblshortPrice: UILabel!
    var subscription : Subscription!
    var features = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        getSubscription()
        tableview.registerCell(id: "SubscribeCVC")
        // Do any additional setup after loading the view.
    }
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
    }
    
    @IBAction func tapSubscribe(_ sender: UIButton) {
        let vc:PaymentMethodVC =  PaymentMethodVC.loadFromNib()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getSubscription(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.subscriptionCustomer ,isAuthRequired:  false).start(){  (response, error) in
            do {
                
                let Status =  try JSONDecoder().decode(BaseDataResponse<Subscription>.self, from: response.data!)
                guard Status.code == 200 else{
                    self.showAlert(title: Status.title ?? "", message: Status.message ?? "")
                    return
                }
                
                self.subscription = Status.data!
                self.lblPrice.text =  self.subscription.price ?? ""
                self.lblshortPrice.text = MOLHLanguage.isArabic() ? Status.data!.currency?.shortNameAr ?? "ريال".localized : Status.data!.currency?.shortNameEn ?? "SAR".localized
                if MOLHLanguage.isArabic(){
                    Status.data!.featuresAr?.forEach{self.features.append($0)}
                }else{
                    Status.data!.featuresEn?.forEach{self.features.append($0)}
                }
                self.tableview.reloadData()
                
                //   Status.data!.featuresAr?.split(separator: ",") : Status.data!.featuresEn?.split(separator: ",")
                
                //                    feature?.forEach{ (String($0)) }
                
                
                
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
}

extension SubscribeVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return features.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "SubscribeCVC", for: indexPath) as! SubscribeCVC
        let str = features[indexPath.row].replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "")
        cell.lblFeatures.text = str
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: false)
    }

    
}
