// Copyright © 2022 nuno-vieira. All rights reserved.

import UIKit
import WebKit

class GistDetailView: UIView {

    var onErrorRetry: (() -> Void)? {
        didSet {
            errorView.retryAction = onErrorRetry
        }
    }

    var onHtmlError: ((Error) -> Void)?

    var onHtmlLoad: (() -> Void)?

    lazy private var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.backgroundColor = AppTheme.Color.contentBackground
        webView.isOpaque = false
        return webView
    }()

    lazy private var loadingView: LoadingView = LoadingView()

    lazy private var errorView = ErrorView()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        [webView, loadingView, errorView].forEach {
            addSubview($0)
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: trailingAnchor),
                $0.topAnchor.constraint(equalTo: topAnchor),
                $0.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
    }

    func loadHtml(_ request: URLRequest) {
        webView.load(request)
    }

    func showWebView() {
        loadingView.isHidden = true
        errorView.isHidden = true
    }

    func showLoading() {
        loadingView.isHidden = false
        errorView.isHidden = true
    }

    func showError() {
        loadingView.isHidden = true
        errorView.isHidden = false
    }
}

extension GistDetailView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Remove the nav headers from the web page.
        webView.evaluateJavaScript("""
            document.querySelector('.js-header-wrapper').remove();
            document.querySelector('.gist-detail-intro').remove();
        """, completionHandler: { _, _ in
            // The delay is to make sure the js has finished evaluate.
            // This is to avoid a minor UI flicker.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.onHtmlLoad?()
            }
        })
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        onHtmlError?(error)
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        onHtmlError?(error)
    }
}
