// Copyright © 2022 nuno-vieira. All rights reserved.

import Foundation

enum GistListViewState: Equatable {
    case loading
    case populated([GistListItemViewModel])
    case error(message: String)
}

protocol GistListViewModel: AnyObject {
    // Outputs
    var title: String { get }
    var state: Observable<GistListViewState> { get }
    var route: Observable<GistListRoute?> { get }

    // Inputs
    func viewDidLoad()
    func selectGist(at index: Int)
    func retry()
}

final class DefaultGistListViewModel: GistListViewModel {
    private var gists: [Gist] = []

    let getGistsUseCase: GetGistsUseCase
    init(getGistsUseCase: GetGistsUseCase) {
        self.getGistsUseCase = getGistsUseCase
    }

    // Outputs
    var title: String = "Gists"
    var state: Observable<GistListViewState> = .init(.loading)
    var route: Observable<GistListRoute?> = .init(nil)

    // Inputs
    func viewDidLoad() {
        fetchGists()
    }

    func selectGist(at index: Int) {
        let gist = gists[index]
        route.value = .detail(gist: gist)
    }

    func retry() {
        fetchGists()
    }

    private func fetchGists() {
        state.value = .loading
        getGistsUseCase.execute { [weak self] (result) in
            switch result {
            case .success(let gists):
                self?.gists = gists
                let items = gists.map(GistListItemViewModel.init)
                self?.state.value = .populated(items)
            case .failure(let error):
                self?.state.value = .error(message: error.localizedDescription)
            }
        }
    }
}

