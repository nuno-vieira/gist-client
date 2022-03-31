// Copyright © 2022 nuno-vieira. All rights reserved.

import Foundation
import XCTest

extension XCTest {

    func Given(_ text: String, block: () -> Void ) {
        runActivity(callingFunction: resolveGherkinTag(from: #function), text: text, block: block)
    }

    func When(_ text: String, block: () -> Void ) {
        runActivity(callingFunction: resolveGherkinTag(from: #function), text: text, block: block)
    }

    func Then(_ text: String, block: () -> Void ) {
        runActivity(callingFunction: resolveGherkinTag(from: #function), text: text, block: block)
    }

    func And(_ text: String, block: () -> Void ) {
        runActivity(callingFunction: resolveGherkinTag(from: #function), text: text, block: block)
    }

    func runActivity(callingFunction: String, text: String, block: () -> Void) {
        let group = DispatchGroup()
        group.enter()
        XCTContext.runActivity(named: callingFunction + " " + text) { activity in
            block()
            let screenshot = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
            screenshot.lifetime = .deleteOnSuccess
            activity.add(screenshot)
            group.leave()
        }
        group.wait()
    }

    private func resolveGherkinTag(from functionText: String) -> String {
        let blockFunctionParameterString = "(_:block:)"
        return functionText.replacingOccurrences(of: blockFunctionParameterString, with: "")
    }
}
