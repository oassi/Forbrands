//
//  webViewVC.swift
//  Forbrands
//
//  Created by osamaaassi on 09/12/2021.
//

import UIKit
import WebKit
class webViewVC: SuperViewController,WKNavigationDelegate, WKUIDelegate {
    
    @IBOutlet weak var webView:WKWebView!
    var url : String? = nil
    var isPoint = false
    var parametersOrder : [String : String]?
    override func viewDidLoad() {
        super.viewDidLoad()
        navButtons()
        webView.load(URLRequest(url: URL(string: url ?? "")! ))
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.allowsBackForwardNavigationGestures = true
      
        // Do any additional setup after loading the view.
    }
    
    //    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    //
    //        if let url = navigationAction.request.url?.absoluteString
    //        {
    //            print(url)
    //            decisionHandler(.allow)
    //            return
    //        }
    //        decisionHandler(.cancel)
    //
    //
    //    }
    //
    
    private func navButtons(){
        let navgtion = self.navigationController as! CustomNavigationBar
        navgtion.setCustomBackButtonForViewController(sender: self)
    }
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        if(navigationAction.navigationType == .formSubmitted) {
            if navigationAction.request.url?.absoluteString != nil {
                //do what you need with url
                //self.delegate?.openURL(url: navigationAction.request.url!)
                print(url)
                guard let components = NSURLComponents(url: webView.url!, resolvingAgainstBaseURL: true),
                      let albumPath = components.path,
                      let params = components.queryItems else {
                    print("Invalid URL or album path missing")
                    return
                }
                
                print(albumPath)
                print(params)
                var parameters: [String: String] = [:]
                
                _=params.map{
                    parameters[$0.name] = $0.value
                }
                
                if parameters["status"] == "error" {
                   // self.showMessage(message: parameters["msg"] ?? "")
                }else if parameters["status"] == "redirect"{
                    self.showAlert(title: "error", message: "Payment failed".localized)
                }else{
        //            self.showMessage(message: parameters["success"] ?? "")
        //            self.navigationController?.popViewController()
        //            self.viewModel?.fetchOrder()
                   //navigationController?.popToRootViewController(animated: true)
                    if isPoint{
                       // UserDefaults.standard.set(true, forKey: "ordersComplete")
                        self.navigationController?.popToRootViewController(animated: true)
                    }else{
                        
                        let vc:CheckoutVC = CheckoutVC.loadFromNib()
                        vc.modalPresentationStyle = .fullScreen
                        self.navigationController?.present(vc, animated: true, completion: nil)
                    }
                }
            }
            decisionHandler(.cancel)
            return
        }
        decisionHandler(.allow)
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
