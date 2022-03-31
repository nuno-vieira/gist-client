// Copyright © 2022 nuno-vieira. All rights reserved.

import XCTest

class GistSceneUITests: XCTestCase {

    var gistListPage: GistListPage!
    var gistDetailPage: GistDetailPage!

    override func setUp() {
        continueAfterFailure = false
        gistListPage = GistListPage(app: XCUIApplication())
    }

    func testRatesScene() {
        Given("user opens list of gists") {
            gistListPage.open()
        }
        When("user selects a gist") {
            gistDetailPage = gistListPage.tapGist(atRow: 1)
        }
        Then("gist html is loaded") {
            gistDetailPage.webViewLoaded()
        }
    }

}
