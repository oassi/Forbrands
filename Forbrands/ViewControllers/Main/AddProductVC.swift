//
//  AddProductVC.swift
//  Forbrands
//
//  Created by osamaaassi on 11/08/2021.
//

import UIKit
import ActionSheetPicker_3_0
import AlignedCollectionViewFlowLayout

class AddProductVC: SuperViewController,UITextViewDelegate {
    
    
    @IBOutlet weak var collectionView1          :UICollectionView!
    @IBOutlet weak var collectionView2          :UICollectionView!
    @IBOutlet weak var lblCategory              :UITextField!
    @IBOutlet weak var lblProductNameAr         :UITextField!
    @IBOutlet weak var lblProductNameEn         :UITextField!
    @IBOutlet weak var lblPrice                 :UITextField!
    @IBOutlet weak var lblPriceDiscount         :UITextField!
    @IBOutlet weak var lblProductDetailsArabic  :UITextView!
    @IBOutlet weak var lblProductDetailsEnglish :UITextView!
    @IBOutlet weak var viewAddSize              :UIView!
    @IBOutlet weak var viewEditBut              :UIButton!
  
    @IBOutlet weak var heighttableViewSearch    :NSLayoutConstraint!
    
    var selectedTypeCategoryID:String?
    var sizeLest = ["100000m","43m","344m","5345345m","34534m","3453m","456m","100m","23m"]
    var categoryLest = ["عطور رجالي","عطور نسائي","معطرات"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        registerCell()
        lblProductDetailsArabic.placeholder = "Product details in Arabic"
        lblProductDetailsEnglish.placeholder = "Product details in English"
        
        lblCategory.delegate = self
        lblProductNameAr.delegate = self
        lblProductNameEn.delegate = self
        lblPrice.delegate = self
        lblPriceDiscount.delegate = self

       
//        if self.oldSearch.count == 0{
//
//            self.heighttableViewSearch.constant = 0
//        }else{
//            self.heighttableViewSearch.constant = 156
//            self.collectionView1.reloadData()
//        }
    }
    
  
    
    private func registerCell(){
        collectionView1.register(UINib(nibName: "AddProductImgCVC", bundle: nil), forCellWithReuseIdentifier: "AddProductImgCVC")
        collectionView1.register(UINib(nibName: "AddImgProductCVC", bundle: nil), forCellWithReuseIdentifier: "AddImgProductCVC")
        collectionView2.register(UINib(nibName: "SizeProductCVC", bundle: nil), forCellWithReuseIdentifier: "SizeProductCVC")
        
        let flowLayout = collectionView2?.collectionViewLayout as? AlignedCollectionViewFlowLayout
        flowLayout?.horizontalAlignment = .right
        flowLayout?.minimumInteritemSpacing = 2
        flowLayout?.minimumLineSpacing = 10
    }
    
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
    }
    
    @IBAction func tapGetCatrgory(_ sender: UIButton) {
        self.selectedTypeCategoryID = nil
        ActionSheetStringPicker.show(withTitle: self.lblCategory.text ?? "Category".localized, rows: self.categoryLest.map { $0 as Any }
            , initialSelection: 0, doneBlock: {
                picker, value, index in
                if let Value = index {
                    self.lblCategory.text = Value as? String
                    self.selectedTypeCategoryID = self.categoryLest[value]
                    self.lblProductNameAr.becomeFirstResponder()
                }
                return
        }, cancel: { ActionStringCancelBlock in return }, origin: sender)
    }
    
    @IBAction func tapEditSize(_ sender: UIButton) {
    }
    @IBAction func tapAddSizeProduct(_ sender: UIButton) {
        let vc: AddSizeProductVC = AddSizeProductVC.loadFromNib()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
    @IBAction func tapAddProduct(_ sender: UIButton) {
        let vc: DetailsProductVC = DetailsProductVC.loadFromNib()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

    
}






extension AddProductVC: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let dataCount =  (collectionView == collectionView1) ? 10 : sizeLest.count
        return dataCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == collectionView1){
            let cell:AddProductImgCVC = collectionView.dequeue(cellForItemAt: indexPath)
            let cellAdd:AddImgProductCVC = collectionView.dequeue(cellForItemAt: indexPath)
            if (indexPath.row == 0){
                return cellAdd
            }
            return cell
        }
         if(collectionView == collectionView2){
            let cellSize:SizeProductCVC = collectionView.dequeue(cellForItemAt: indexPath)
            cellSize.lblSize.text = sizeLest[indexPath.row]
            return cellSize
        }
        
        
        return UICollectionViewCell()
    }
    
    
}
extension AddProductVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == collectionView1){
            let width =  (self.view.frame.size.width )/2.5
            return CGSize(width: width, height: 136)
        }
        else if(collectionView == collectionView2){
            var widths : CGFloat = 80
            let text = sizeLest[indexPath.item]
            widths = estimateFrameForText(text).width + 50
            return CGSize(width: widths, height: 46)
        }
        return CGSize(width: 0, height: 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.heighttableViewSearch.constant = self.collectionView2.contentSize.height
        
    }
    
  
}
extension AddProductVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == lblProductNameAr){
            lblProductNameEn.becomeFirstResponder()
        }else if (textField == lblProductNameEn){
            lblPrice.becomeFirstResponder()
        }
        else if (textField == lblPrice){
            lblPriceDiscount.becomeFirstResponder()
        }
        else if (textField == lblPriceDiscount){
            lblProductDetailsArabic.becomeFirstResponder()
        }
        return true
    }
}
