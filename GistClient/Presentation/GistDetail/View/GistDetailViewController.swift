//  Copyright © 2022 nuno-vieira. All rights reserved.

import UIKit

class GistDetailViewController: UIViewController {
    let viewModel: GistDetailViewModel
    init(viewModel: GistDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var gistDetailView = GistDetailView()
    
    override func loadView() {
        view = gistDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.title

        viewModel.viewDidLoad()
        viewModel.state.observe(self) { [weak self] state in
            switch state {
            case .loadGistHtml(let request):
                self?.gistDetailView.showLoading()
                self?.gistDetailView.loadHtml(request)
            case .gistHtmlLoaded:
                self?.gistDetailView.showWebView()
            case .gistHtmlFailed:
                self?.gistDetailView.showError()
            case .none:
                break
            }
        }

        gistDetailView.onErrorRetry = { [weak self] in
            guard let self = self else { return }
            self.viewModel.retry()
        }
        gistDetailView.onHtmlError = { [weak self] _ in
            self?.viewModel.htmlDidFail()
        }
        gistDetailView.onHtmlLoad = { [weak self] in
            self?.viewModel.htmlDidLoad()
        }

    }

    deinit {
        viewModel.state.remove(observer: self)
    }

}
