//  Copyright © 2022 nuno-vieira. All rights reserved.

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
        webView.backgroundColor = AppTheme.Color.contentBackgroundColor
        webView.isOpaque = false
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = gist.files.first?.name

        view.addSubview(loadingView)

        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        let request = URLRequest(url: gist.htmlUrl)
        webView.load(request)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("""
            document.querySelector('.js-header-wrapper').remove();
            document.querySelector('.gist-detail-intro').remove();
        """, completionHandler: { _, _ in
            // The delay is to make sure the js has finished evaluate.
            // This is to avoid a minor UI flicker.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.loadingView.isHidden = true
            }
        })
    }

}
