//
//  CustomNavigationBar.swift
//
//
//  Created by ahmed on 6/7/18.
//  Copyright © 2018 ahmed. All rights reserved.
//

import UIKit

class CustomNavigationBar: UINavigationController,UISearchBarDelegate, UITextFieldDelegate{
    
    /// Cusotm Title Label
    var theLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "primary")
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    
    var settingBtn:           UIButton?
    var settingsBtn:          UIButton?
    var TableBtn:             UIBarButtonItem?
    var CollectionBtn:        UIBarButtonItem?
    var filterBtn:            UIBarButtonItem?
    
    var favoritesBut:           UIBarButtonItem?
    var notificaltionBut:       UIBarButtonItem?
    var titleNavStore:          UIBarButtonItem?
    var searchNavBut:          UIBarButtonItem?
    
    var isDark = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavgtion()
        setUpBtnsNav()
        setShadowNavBar()
        
    }
    
    // Mark: - SetupNav
    func setUpNavgtion(){
        self.isDark = false
        self.navigationBar.barTintColor = UIColor(named: "background")
        self.view.backgroundColor = UIColor.white
        self.navigationBar.isTranslucent = false
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.barStyle = .black
       
    }
    
    


    func setupSearchBar(serach:UISearchBar) -> UISearchBar{
        
        serach.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 120, height: 50)
        serach.placeholder = "Search for".localized
        serach.sizeToFit()
        serach.keyboardType = .default
        serach.searchTextField.textColor = UIColor(named: "black")
        serach.tintColor = UIColor(named: "primary")
        serach.isSearchResultsButtonSelected = true
        serach.searchTextField.backgroundColor =  UIColor(named: "searchbar")
        serach.searchTextField.font = UIFont.DinNextLtW23Regular(ofSize: 12)
        serach.searchBarStyle = .minimal

        return serach
    }
    
  
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
       
        searchBar.endEditing(true)
    }
   
    
    func setUpBtnsNav(){
        
        TableBtn = UIBarButtonItem(image: UIImage(named:"ic_table")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(didClickRightButton))
        
        CollectionBtn = UIBarButtonItem(image: UIImage(named:"ic_collection")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(didClickRightButton))
        
        filterBtn = UIBarButtonItem(image: UIImage(named:"ic_filter")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(didClickRightButton))
        
        favoritesBut = UIBarButtonItem(image: UIImage(named:"myFavorites")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(didClickRightButton))
        
        notificaltionBut = UIBarButtonItem(image: UIImage(named:"notification")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(didClickRightButton))
        
        searchNavBut = UIBarButtonItem(image: UIImage(named:"fillSearch")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(didClickRightButton))
        
        titleNavStore = UIBarButtonItem(title: "My Store", style: .plain, target: self, action: #selector(didClickRightButton))
       
       
        
        settingBtn  = UIButton(type: .custom)
        settingBtn!.setImage(UIImage(named: "ic_Menu"), for: .normal)
        
        settingBtn?.addTarget(self, action:#selector(didClickRightButton), for: .touchUpInside)
        
        settingsBtn  = UIButton(type: .custom)
        settingsBtn!.setImage(UIImage(named: "ic_Menu"), for: .normal)
        
        settingsBtn?.addTarget(self, action:#selector(didClickRightButton), for: .touchUpInside)
        
     
        
        TableBtn?.tag         = 22
        CollectionBtn?.tag    = 22
        settingBtn?.tag       = 55
        filterBtn?.tag        = 88
        
        favoritesBut?.tag       = 77
        notificaltionBut?.tag   = 66
        titleNavStore?.tag      = 99
        searchNavBut?.tag       = 100
        
        
        
    }
    func setBtnTitle(title :String) -> UIBarButtonItem {
        let BarButton: UIBarButtonItem = UIBarButtonItem.init(title: title, style: .plain, target: self, action: #selector(didClickRightButton))
        BarButton.tintColor = .black
        return BarButton
    }
    
    func setupFirsrBtn(sender :UIButton) {
        
        
        self.navigationBar.addSubview(sender)
        sender.clipsToBounds = true
        
        sender.translatesAutoresizingMaskIntoConstraints = false
        
        if MOLHLanguage.isRTLLanguage(){
            NSLayoutConstraint.activate([
                sender.leftAnchor.constraint(equalTo: navigationBar.leftAnchor, constant: 10.0),
                sender.topAnchor.constraint(equalTo: navigationBar.topAnchor, constant: 0),
                // sender.heightAnchor.constraint(equalToConstant: 50),
                sender.widthAnchor.constraint(equalToConstant: 50),
                sender.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 0),
                
            ])
        }else{
            NSLayoutConstraint.activate([
                sender.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -10.0),
                sender.topAnchor.constraint(equalTo: navigationBar.topAnchor, constant: 0),
                sender.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 0),
                
                // sender.heightAnchor.constraint(equalToConstant: 50),
                sender.widthAnchor.constraint(equalToConstant: 50)
            ])
        }
    }
    
    func setupSecoundBtn(sender :UIButton) {
        
        
        self.navigationBar.addSubview(sender)
        sender.clipsToBounds = true
        
        sender.translatesAutoresizingMaskIntoConstraints = false
        
        if MOLHLanguage.isRTLLanguage(){
            NSLayoutConstraint.activate([
                sender.leftAnchor.constraint(equalTo: navigationBar.leftAnchor, constant: 60.0),
                sender.topAnchor.constraint(equalTo: navigationBar.topAnchor, constant: 0),
                sender.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 0),
                // sender.heightAnchor.constraint(equalToConstant: 50),
                sender.widthAnchor.constraint(equalToConstant: 50)
            ])
        }else{
            NSLayoutConstraint.activate([
                sender.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -60.0),
                sender.topAnchor.constraint(equalTo: navigationBar.topAnchor, constant: 0),
                sender.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 0),
                //  sender.heightAnchor.constraint(equalToConstant: 50),
                sender.widthAnchor.constraint(equalToConstant: 50)
            ])
        }
    }
    
    func setupRightTitle(title :String) {
        theLabel.removeFromSuperview()
        
        self.navigationBar.addSubview(theLabel)
        theLabel.clipsToBounds = true
        theLabel.text = title
        theLabel.translatesAutoresizingMaskIntoConstraints = false
        if MOLHLanguage.isRTLLanguage(){
            NSLayoutConstraint.activate([
                theLabel.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -16.0),
                
                theLabel.topAnchor.constraint(equalTo: navigationBar.topAnchor, constant: 2),
                //theLabel.heightAnchor.constraint(equalToConstant: 60),
                theLabel.leftAnchor.constraint(equalTo: navigationBar.leftAnchor, constant: 120.0),
                theLabel.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 0),
                
                
                //                     theLabel.widthAnchor.constraint(equalToConstant: 126.06)
            ])
        }else{
            NSLayoutConstraint.activate([
                theLabel.leftAnchor.constraint(equalTo: navigationBar.leftAnchor, constant: 16.0),
                theLabel.topAnchor.constraint(equalTo: navigationBar.topAnchor, constant: 2),
                // theLabel.heightAnchor.constraint(equalToConstant: 60),
                theLabel.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -120.0),
                theLabel.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 0),
                
                //                     theLabel.widthAnchor.constraint(equalToConstant: 126.06)
            ])
        }
    }
    
    
    /// status Bar Color
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isDark ? .lightContent : .default
    }
    
    
    // MARK: - set BackGround Navigation
    
    func setupBackground(backGrond:UIImage? = UIImage(named: "BackGrounNav")) {
        self.navigationBar.setBackgroundImage(backGrond?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0 ,right: 0), resizingMode: .stretch), for: .default)
    }
    
    // MARK: - set Shadow Navigation
    
    func setShadowNavBar() {
        self.navigationBar.layer.masksToBounds = false
        self.navigationBar.layer.shadowColor = UIColor(named: "black")?.cgColor
        self.navigationBar.layer.shadowOpacity = 0.1
        self.navigationBar.layer.shadowRadius = 2
        self.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 1.0)
    }
    
    //MARK: - Add Logo Image As Title
    
    func setLogotitle(sender :UIViewController){
        let logo = UIImage(named: "logoHeader")
        let imageView = UIImageView(image:logo)
        sender.navigationItem.titleView = imageView
    }
    
    // Image Right Button Title Navigation
    
    func setRightButtonImageNavigation(sender : UIViewController,imgUrl:String? = "",corner:CGFloat? = 0) {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 40 , height: 40))
        btn.addTarget(self, action: #selector(didClickCustomButton), for: .touchUpInside)
        btn.sd_setImage(with: URL.init(string: imgUrl ?? ""), for: .normal)
        let BarItem = UIBarButtonItem(customView: btn)
        
        btn.widthAnchor.constraint(equalToConstant: 120).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 120).isActive = true
        btn.layer.cornerRadius = corner!
        btn.clipsToBounds = true
        btn.contentMode = .scaleAspectFill
        sender.navigationItem.rightBarButtonItem = BarItem
    }
    
    // Image Right Title Navigation
    
    func setRightImageNavigationItem(sender : UIViewController,imgUrl:String? = "",corner:CGFloat? = 0) {
        
        let imageView = UIImageView()
        imageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.layer.cornerRadius = corner!
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        if imgUrl != ""{
            imageView.sd_custom(url: imgUrl ?? "")
        }
        let item = UIBarButtonItem(customView: imageView)
        sender.navigationItem.rightBarButtonItem = item
        
    }
    
    // Image Title Left Navigation
    
    func setLeftImageNavigationItem(sender : UIViewController,img:String? = ""){
        let imageView = UIImageView()
        imageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: img ?? "")
        let item = UIBarButtonItem(customView: imageView)
        sender.navigationItem.leftBarButtonItem = item
        
    }
    
    
    
    func setupRightTitleWithMenu(title :String) {
        theLabel.removeFromSuperview()
        self.navigationBar.addSubview(theLabel)
        theLabel.clipsToBounds = true
        theLabel.text = title
        theLabel.translatesAutoresizingMaskIntoConstraints = false
        if MOLHLanguage.isRTLLanguage(){
            NSLayoutConstraint.activate([
                theLabel.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -65),
                
                theLabel.topAnchor.constraint(equalTo: navigationBar.topAnchor, constant: 2),
                theLabel.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 0),
                //theLabel.heightAnchor.constraint(equalToConstant: 60),
                theLabel.leftAnchor.constraint(equalTo: navigationBar.leftAnchor, constant: 120.0),
                
                //                     theLabel.widthAnchor.constraint(equalToConstant: 126.06)
            ])
        }else{
            
            
            NSLayoutConstraint.activate([
                
                theLabel.leftAnchor.constraint(equalTo: navigationBar.leftAnchor, constant: 65),
                theLabel.topAnchor.constraint(equalTo: navigationBar.topAnchor, constant: 2),
                theLabel.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 0),
                //theLabel.heightAnchor.constraint(equalToConstant: 60),
                theLabel.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: 126.0),
            ])
        }
    }
    
    
    
    // MARK: - custom Back
    
    func setCustomBackButtonWithdismiss(sender :UIViewController,isWhite:Bool = false){
        if isWhite{
            if MOLHLanguage.isRTLLanguage() {
                let back: UIImage? = UIImage(named:"right_back")?.withRenderingMode(.alwaysOriginal)
                
                sender.navigationItem.leftBarButtonItem = UIBarButtonItem(image: back, style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonActionWithdismiss))
                
            } else{
                let back: UIImage? = UIImage(named:"left_back")?.withRenderingMode(.alwaysOriginal)
                
                sender.navigationItem.leftBarButtonItem = UIBarButtonItem(image: back, style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonActionWithdismiss))
                
            }
        }else{
            if MOLHLanguage.isRTLLanguage() {
                let back: UIImage? = UIImage(named:"ic_blackrightback")?.withRenderingMode(.alwaysOriginal)
                
                sender.navigationItem.leftBarButtonItem = UIBarButtonItem(image: back, style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonActionWithdismiss))
                
            } else{
                let back: UIImage? = UIImage(named:"ic_blackleftback")?.withRenderingMode(.alwaysOriginal)
                
                sender.navigationItem.leftBarButtonItem = UIBarButtonItem(image: back, style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonActionWithdismiss))
            }
        }
    }
    
    func setCustomBackButtonForViewController(sender :UIViewController,isWhite:Bool = true){
        if isWhite{
            if MOLHLanguage.isRTLLanguage() {
                let back: UIImage? = UIImage(named:"right_back")?.withRenderingMode(.alwaysOriginal)
                
                sender.navigationItem.leftBarButtonItem = UIBarButtonItem(image: back, style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonAction))
                
            } else{
                let back: UIImage? = UIImage(named:"left_back")?.withRenderingMode(.alwaysOriginal)
                
                sender.navigationItem.leftBarButtonItem = UIBarButtonItem(image: back, style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonAction))
            }
        }else{
            if MOLHLanguage.isRTLLanguage() {
                let back: UIImage? = UIImage(named:"exit")?.withRenderingMode(.alwaysOriginal)
                
                sender.navigationItem.leftBarButtonItem = UIBarButtonItem(image: back, style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonAction))
                
            } else{
                let back: UIImage? = UIImage(named:"exit")?.withRenderingMode(.alwaysOriginal)
                
                sender.navigationItem.leftBarButtonItem = UIBarButtonItem(image: back, style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonAction))
            }
        }
        
    }
    
    func setMeunButton(sender :UIViewController, isWhite:Bool = false){
        //        if isWhite{
        //            sender.navigationItem.leftBarButtonItem = WhiteMenuBtn
        //        }else{
        //            sender.navigationItem.leftBarButtonItem = MenuBtn
        //        }
        
    }
    
    
    @objc func didClickRightButton(_sender: UIBarButtonItem) {
        if self.viewControllers.last!.isKind(of: SuperViewController.self){
            
            let ViewController = self.viewControllers.last as! SuperViewController
            ViewController.didClickRightButton(_sender: _sender)
        }else if self.viewControllers.last!.isKind(of: BaseViewController.self){
            
            let ViewController = self.viewControllers.last as! BaseViewController
            ViewController.didClickRightButton(_sender: _sender)
            
        }else{
            let ViewController = self.viewControllers.last
            ViewController?.navigationController?.popViewController(animated: true)
            
        }
        
    }
    
    @objc func backButtonAction(_sender: UIBarButtonItem) {
        
        if self.viewControllers.last!.isKind(of: SuperViewController.self){
            let ViewController = self.viewControllers.last as! SuperViewController
            ViewController.backButtonAction(_sender: _sender)
            
        }else if self.viewControllers.last!.isKind(of: BaseViewController.self){
            
            let ViewController = self.viewControllers.last as! BaseViewController
            ViewController.backButtonAction(_sender: _sender)
            
        }else{
            let ViewController = self.viewControllers.last
            ViewController?.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    @objc func backButtonActionWithdismiss(_sender: UIBarButtonItem) {
        
        if self.viewControllers.last!.isKind(of: SuperViewController.self){
            let ViewController = self.viewControllers.last as! SuperViewController
            ViewController.backButtonActionWithdismiss(_sender: _sender)
            
        }else if self.viewControllers.last!.isKind(of: BaseViewController.self){
            
//            let ViewController = self.viewControllers.last as! BaseViewController
//            ViewController.backButtonActionWithdismiss(_sender: _sender)
            
        }else{
            let ViewController = self.viewControllers.last
            ViewController?.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func ShowMenuAction (_sender: UIBarButtonItem){
        let vc = self.viewControllers.last
//        if vc!.isKind(of: SuperViewController.self){
//            let ViewController = self.viewControllers.last as! SuperViewController
//            ViewController.didClickMenuButton(_sender: _sender)
//
//        }else{
//            let ViewController = self.viewControllers.last as! BaseViewController
//            ViewController.didClickMenuButton(_sender: _sender)
//
//        }
        
    }
    
    @objc func didClickCustomButton(_sender: UIBarButtonItem) {
        if self.viewControllers.last!.isKind(of: SuperViewController.self){
            
            let ViewController = self.viewControllers.last as! SuperViewController
            ViewController.didClickProfileButton(_sender: _sender)
        }else if self.viewControllers.last!.isKind(of: BaseViewController.self){
            
//            let ViewController = self.viewControllers.last as! BaseViewController
//            ViewController.didClickProfileButton(_sender: _sender)
//
        }
        
    }
    
    
    func setRightButtons (_ buttons: NSArray,sender : UIViewController){
        sender.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
        
    }
    func setLeftsButtons (_ buttons: NSArray,sender : UIViewController){
        sender.navigationItem.leftBarButtonItems = buttons as? [UIBarButtonItem]
    }
    
    func setTitle (_ title: String, sender : UIViewController, large:Bool, srtingColor:String = "000000"){
        for family in UIFont.familyNames {
            print("family:", family)
            for font in UIFont.fontNames(forFamilyName: family) {
                print("font:", font)
            }
        }
        self.navigationBar.prefersLargeTitles = large
        sender.navigationItem.largeTitleDisplayMode = .always
        sender.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : srtingColor.color, NSAttributedString.Key.font: UIFont.DinNextLtW23Regular(ofSize: 30)]
        
        
        let attrs = [
            NSAttributedString.Key.foregroundColor: srtingColor.color,
            NSAttributedString.Key.font: UIFont.DinNextLtW23Regular(ofSize: 20)
        ]
        sender.navigationController?.navigationBar.titleTextAttributes = attrs
        sender.navigationItem.title = title as String
        
        sender.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: srtingColor.color,
            NSAttributedString.Key.font: UIFont.DinNextLtW23Regular(ofSize: 20)
        ]
        
        //        sender.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Cairo-SemiBold", size: 20)!]
        //        if self.viewControllers.count > 1{
        //             self.setCustomBackButtonForViewController(sender: sender)
        //               }
        //        sender.navigationItem.titleView = nil
        
        
        ////        let items = self.tabBarController?.tabBar.items
        ////        let tabItem = items![1]
        //        tabItem.title = ""
    }
    
    
}


