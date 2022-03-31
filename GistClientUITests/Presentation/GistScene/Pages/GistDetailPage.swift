// Copyright © 2022 nuno-vieira. All rights reserved.

import XCTest

final class GistDetailPage: Page {
    private var app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    func webViewLoaded() {
        app.webViews.element.isDisplayed()
    }
}
