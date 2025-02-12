//
//  Lab1_Nigar_AhmadovaUITestsLaunchTests.swift
//  Lab1_Nigar_AhmadovaUITests
//
//  Created by Nigar Ahmadova on 2025-02-12.
//

import XCTest

final class Lab1_Nigar_AhmadovaUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
