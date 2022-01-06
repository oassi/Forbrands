//
//  OnBordingVC.swift
//  Forbrands
//
//  Created by osamaaassi on 17/08/2021.
//

import UIKit
import FSPagerView

class OnBordingVC: UIViewController {
    @IBOutlet weak var lblTimmer: UILabel!
    
    var adsTpo =  [AdsHome]()
    
    var timer = Timer()
    var seconds = 5
    var currentSeconds = Date()
    var isPush = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timer.invalidate()
        startTimeer()
        getImageList()
    }
    
    func startTimeer(){
        timer.invalidate()
        self.seconds = 5
        self.currentSeconds = Date().addingTimeInterval(TimeInterval(seconds))
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerDiscount), userInfo: nil, repeats: true)
    }
    @objc func timerDiscount(){
        let startDate = Date()
        print("date",currentSeconds)
        print("date",startDate)
        let difference = Calendar.current.dateComponents([.second], from: startDate, to: currentSeconds)
        let formattedString = "\(difference.second ?? 0)"
        
        if(formattedString < "0"){
            self.lblTimmer.text = "0"
            if(isPush){
                goToLogin(0.0)
                
            }
            timer.invalidate()
        }
        else{
            let readytext = self.setupTimer(seconds: seconds)
            let mainText = "Skip".localized + readytext + "s".localized
            self.lblTimmer.text = mainText
            seconds = difference.second ?? 0
        }
    }
    
    func setupTimer(seconds:Int) -> String {
        _ = seconds / 3600
        _ = seconds / 60 % 60
        let second = seconds % 60
        return "\(String(format: "%02d", second))"
    }
    
    @IBAction func bt_Next(_ sender: Any) {
        isPush = false
        goToLogin(0.0)
    }
    
    func register<T>(_ a: T) {
        let vc = a
        (vc as! UIViewController).modalPresentationStyle = .fullScreen
        self.goToRoot(vc as! UIViewController)
    }
    
    private func goToLogin(_ tiem :Double = 5.0 ){
        if CurrentUser.userInfo == nil {
            register(LoginVC.loadFromNib().navigationController())
        }else{
            if(CurrentUser.userInfo!.roleName == "Trader"
                && CurrentUser.userInfo!.store == nil
                && CurrentUser.userTrader == nil){
                UserDefaults.standard.set(true, forKey: "isNotCompleteData")
                register(StoreInformationVC.loadFromNib().navigationController())
            }
            else{
                register(TTabBarController())
            }
            
        }
        
        //        DispatchQueue.main.async {
        //            DispatchQueue.main.asyncAfter(deadline: .now() + tiem, execute: {
        //
        //                if CurrentUser.userInfo == nil {
        //                    let vc = LoginVC.loadFromNib().navigationController()
        //                    vc.modalPresentationStyle = .fullScreen
        //                    self.goToRoot(vc)
        //                }else{
        //                    let vc = TTabBarController()
        //                    vc.modalPresentationStyle = .fullScreen
        //                    self.goToRoot(vc)
        //                }
        //            })}
    }
    
    @IBOutlet weak var pagerView: FSPagerView!{
        didSet{
            self.pagerView.automaticSlidingInterval = 3.0
            self.pagerView.isScrollEnabled = true
            self.pagerView.register(UINib(nibName: "SliderProducatCell", bundle: Bundle.main), forCellWithReuseIdentifier: "SliderProducatCell")
        }
    }
    @IBOutlet weak var pageControlle: FSPageControl!{
        didSet{
            self.pageControlle.numberOfPages = adsTpo.count
            self.pageControlle.contentHorizontalAlignment = .center
            pageControlle.setImage(UIImage(named: "emptyDotSlide"), for: .normal)
            pageControlle.setImage(UIImage(named: "fillDotSlide"), for: .selected)
        }
    }
    
    func getImageList(){
        _ = WebRequests.setup(controller: self).prepare(api: Endpoint.adsList ,isAuthRequired:  false).start(){  (response, error) in
            do {
                let Status =  try JSONDecoder().decode(BaseDataArrayResponse<AdsHome>.self, from: response.data!)
                if Status.code == 200{
                    if (Status.data != nil) {
                        if let ads = Status.data , !ads.isEmpty {
                            self.adsTpo = ads
                            self.pagerView.reloadData()
                            self.pageControlle.numberOfPages = self.adsTpo.count
                        }
                    }
                }
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
}





extension OnBordingVC:FSPagerViewDelegate,FSPagerViewDataSource{
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return adsTpo.count
    }
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "SliderProducatCell", at: index) as! SliderProducatCell
        if !adsTpo.isEmpty {
            cell.imgProducta.sd_custom(url: adsTpo[index].image ?? "")
            self.pageControlle.currentPage = pagerView.currentIndex
            cell.imgProducta?.contentMode = .scaleToFill
            return cell
        }
        return FSPagerViewCell()
        
    }
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        isPush = false
        if  adsTpo[index].productId != nil && adsTpo[index].productId != 0 {
            let vc :DetailsProductUserVC = DetailsProductUserVC.loadFromNib()
            vc.productId =  adsTpo[index].productId ?? 0
            vc.isAds = true
            self.goToRoot(vc.navigationController())
            
        }
        else if  adsTpo[index].link != nil && adsTpo[index].productId == 0 {
            let vc :webViewAdsVC = webViewAdsVC.loadFromNib()
            vc.url =  adsTpo[index].link ?? ""
            vc.isAds = true
            self.goToRoot(vc.navigationController())
        }
        
        print("ads")
    }
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControlle.currentPage = pagerView.currentIndex
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControlle.currentPage = targetIndex
    }
}
