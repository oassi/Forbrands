//
//  EditSizeVC.swift
//  Forbrands
//
//  Created by osamaaassi on 20/08/2021.
//

import UIKit

class EditSizeVC: SuperViewController {

    @IBOutlet weak var tableview :UITableView!
    @IBOutlet weak var saveBut:UIButton!
    var countSize = [String]()
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
        UserDefaults.standard.set(object: countSize, forKey: "sizeLest")
        NotificationCenter.default.post(name: .didReceiveData, object: nil)
        navigationController?.popViewController(animated: true)

    }
   

}


extension EditSizeVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countSize.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "CountSizeCVC", for: indexPath) as! CountSizeCVC
        cell.lblCount.text = (indexPath.row + 1).description
        cell.lblCountSize.text = countSize[indexPath.row]
        cell.lblCountSize.tag = indexPath.row
   
        cell.lblCountSize.addTarget(self, action: #selector(textFieldDidEndEditingd(_:)), for: .allEditingEvents)

        return cell
    }
    
   
}

extension EditSizeVC : UITextFieldDelegate{
    @objc func textFieldDidEndEditingd(_ textField: UITextField) -> Bool {
        if((textField.text != "") && (textField.text != nil)){
            self.countSize[textField.tag] = textField.text!
            
        }
         if (textField.text == ""){
            self.countSize.remove(at: textField.tag)
           
        }
        return true
    }
   
   
}
