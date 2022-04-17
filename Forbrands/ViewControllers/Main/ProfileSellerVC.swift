//
//  ProfileSellerVC.swift
//  Forbrands
//
//  Created by osamaaassi on 13/08/2021.
//

import UIKit

class ProfileSellerVC: SuperViewController{
    
    
    @IBOutlet var collectionview    : UICollectionView!
    @IBOutlet var imgCoverStore     : UIImageView!
    @IBOutlet var lblFullName       : UILabel!
    @IBOutlet var lblMobile         : UILabel!
    @IBOutlet var lblEmail          : UILabel!
    @IBOutlet var lblStoreName      : UILabel!
    @IBOutlet var lblStoreLink      : UILabel!
    @IBOutlet var lblCommercial     : UILabel!
    @IBOutlet var lblIban           : UILabel!
    @IBOutlet var storePolicy       : UILabel!
    
    @IBOutlet var caverImgBut      : UIButton!
    @IBOutlet var editBut          : UIButton!
    @IBOutlet var edit2But         : UIButton!
    
    
    let color = ["primary","penkApp","primaryDarkApp","NavyblueApp","redApp","greenApp"]
    var selectedID = 0
    //Image
    var imagePicker: ImagePicker!
    var selectImage:Bool? = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionview.register(UINib(nibName: "ColoProfileSellerCell", bundle: nil), forCellWithReuseIdentifier: "ColoProfileSellerCell")
        
        colorChane()
        
        
        // Do any additional setup after loading the view.
    }
    func colorChane() {
        changColorButApp(caverImgBut,caverImgBut)
        changColorButApp(editBut)
        changColorButApp(edit2But)
    }
    
    
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
        navgtion.setTitle("My Account".localized, sender: self, large: true)
        navigationController?.navigationBar.backgroundColor = UIColor(named: "background")
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navButtons()
        getUserProfile()
        
        
        if( CurrentUser.userTrader != nil ){
            let store = CurrentUser.userTrader!
            lblStoreName.text  = store.name ?? ""
            lblStoreLink.text  = store.maroofLink ?? ""
            lblCommercial.text = store.commercialRecord ?? ""
            lblIban.text       = store.iban ?? ""
            storePolicy.text   = store.storePolicy ?? ""
            
            imgCoverStore.sd_custom(url: "\(App.IMG_URL.img_URL)\(store.image ?? "")",defultImage: UIImage(named: "caverImg"))
        }
    }
    
    @IBAction func tapEdit(_ sender: UIButton) {
     
        switch  sender.tag {
        case 0:
            var vc = EditProfileSellerVC.loadFromNib()
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 1:
            var vc = EditStoreInformationVC.loadFromNib()
            if( CurrentUser.userTrader != nil ){
                vc.storeData = CurrentUser.userTrader
            }
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
          
        default:
            break
        }
        
        
    }
    
    func uploadImage(_ image : UIImage){
        let id = CurrentUser.userTrader?.id?.description ?? "0"
        WebRequests.sendPostMultipartRequestWithImgParam(api: Endpoint.uploadImageStore,nestedParams: id, parameters: [String : String](), img: image, withName: "image", completion: { (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<StoreTrader>.self, from: response.data!)
                
                guard Status.code == 200 else{
                    self.showAlert(title: Status.title ?? "", message: Status.message ?? "")
                    return
                }
                CurrentUser.userTrader = Status.data
               
                self.showOkAlert(withTitle: "successful".localized, message:Status.message?.localized ?? "" )
                
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        })
    }
    
    func getUserProfile(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.userProfile ,isAuthRequired:  true).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<UserStruct>.self, from: response.data!)
                guard Status.code == 200 else{
                    self.showAlert(title: Status.title ?? "", message: Status.message ?? "")
                    return
                }
                
                self.lblFullName.text = Status.data?.name ?? ""
                self.lblEmail.text =  Status.data?.email ?? ""
                self.lblMobile.text = Status.data?.phone ?? ""
                self.storePolicy.text = Status.data?.storePolicy ?? ""
                
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
}

extension ProfileSellerVC: ImagePickerDelegate {
    @IBAction func showImagePicker(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    func didSelect(image: UIImage?) {
        guard let img = image  else {
            return
        }
        self.imgCoverStore.image = img
      
        self.selectImage = true
    }
    
}
extension ProfileSellerVC: UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return color.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ColoProfileSellerCell = collectionView.dequeue(cellForItemAt: indexPath)
        cell.viewColor.backgroundColor = UIColor(named: color[indexPath.row])
        if(color[indexPath.row] == getColorName()){
            cell.imgColor.isHidden = false
        }else{
            cell.imgColor.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch color[indexPath.row] {
        case "primary":
            CurrentUser.colorSelect =  AssetsColor.primary
        case "penkApp":
            CurrentUser.colorSelect =  AssetsColor.penkApp
        case "primaryDarkApp":
            CurrentUser.colorSelect =  AssetsColor.primaryDarkApp
        case "NavyblueApp":
            CurrentUser.colorSelect =  AssetsColor.NavyblueApp
        case "redApp":
            CurrentUser.colorSelect =  AssetsColor.redApp
        case "greenApp":
            CurrentUser.colorSelect =  AssetsColor.greenApp
        default:
            break
        }
        colorChane()
        let vc:TTabBarController = TTabBarController.loadFromNib()
        vc.modalPresentationStyle = .fullScreen
        self.goToRoot(vc)
        vc.selectedIndex = 2
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "colorChange"), object: nil)
        collectionview.reloadData()
    }
    
}

extension ProfileSellerVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width =  (self.view.frame.size.width - 40 )/7
        return CGSize(width: width, height:32)
    }
}

extension UIViewController {
    
    func getColorName() -> String{
        if CurrentUser.colorSelect != nil{
            return CurrentUser.colorSelect!.rawValue
        }else{
            CurrentUser.colorSelect = AssetsColor.primary
            return CurrentUser.colorSelect!.rawValue
        }
        
    }
    
    func getColorApp() -> UIColor{
        if CurrentUser.colorSelect != nil{
            return  UIColor(named: CurrentUser.colorSelect!.rawValue)!
        }else{
            CurrentUser.colorSelect = AssetsColor.primary
            return  UIColor(named: CurrentUser.colorSelect!.rawValue)!
        }
    }
    
    func changColorButApp(_ but : UIButton, _ border:UIButton = UIButton()){
        but.setTitleColor(getColorApp(), for: .normal)
        border.borderColor = getColorApp()
    }
    func changBackgroundColorButApp(_ but : UIButton, _ border:UIButton = UIButton()){
        but.backgroundColor = getColorApp()
        border.borderColor = getColorApp()
    }
    
}
extension UIColor {
    static func appColor(_ name: String) -> UIColor? {
        return UIColor(named: name)
    }
}
