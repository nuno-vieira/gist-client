//
//  GistDetailViewController.swift
//  GistClient
//
//  Created by Vieira, Nuno (Developer) on 14/11/2018.
//  Copyright © 2018 nuno-vieira. All rights reserved.
//

import UIKit
import WebKit

class GistDetailViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var loadingView: LoadingView = LoadingView(frame: .zero)
    
    let gist: Gist
    
    init(gist: Gist) {
        self.gist = gist
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        webView.backgroundColor = UIColor.Theme.contentBackgroundColor
        webView.isOpaque = false
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = gist.filename

        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
        }

        guard let url = URL(string: gist.url) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.querySelector('header').remove()", completionHandler: nil)
        DispatchQueue.main.async {
            self.loadingView.isHidden = true
        }
    }

}
