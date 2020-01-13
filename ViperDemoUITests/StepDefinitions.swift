//
//  StepDefinitions.swift
//  ViperDemoUITests
//
//  Created by Hongli Yu on 13.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import Foundation
import XCTest_Gherkin

final class TestSteps: StepDefiner {

    let application = XCUIApplication()

    override func defineSteps() {
        self.defineGeneralSteps()
        self.defineScrollSteps()
    }

    private func defineGeneralSteps() {
        step("I launched the app") {
            self.launchApp()
        }
        step("I wait ([1-9]*) seconds") { (time: Int) in
            sleep(UInt32(time))
        }
        step("I should see (.*)") { (identifier: String) in
            XCTAssertNotNil(self.waitForElement(with: identifier), "Identifier \(identifier) not found")
        }

        step("I should not see (.*)") { (identifier: String) in
            XCTAssertTrue(self.waitForElementToDisappear(with: identifier), "Identifier \(identifier) did not disappear.")
        }

        step("I touch ([a-zA-Z0-9]*)") { (identifier: String) in
            self.touch(identifier)
        }

        step("I swipe left ([a-zA-Z0-9]*)") { (identifier: String) in
            guard let element = self.waitForElement(with: identifier) else {
                XCTFail("Identifier \(identifier) not found")
                return
            }
            element.firstMatch.swipeLeft()
        }

        step("I swipe right ([a-zA-Z0-9]*)") { (identifier: String) in
            guard let element = self.waitForElement(with: identifier) else {
                XCTFail("Identifier \(identifier) not found")
                return
            }
            element.firstMatch.swipeRight()
        }

        step("I swipe up ([a-zA-Z0-9]*)") { (identifier: String) in
            guard let element = self.waitForElement(with: identifier) else {
                XCTFail("Identifier \(identifier) not found")
                return
            }
            element.firstMatch.swipeUp()
        }

        step("([a-zA-Z0-9]*) should have value ([a-zA-Z0-9]*)") { (identifier: String, value: String) in
            let element = self.waitForElement(with: identifier)
            if let elementValue = element?.value as? String {
                XCTAssert(elementValue == value)
            } else {
                XCTFail("Identifier \(identifier) or value \(value) not found")
            }
        }

    }

    private func launchApp() {
        self.application.launch()
    }

    private func touch(_ identifier: String) {
        guard let element = self.waitForElement(with: identifier) else {
            XCTFail("Identifier \(identifier) not found")
            return
        }
        element.firstMatch.tap()
    }

    // MARK: Scrolling
    private func defineScrollSteps() {
        step("I scroll ([a-zA-Z0-9]*) to bottom") { (identifier: String) in
            self.dragScrollViewToBottom(identifier)
        }

        step("I scroll pickerview to (.*)") {(match: String) in
            XCUIApplication().pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: match)
        }
    }

    private func dragScrollViewToBottom(_ identifier: String) {
        guard let element = self.waitForElement(with: identifier) else {
            XCTFail("Identifier \(identifier) not found")
            return
        }
        let scrollView = element.firstMatch
        let start = scrollView.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finish = scrollView.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: -0.5))
        start.press(forDuration: 0.1, thenDragTo: finish)
    }

    private func wait(for identifier: String) {
        XCTAssertNotNil(self.waitForElement(with: identifier))
    }

    private func waitForElement(with identifier: String) -> XCUIElement? {
        for _ in 0..<5 {
            if let element = self.checkForElement(with: identifier) {
                return element
            }
            sleep(1)
        }
        return nil
    }

    private func waitForElementToDisappear(with identifier: String) -> Bool {
        for _ in 0..<5 {
            if self.checkForElement(with: identifier) == nil {
                return true
            }
            sleep(1)
        }
        return false
    }

    private func checkForElement(with identifier: String) -> XCUIElement? {
        if application.buttons[identifier].exists {
            return application.buttons[identifier]
        } else if application.otherElements[identifier].exists {
            return application.otherElements[identifier]
        } else if application.cells[identifier].exists {
            return application.cells[identifier]
        } else if application.textFields[identifier].exists {
            return application.textFields[identifier]
        } else if application.secureTextFields[identifier].exists {
            return application.secureTextFields[identifier]
        } else if application.keyboards.keys[identifier].exists {
            return application.keyboards.keys[identifier]
        } else if application.images[identifier].exists {
            return application.images[identifier]
        } else if application.staticTexts[identifier].exists {
            return application.staticTexts[identifier]
        } else if application.scrollViews[identifier].exists {
            return application.scrollViews[identifier]
        } else if application.tables[identifier].exists {
            return application.tables[identifier]
        } else if application.webViews[identifier].exists {
            return application.webViews[identifier]
        } else {
            return nil
        }
    }

}
