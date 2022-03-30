// Copyright © 2022 nuno-vieira. All rights reserved.

import Foundation

enum GistDetailState: Equatable {
    case loadGistHtml(request: URLRequest)
    case gistHtmlLoaded
    case gistHtmlFailed
}

protocol GistDetailViewModel {
    // Outputs
    var state: Observable<GistDetailState?> { get }
    var title: String { get }

    // Inputs
    func viewDidLoad()
    func retry()
    func htmlDidFail()
    func htmlDidLoad()
}

class DefaultGistDetailViewModel: GistDetailViewModel {
    let gist: Gist

    init(gist: Gist) {
        self.gist = gist
    }

    var title: String {
        gist.files.first?.name ?? ""
    }

    var state: Observable<GistDetailState?> = .init(nil)

    func viewDidLoad() {
        loadGistHtml()
    }

    func retry() {
        loadGistHtml()
    }

    func htmlDidFail() {
        state.value = .gistHtmlFailed
    }

    func htmlDidLoad() {
        state.value = .gistHtmlLoaded
    }

    private func loadGistHtml() {
        let urlRequest = URLRequest(url: gist.htmlUrl)
        state.value = .loadGistHtml(request: urlRequest)
    }
}
