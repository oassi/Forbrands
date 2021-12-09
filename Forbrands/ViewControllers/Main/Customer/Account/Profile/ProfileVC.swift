//
//  ProfileVC.swift
//  Forbrands
//
//  Created by osamaaassi on 05/08/2021.
//

import UIKit

class ProfileVC: SuperViewController {
    
    
    @IBOutlet weak var lblFullName: UITextField!
    @IBOutlet weak var lblMobile:   UITextField!
    //Image
    @IBOutlet var imgCoverStore:    UIImageView!
    var imagePicker:                ImagePicker!
    var selectImage:Bool? = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
       
        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getUserProfile()

    }
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
    }
    @IBAction func tapEdit(_ sender: UIButton) {
        let vc:EditProfileVC = EditProfileVC.loadFromNib()
        vc.name = lblFullName.text ?? ""
        vc.phone = lblMobile.text ?? ""
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    func uploadImage(_ image : UIImage){
        WebRequests.sendPostMultipartRequestWithImgParam(api: Endpoint.uploadImageProfile, parameters: [String : String](), img: image, withName: "image", completion: { (response, error) in
            do {
                let Status =  try JSONDecoder().decode(StatusStruct.self, from: response.data!)
                     if Status.code == 200{
                        self.showOkAlert(withTitle: "successful".localized, message:Status.message?.localized ?? "" )
                     }
                 }catch let jsonErr {
                     print("Error serializing  respone json", jsonErr)
                 }
        })

    }
    
    func getUserProfile(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.userProfile ,isAuthRequired:  true).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataResponse<UserStruct>.self, from: response.data!)
                if Status.code == 200{
                    self.lblFullName.text = Status.data?.name ?? ""
                    self.lblMobile.text = Status.data?.phone ?? ""
                    self.imgCoverStore.sd_custom(url: "\(App.IMG_URL.img_URL)\(Status.data?.image ?? "")" ,defultImage: UIImage(systemName: "person.crop.circle.badge.checkmark.fill") )
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
}
extension ProfileVC: ImagePickerDelegate {
    
    @IBAction func tapEditImgProfile(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    func didSelect(image: UIImage?) {
        guard let img = image  else {
            return
        }
        self.imgCoverStore.image = img
        uploadImage(img)
        self.selectImage = true
    }
    
}
