

import UIKit

import WebKit


class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var progressView: UIProgressView!
    
    override func loadView(){
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.hackingwithswift.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
    }
    
    func openPage(action: UIAlertAction){
        
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    @objc func openTapped(){
        let alertController = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
        alertController.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        alertController.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(alertController, animated: true)
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    

}

