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
    @IBOutlet weak var addProductBut            :UIButton!
    @IBOutlet weak var lblOption                :UILabel!
    @IBOutlet weak var heighttableViewSearch    :NSLayoutConstraint!
    @IBOutlet weak var isReturnProdectBut     : UIButton!
    
    var categories = [CategoriesHome]()
    
    var isEdit = false
    var productId:String?
    //Image
    var imagePicker: ImagePicker!
    var selectImage:Bool? = false
    
    var imgProducts = [UIImage]()
    
    var selectedTypeCategoryID:String?
    lazy var sizeLest = UserDefaults.standard.object([String].self, with: "sizeLest")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        registerCell()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        lblProductDetailsArabic.placeholder = "Product details in Arabic".localized
        lblProductDetailsEnglish.placeholder = "Product details in English"
        
        lblCategory.delegate = self
        lblProductNameAr.delegate = self
        lblProductNameEn.delegate = self
        lblPrice.delegate = self
        lblPriceDiscount.delegate = self
        isSizeEmpty()
        
        if(isEdit){
            getProduct()
            lblProductDetailsArabic.placeholder  = ""
            lblProductDetailsEnglish.placeholder = ""
            addProductBut.setTitle("Edit Product".localized, for: .normal)
        }else{
            addProductBut.setTitle("Add Product".localized, for: .normal)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveData, object: nil)
    }
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        NotificationCenter.default.removeObserver(self, name: .didReceiveData,object: nil)
//    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        reloadDate()
        changBackgroundColorButApp(addProductBut)
        changColorButApp(viewEditBut)
        lblOption.textColor = getColorApp()
    }
    @objc func onDidReceiveData(_ notification: Notification){
        sizeLest = UserDefaults.standard.object([String].self, with: "sizeLest")
        isSizeEmpty()
        collectionView1.reloadData()
        collectionView2.reloadData()
    }
    
    func reloadDate()  {
        categories.removeAll()
        getCategories()
    }
    
    func isSizeEmpty(){
        if (sizeLest?.count != 0){
            viewAddSize.isHidden = true
            viewEditBut.isHidden = false
            collectionView2.isHidden = false
        }
        else {
            viewAddSize.isHidden = false
            viewEditBut.isHidden = true
            collectionView2.isHidden = true
        }
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
        ActionSheetStringPicker.show(withTitle: self.lblCategory.text ?? "Category".localized, rows: self.categories.map { $0.name as Any }
            , initialSelection: 0, doneBlock: {
               picker, value, index in
                if let Value = index {
                self.lblCategory.text = Value as? String
                self.selectedTypeCategoryID = self.categories[value].id?.description
                self.lblProductNameAr.becomeFirstResponder()
             }
                return
     }, cancel: { ActionStringCancelBlock in return }, origin: sender)
    }
    
    func getCategories(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.categoriesList ,isAuthRequired:  false).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataArrayResponse<CategoriesHome>.self, from: response.data!)
                if Status.code == 200{
                    guard Status.data != nil else {
                        return
                    }
                    self.categories += Status.data!
                    self.categories.forEach{
                        if($0.id?.description == self.selectedTypeCategoryID){
                            self.lblCategory.text = $0.name ?? ""
                        }
                       
                    }
                   
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
 
    
    
    
    func getProduct(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.getProduct,nestedParams: productId ?? "0" ,isAuthRequired:  true).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<Product>.self, from: response.data!)
                if Status.code == 200 && Status.data != nil{
                    let obj = Status.data!
                    self.lblProductNameAr.text = obj.nameAr ?? ""
                    self.lblProductNameEn.text = obj.nameEn ?? ""
                    self.lblPrice.text = obj.oldPrice ?? "0"
                    self.lblPriceDiscount.text = obj.price ?? "0"
                    self.lblProductDetailsArabic.text = obj.detailsAr ?? ""
                    self.lblProductDetailsEnglish.text = obj.detailsEn ?? ""
                    self.selectedTypeCategoryID = obj.categoryId ?? "0"
                    self.isReturnProdectBut.isSelected = obj.returnProduct == "1" ? true : false
                    
                    if(obj.images != nil){
                        obj.images!.forEach{
                            let url = URL(string: "\(App.IMG_URL.img_URL)" + $0)
                            DispatchQueue.main.async {
                                let data = try? Data(contentsOf: url!)
                                self.imgProducts.append(UIImage(data: data!) ?? UIImage())
                                self.collectionView1.reloadData()
                            }
                        }
                    }
                    if(obj.sizes != nil){
                        UserDefaults.standard.set(object: obj.sizes!, forKey: "sizeLest")
                        self.isSizeEmpty()
                    }
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
    
    
    @IBAction func tapEditSize(_ sender: UIButton) {
        let vc: EditSizeVC = EditSizeVC.loadFromNib()
        if sizeLest?.count != nil {
            vc.countSize =  sizeLest!
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    @IBAction func tapAddSizeProduct(_ sender: UIButton) {
        let vc: AddSizeProductVC = AddSizeProductVC.loadFromNib()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
      }
    
   
    @IBAction func tapIsReturnButton(_ sender: UIButton) {
        isReturnProdectBut.isSelected = !sender.isSelected
        
    }

    func CheckProduct(){
        guard  imgProducts.count != 0 else{
            self.showAlert(title: "Error".localized, message: "Please select product image".localized)
            lblProductDetailsArabic.becomeFirstResponder()
            return
        }
        
        guard (selectedTypeCategoryID != nil) else {
            showAlert(title: "", message: "Please select Category".localized)
            return
        }
   
        guard let productNameAr = self.lblProductNameAr.text, !productNameAr.isEmpty else{
            self.showAlert(title: "Error".localized, message: "The Product name is Arabic cannot be empty".localized)
            lblProductNameAr.becomeFirstResponder()
            return
        }

        guard let productNameEn = self.lblProductNameEn.text, !productNameEn.isEmpty else{
            self.showAlert(title: "Error".localized, message: "The Product name is English cannot be empty".localized)
            lblProductNameEn.becomeFirstResponder()
            return
        }
       
        guard let price = self.lblPrice.text, !price.isEmpty else{
            self.showAlert(title: "Error".localized, message: "Price cannot be empty".localized)
            lblPrice.becomeFirstResponder()
            return
        }
     
        guard let productDetailsAr = self.lblProductDetailsArabic.text, !productDetailsAr.isEmpty else{
            self.showAlert(title: "Error".localized, message: "The Product details cannot be empty".localized)
            lblProductDetailsArabic.becomeFirstResponder()
            return
        }
        
        guard let productDetailsEn = self.lblProductDetailsEnglish.text, !productDetailsEn.isEmpty else{
            self.showAlert(title: "Error".localized, message: "The Product details cannot be empty".localized)
            lblProductDetailsEnglish.becomeFirstResponder()
            return
        }
        var parameters: [String: Any] = [:]
        parameters["category_id"] = selectedTypeCategoryID?.description
        parameters["name_ar"] = productNameAr
        parameters["name_en"] = productNameEn
        parameters["details_ar"] = productDetailsAr
        parameters["details_en"] = productDetailsEn
        parameters["old_price"] = price
        parameters["store_id"] = CurrentUser.userInfo?.store?.id?.description ?? "0"
        parameters["status"] = "1"
        parameters["returnproduct"] = "\( self.isReturnProdectBut.isSelected ? 1 : 0)"
    
        
        
        parameters["sizes"] = json(from: sizeLest as Any)
        if(self.lblPriceDiscount != nil){
            parameters["price"] = lblPriceDiscount.text?.description
        }
        if(isEdit){
            addProduct(parameters,imgProducts, api: Endpoint.editProduct,id: productId ?? "0")
        }else{
            addProduct(parameters,imgProducts, api: Endpoint.addProduct)
        }
    }
            
    @IBAction func tapAddProduct(_ sender: UIButton) {
        CheckProduct()
    }
    
    func addProduct(_ parameters : [String : Any],_ imgProducts: [UIImage],api : Endpoint,id:String = ""){
        WebRequests.sendPostMultipartRequestWithMultiImgs(api:  api,nestedParams: id, parameters: parameters, imges: imgProducts, withName: "images", completion: { (response, error)
             in
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<ProductByID>.self, from: response.data!)
                
                if Status.code == 200{
                    print("_____ Add Products Done _____")
                    guard Status.data != nil else {
                        return
                    }
                    if(self.isEdit){
                        self.navigationController?.popViewController(animated: true)
                    }else{
                        let vc: DetailsProductVC = DetailsProductVC.loadFromNib()
                        vc.ProdectId = Status.data!.product?.id ?? 0
                        vc.modalPresentationStyle = .fullScreen
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    
                }else{
                    print("_____ Add Product Error _____")
                    print( Status.message ?? "")
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        })
    }
    
}


extension AddProductVC: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count  = imgProducts.isEmpty ? 1 : imgProducts.count + 1
        let dataCount =  (collectionView == collectionView1) ? count : sizeLest?.count ?? 0
        return dataCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == collectionView1){
            let cell:AddProductImgCVC = collectionView.dequeue(cellForItemAt: indexPath)
            if (indexPath.row == 0){
                let cellAdd:AddImgProductCVC = collectionView.dequeue(cellForItemAt: indexPath)
                cellAdd.addImgDeleget = {[weak self] sender in
                    self?.imagePicker.present(from: sender)
                }
                return cellAdd
            }
           
            cell.img.image = imgProducts[indexPath.row - 1]
            
            cell.deleteDeleget = { [weak self] in
                self?.imgProducts.remove(at: indexPath.row - 1)
                self?.collectionView1.reloadData()
            }
            return cell
        }
        if(collectionView == collectionView2){
            let cellSize:SizeProductCVC = collectionView.dequeue(cellForItemAt: indexPath)
            cellSize.lblSize.text = sizeLest?[indexPath.row]
            cellSize.deleteDeleget = {[weak self] in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.sizeLest?.remove(at: indexPath.row)
                strongSelf.isSizeEmpty()
                strongSelf.collectionView2.reloadData()
            }
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
            let text = sizeLest?[indexPath.item] ?? ""
            widths = estimateFrameForText(text).width + 50
            collectionView2.reloadData()
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


extension AddProductVC: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.imgProducts.append(image!)
        self.selectImage = true
        collectionView1.reloadData()
    }
    
}
