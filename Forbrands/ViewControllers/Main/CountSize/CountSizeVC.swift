//
//  CountSizeVC.swift
//  Forbrands
//
//  Created by osamaaassi on 12/08/2021.
//

import UIKit

class CountSizeVC: SuperViewController {

    @IBOutlet weak var tableview :UITableView!
    @IBOutlet weak var saveBut:UIButton!

    var countSize :Int!
    var listSize  = [Int:String]()
    var list = [String]()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        changBackgroundColorButApp(saveBut)
    }
    @IBAction func tapSave(_ sender: UIButton) {
        
        listSize.forEach{list.append($0.value) }
       
        UserDefaults.standard.set(object: list, forKey: "sizeLest")
        
        for vc in navigationController!.viewControllers {
            if let addProductVC  = vc as? AddProductVC {
                navigationController?.popToViewController(addProductVC, animated: true)
                NotificationCenter.default.post(name: .didReceiveData, object: nil)

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
        cell.lblCountSize.addTarget(self, action: #selector(textFieldDidEndEditingd(_:)), for: .allEditingEvents)
        
        return cell
    }
    
   
}

extension CountSizeVC : UITextFieldDelegate{
    @objc private func textFieldDidEndEditingd(_ textField: UITextField) -> Bool {
        
        if((textField.text != "") && (textField.text != nil)){
            self.listSize[textField.tag] = textField.text
            
        }
         if (textField.text == ""){
            self.listSize.removeValue(forKey: textField.tag)
        }
        return true
    }
   
   
   
}


