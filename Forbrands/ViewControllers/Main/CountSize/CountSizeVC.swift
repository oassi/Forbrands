//
//  CountSizeVC.swift
//  Forbrands
//
//  Created by osamaaassi on 12/08/2021.
//

import UIKit

class CountSizeVC: SuperViewController {

    @IBOutlet weak var tableview :UITableView!
    var countSize :Int!
    var listSize  = [Int:String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        tableview.registerCell(id: "CountSizeCVC")
        // Do any additional setup after loading the view.
    }
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
    }
    
    @IBAction func tapSave(_ sender: UIButton) {
        for vc in navigationController!.viewControllers {
            if let addProductVC  = vc as? AddProductVC {
                navigationController?.popToViewController(addProductVC, animated: true)
            }
        }
    }
}

extension CountSizeVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countSize
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "CountSizeCVC", for: indexPath) as! CountSizeCVC
        cell.lblCount.text = (indexPath.row + 1).description
        cell.lblCountSize.tag = indexPath.row
        cell.lblCountSize.delegate = self
        return cell
    }
    
   
}

extension CountSizeVC : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) -> Bool {
         if textField.tag == 0 {
         // Retrieve Term text
         } else if textField.tag == 1 {
         // Retrieve def text
         }
        return true
    }
}

