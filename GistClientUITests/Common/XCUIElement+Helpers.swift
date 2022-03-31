// Copyright © 2022 nuno-vieira. All rights reserved.

import XCTest

extension XCUIElement {
    func isDisplayed(timeout: TimeInterval = 1, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssert(waitForExistence(timeout: timeout), file: file, line: line)
    }
}
