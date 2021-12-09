//
//  AddSizeProductVC.swift
//  Forbrands
//
//  Created by osamaaassi on 12/08/2021.
//

import UIKit

class AddSizeProductVC: SuperViewController ,UIPickerViewDataSource, UIPickerViewDelegate {
  
    
    
    
   @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var addSizeBut:UIButton!
    let minNum = 1
    let maxNum = 10
    var pickerData: [Int]!
    var color: UIColor!
    var size: UIFont!
    var titleData = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        pickerData = Array(stride(from: minNum, to: maxNum + 1, by: 1))
        pickerView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        changBackgroundColorButApp(addSizeBut)
    }
    
    @IBAction func tapAddSizeProduct(_ sender: UIButton) {
        let vc: CountSizeVC = CountSizeVC.loadFromNib()
        vc.countSize = titleData
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return maxNum
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return minNum
    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
         titleData = pickerData[row]
                  if pickerView.selectedRow(inComponent: 0) == row {
                      color = getColorApp()
                      size = UIFont.DinNextLtW23Regular(ofSize: 40)
                  } else {
                      color = getColorApp()
                      size = UIFont.DinNextLtW23Regular(ofSize: 30)
                  }
                let attrs = [
                    NSAttributedString.Key.foregroundColor: color,
                    NSAttributedString.Key.font: size
                ]
              
        return NSAttributedString(string: titleData.description, attributes: attrs as [NSAttributedString.Key : Any])

        }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    pickerView.reloadAllComponents()

       }
}
