//
//  TopWordsUITests.swift
//  TopWordsUITests
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 29/08/22.
//

import XCTest
@testable import TopWords

class TopWordsUITests: XCTestCase {
    
   
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test1_UITest() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        let element = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1)
        
        element.children(matching: .other).element(boundBy: 0).children(matching: .button).element.tap()
        app.buttons["cardTopWordsBack"].tap()
        app.buttons["like"].tap()
        app.buttons["cardTopWordsBack"].tap()
        app.buttons["dislike"].tap()
        let backButton = app.navigationBars["Play Cards"].buttons["Back"]
        backButton.tap()
        
        element.children(matching: .other).element(boundBy: 1).children(matching: .button).element.tap()
        let trueStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["True"]/*[[".buttons[\"True\"].staticTexts[\"True\"]",".staticTexts[\"True\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        trueStaticText.tap()
        app.buttons["False"].tap()
        trueStaticText.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["False"]/*[[".buttons[\"False\"].staticTexts[\"False\"]",".staticTexts[\"False\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Play Compare"].buttons["Back"].tap()
        
        element.children(matching: .other).element(boundBy: 2).children(matching: .button).element.tap()
        XCUIApplication().staticTexts["Top Hits"].tap()
        XCUIApplication()/*@START_MENU_TOKEN@*/.staticTexts["Top Fails"]/*[[".buttons[\"Top Fails\"].staticTexts[\"Top Fails\"]",".staticTexts[\"Top Fails\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Score"].buttons["Back"].tap()
        
        element.children(matching: .other).element(boundBy: 3).children(matching: .button).element.tap()
        XCUIApplication().staticTexts["Train advanced words"].tap()
                                                                                                                                
        app.navigationBars["TopWords.ConfigurationView"].buttons["Back"].tap()
    }

    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
