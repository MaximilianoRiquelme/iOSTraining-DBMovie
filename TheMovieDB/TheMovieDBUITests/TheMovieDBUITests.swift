//
//  TheMovieDBUITests.swift
//  TheMovieDBUITests
//
//  Created by Maximiliano Riquelme Vera on 02/12/2021.
//

import XCTest

class TheMovieDBUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTapFirstCellFromList() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        let firstCell = app.tables.cells.firstMatch
        let firstCellTitle = firstCell.title
        firstCell.tap()
        
        
        let detailViewTitleBar = app.navigationBars.firstMatch
        let detailViewTitle = detailViewTitleBar.title
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(firstCellTitle, detailViewTitle)
    }
    
    func testTapFirstCellFromGrid() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Use recording to get started writing UI tests.
        app/*@START_MENU_TOKEN@*/.buttons["Grid"]/*[[".segmentedControls.buttons[\"Grid\"]",".buttons[\"Grid\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let firstCell = app.collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element
        let firstCellImage = firstCell.images.firstMatch
        firstCell.tap()
        
        let detailViewImage = app.images.firstMatch
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //XCTAssertEqual(firstCellImage, detailViewImage)
    }
}
