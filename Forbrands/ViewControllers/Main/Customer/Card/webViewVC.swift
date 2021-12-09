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
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        webView.load(URLRequest(url: URL(string: url ?? "")! ))
        // Do any additional setup after loading the view.
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
           print(webView.url)
        }
    
    func didFinsh
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        let url = webView.url
        print(url as Any) // this will print url address as option field
//        if url?.absoluteString.range(of: ".pdf") != nil {
//
//             print("PDF contain")
//        }
//        else {
//
//             print("No PDF Contain")
//        }
    }
}
