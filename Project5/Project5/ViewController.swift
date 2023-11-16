

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
        
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let progress = UIBarButtonItem(customView: progressView)
        let favorites = UIBarButtonItem(title: "Favorites", style: .plain, target: self, action: #selector(openTapped))
        
        
        
        
        
        
        
        navigationItem.leftBarButtonItem = progress
        navigationItem.rightBarButtonItem = refresh
        
        toolbarItems = [spacer, favorites]
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        //toolbarItems = [ spacer, refresh]
        webView.allowsBackForwardNavigationGestures = true
        navigationController?.isToolbarHidden = false
        
        
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

