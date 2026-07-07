import XCTest

final class ComicboxUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testAddFlow() {
        app.buttons["addButton"].tap()
        let nameField = app.textFields["nameField"]
        XCTAssertTrue(nameField.waitForExistence(timeout: 2))
        nameField.tap()
        nameField.typeText("UI Test Issue")
        app.buttons["saveButton"].tap()
        XCTAssertTrue(app.staticTexts["UI Test Issue"].waitForExistence(timeout: 2))
    }

    func testFreeLimitShowsPaywall() {
        for i in 0..<25 {
            app.buttons["addButton"].tap()
            let nameField = app.textFields["nameField"]
            if nameField.waitForExistence(timeout: 1) {
                nameField.tap()
                nameField.typeText("Item \(i)")
                app.buttons["saveButton"].tap()
            } else {
                break
            }
        }
        app.buttons["addButton"].tap()
        XCTAssertTrue(app.buttons["subscribeButton"].waitForExistence(timeout: 2) || app.buttons["paywallCloseButton"].waitForExistence(timeout: 2))
    }

    func testKeyboardDismissOnTapOutside() {
        app.buttons["addButton"].tap()
        let nameField = app.textFields["nameField"]
        XCTAssertTrue(nameField.waitForExistence(timeout: 2))
        nameField.tap()
        nameField.typeText("Dismiss Test")
        XCTAssertTrue(app.keyboards.element.exists)
        app.staticTexts["Add Issue"].tap()
        XCTAssertFalse(app.keyboards.element.exists)
    }

    func testCancelClosesSheet() {
        app.buttons["addButton"].tap()
        XCTAssertTrue(app.buttons["cancelButton"].waitForExistence(timeout: 2))
        app.buttons["cancelButton"].tap()
        XCTAssertTrue(app.buttons["addButton"].waitForExistence(timeout: 2))
    }
}
