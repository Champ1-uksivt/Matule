//
//  MatuleUITests.swift
//  MatuleUITests
//
//  Created by Михайлов Евгений on 18.02.2025.
//  UI тесты

import XCTest

final class MatuleUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    @MainActor
    func testIncorrectEmail() throws {
        // запускать с включенной англ раскладкой!!!
        let app = XCUIApplication()
        app.launch()
        
        let email = app.textFields["email"]
        let password = app.secureTextFields["password"]
        let btn = app.buttons["btn"]
        
        email.tap()
        email.typeText("qwe")
        password.tap()
        password.typeText("qweQWE123")
        app.keyboards.buttons["return"].tap()
        btn.tap()
        
        XCTAssertTrue(app.alerts.firstMatch.exists)
        
    }
    
    @MainActor
    func testIncorrectPassword() throws {
        // запускать с включенной англ раскладкой!!!
        let app = XCUIApplication()
        app.launch()
        
        let email = app.textFields["email"]
        let password = app.secureTextFields["password"]
        let btn = app.buttons["btn"]
        
        email.tap()
        email.typeText("e.mikhaylov2006@gmail.com")
        password.tap()
        password.typeText("qwe13")
        app.keyboards.buttons["return"].tap()
        btn.tap()
        
        XCTAssertTrue(app.alerts.firstMatch.exists)
        
    }
    
    @MainActor
    func testCorrectAuth() throws {
        // запускать с включенной англ раскладкой!!!
        let app = XCUIApplication()
        app.launch()
        
        let email = app.textFields["email"]
        let password = app.secureTextFields["password"]
        let btn = app.buttons["btn"]
        
        email.tap()
        email.typeText("e.mikhaylov2006@gmail.com")
        password.tap()
        password.typeText("qweQWE123")
        app.keyboards.buttons["return"].tap()
        btn.tap()
        
        XCTAssertTrue(app.staticTexts["home"].waitForExistence(timeout: 10))
        
    }
    
    @MainActor
    func testIncorrectAuth() throws {
        // запускать с включенной англ раскладкой!!!
        let app = XCUIApplication()
        app.launch()
        
        let email = app.textFields["email"]
        let password = app.secureTextFields["password"]
        let btn = app.buttons["btn"]
        
        email.tap()
        email.typeText("e.mikhaylov2006@gmail.com")
        password.tap()
        password.typeText("qwe")
        app.keyboards.buttons["return"].tap()
        btn.tap()
        
        XCTAssertTrue(app.alerts.firstMatch.exists)
        
    }
    
}
