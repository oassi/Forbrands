//
//  webViewAdsVC.swift
//  Forbrands
//
//  Created by osamaaassi on 23/12/2021.
//

import UIKit
import WebKit
class webViewAdsVC: SuperViewController,WKNavigationDelegate, WKUIDelegate {

    @IBOutlet weak var webView:WKWebView!
    var url : String? = nil
    var isAds:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        webView.load(URLRequest(url: URL(string: url ?? "")! ))
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        
        // Do any additional setup after loading the view.
    }

    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
        navigationController?.navigationBar.tintColor = getColorApp()
    }
    
    override func backButtonAction(_sender: UIBarButtonItem) {
        if isAds{
            if CurrentUser.userInfo == nil {
                register(LoginVC.loadFromNib().navigationController())
            }else{
                if(CurrentUser.userInfo!.roleName == "Trader"
                    && CurrentUser.userInfo!.store == nil
                    && CurrentUser.userTrader == nil){
                    UserDefaults.standard.set(true, forKey: "isNotCompleteData")
                    register(StoreInformationVC.loadFromNib().navigationController())
                }else{
                    register(TTabBarController())
                }
            }
        }else{
            navigationController?.popViewController(animated: true)
        }
      
    }
    
    func register<T>(_ a: T) {
        let vc = a
        (vc as! UIViewController).modalPresentationStyle = .fullScreen
        self.goToRoot(vc as! UIViewController)
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url?.absoluteString else {
            return
        }

        //if url.isCon
        print("url = \(url)")

        // Process the URL.
        guard let components = NSURLComponents(url: webView.url!, resolvingAgainstBaseURL: true),
              let albumPath = components.path,
              let params = components.queryItems else {
            print("Invalid URL or album path missing")
            return
        }

        print(albumPath)
        print(params)


        self.navigationController?.popViewController(animated: true)
        var parameters: [String: String] = [:]

        _=params.map{
            parameters[$0.name] = $0.value
        }

        if parameters["status"] == "error" {
           // self.showMessage(message: parameters["msg"] ?? "")
        }else if parameters["status"] == "failed"{
           // self.showMessage(message: "Payment failed".localized)
        }else{
//            self.showMessage(message: parameters["success"] ?? "")
//            self.navigationController?.popViewController()
//            self.viewModel?.fetchOrder()
        }

    }


}
