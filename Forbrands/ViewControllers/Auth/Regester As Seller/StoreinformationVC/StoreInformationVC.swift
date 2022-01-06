//
//  StoreInformationVC.swift
//  Forbrands
//
//  Created by osamaaassi on 09/08/2021.
//

import UIKit

class StoreInformationVC: SuperViewController,UITextViewDelegate {
    
    @IBOutlet weak var lblStorName:                 UITextField!
    @IBOutlet weak var lblStoreDetails:             UITextView!
    @IBOutlet weak var lblStoreLink:                UITextField!
    @IBOutlet weak var lblCommercialRegistrationNo: UITextField!
    @IBOutlet weak var lblIban:                     UITextField!
    @IBOutlet weak var storePolicy:                      UITextView!
    @IBOutlet weak var collectionView:              UICollectionView!
    //Image
    @IBOutlet var imgCoverStore:    UIImageView!
    var imagePicker:                ImagePicker!
    var imageStore : UIImage!
    var selectImage:Bool = false
    var paymentMethods = [PayMethods]()
    var arrSelectedIndex = [IndexPath]()
    var arrSelectedData = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        getPayMethods()
        registerCell()
        lblStoreDetails.placeholder = "Store Details".localized
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
    }
    private func navButtons(){
        
        let navgtion = self.navigationController as! CustomNavigationBar
        if(UserDefaults.standard.bool(forKey: "isNotCompleteData")){
            navgtion.navigationBar.layer.masksToBounds = true
            navgtion.navigationBar.barTintColor = UIColor(named: "white")
        }else{
            navgtion.setCustomBackButtonForViewController(sender: self)

        }
       
    }
    private  func registerCell(){
        collectionView.register(UINib(nibName: "PaymentMethodsCVC", bundle: nil), forCellWithReuseIdentifier: "PaymentMethodsCVC")
    }
    
    @IBAction func tapConfirm(_ sender: UIButton) {
        authStoreInfo()
    }
    
    func getPayMethods(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.payMethods ,isAuthRequired:  false).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<PayMethodObj>.self, from: response.data!)
                
                if Status.code == 200{
                    if(Status.data?.payMethods != nil){
                        self.paymentMethods += Status.data!.payMethods!
                        self.collectionView.reloadData()
                    }
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    func authStoreInfo(){
        guard selectImage else{
            self.showAlert(title: "Error".localized, message: "Please selected imgae stores".localized)
            return
        }
        guard let storName = self.lblStorName.text, !storName.isEmpty else{
            self.showAlert(title: "Error".localized, message: "Stor Name cannot be empty".localized)
            lblStorName.becomeFirstResponder()
            return
        }
        guard let details = self.lblStoreDetails.text, !details.isEmpty else{
            self.showAlert(title: "Error".localized, message: "Store details cannot be empty".localized)
            lblStoreDetails.becomeFirstResponder()
            return
        }
        guard let iban = self.lblIban.text, !iban.isEmpty else{
            self.showAlert(title: "Error".localized, message: "Iban cannot be empty".localized)
            lblIban.becomeFirstResponder()
            return
        }
        
        guard let storePolicy = self.storePolicy.text, !storePolicy.isEmpty else{
            self.showAlert(title: "Error".localized, message: "Store policy cannot be empty".localized)
            self.storePolicy.becomeFirstResponder()
            return
        }
        
        guard arrSelectedData.count != 0 else {
            self.showAlert(title: "Error".localized, message: "Please selected Payment methods".localized)
            return
        }
        var parameters: [String: Any] = [:]
        parameters["name"] = storName
        parameters["detail"] = details
        parameters["maroof_link"] = lblStoreLink.text ?? ""
        parameters["commercial_record"] = lblCommercialRegistrationNo.text ?? ""
        parameters["iban"] = iban
        parameters["store_policy"] = storePolicy
        let arr = "[\(arrSelectedData.map{String($0)}.joined(separator: ","))]"
        parameters["pay_methods"] = arr
        
        addStoreInfo(parameters,imageStore)
    }
    func addStoreInfo(_ parameters: [String:Any] , _ image : UIImage){
        WebRequests.sendPostMultipartRequestWithImgParam(api: Endpoint.addStoresInfo, parameters: parameters, img: image, withName: "image", completion: { (response, error) in
            
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<UserData>.self, from: response.data!)
                
                if Status.code == 200{
                    CurrentUser.userTrader = Status.data?.store
                    self.showAlert(title: "successful", message: Status.message?.localized ?? "")
                    UserDefaults.standard.set(false, forKey: "isNotCompleteData")
                    let vc:AdvertiseWithUsVC = AdvertiseWithUsVC.loadFromNib()
                    vc.modalPresentationStyle = .fullScreen
                    vc.tabBarController?.navigationItem.hidesBackButton = true
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        })
    }
    
}
extension StoreInformationVC: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return paymentMethods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaymentMethodsCVC", for: indexPath) as! PaymentMethodsCVC
        
        cell.lblNamePayment.text = MOLHLanguage.isArabic() ? paymentMethods[indexPath.row].nameAr  ?? "": paymentMethods[indexPath.row].nameEn ?? ""
        
        if arrSelectedIndex.contains(indexPath) {
            cell.butPayment.setImage(UIImage(named: "doneTrue"), for: .normal)
        }else {
            cell.butPayment.setImage(UIImage(named: "emptyDot"), for: .normal)
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let strData = (paymentMethods[indexPath.item])
        if arrSelectedIndex.contains(indexPath) {
            arrSelectedIndex = arrSelectedIndex.filter { $0 != indexPath}
            arrSelectedData = arrSelectedData.filter { $0 != strData.id}
        }
        else {
            arrSelectedIndex.append(indexPath)
            arrSelectedData.append(strData.id ?? 0)
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
extension StoreInformationVC: ImagePickerDelegate {
    @IBAction func showImagePicker(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    func didSelect(image: UIImage?) {
        guard let img = image  else {
            return
        }
        self.imgCoverStore.image = img
        self.imageStore = img
        self.selectImage = true
    }
    
}
