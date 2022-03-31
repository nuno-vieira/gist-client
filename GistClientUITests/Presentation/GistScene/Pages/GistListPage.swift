// Copyright © 2022 nuno-vieira. All rights reserved.

import XCTest

final class GistListPage: Page {
    private let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    func open() {
        app.launch()
    }

    func tapGist(atRow row: Int) -> GistDetailPage {
        let gistCell = app.tables.cells.element(boundBy: row)
        gistCell.isDisplayed()
        gistCell.tap()
        return GistDetailPage(app: app)
    }
}
