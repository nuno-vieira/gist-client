//  Copyright © 2022 nuno-vieira. All rights reserved.

import UIKit
import WebKit

class GistDetailViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var loadingView: LoadingView = LoadingView(frame: .zero)
    
    let viewModel: GistDetailViewModel
    
    init(viewModel: GistDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        webView.backgroundColor = AppTheme.Color.contentBackgroundColor
        webView.isOpaque = false
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title

        view.addSubview(loadingView)

        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        let request = URLRequest(url: viewModel.gistHtmlUrl)
        webView.load(request)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Remove the headers from the web page.
        webView.evaluateJavaScript("""
            document.querySelector('.js-header-wrapper').remove();
            document.querySelector('.gist-detail-intro').remove();
        """, completionHandler: { _, _ in
            // The delay is to make sure the js has finished evaluate.
            // This is to avoid a minor UI flicker.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.loadingView.isHidden = true
            }
        })
    }

}
