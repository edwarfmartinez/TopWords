//
//  TopWordsTests.swift
//  TopWordsTests
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 29/08/22.
//

import XCTest
@testable import TopWords

class TopWordsTests: XCTestCase {

    var dataAccessController = DataAccessController(failsOnly: false, basicLevel: true, intermediateLevel: true, advancedLevel: true)
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test1_CountWords() {
        
        dataAccessController.LoadWords()
        XCTAssertEqual(dataAccessController.words.count, K.Tests.totalWords)
        
        dataAccessController = DataAccessController(failsOnly: false, basicLevel: true, intermediateLevel: false, advancedLevel: false)
        dataAccessController.LoadWords()
        XCTAssertEqual(dataAccessController.words.count, K.Tests.totalBasicWords)
        
        dataAccessController = DataAccessController(failsOnly: false, basicLevel: false, intermediateLevel: true, advancedLevel: false)
        dataAccessController.LoadWords()
        XCTAssertEqual(dataAccessController.words.count, K.Tests.totalIntermediateWords)
        
        dataAccessController = DataAccessController(failsOnly: false, basicLevel: false, intermediateLevel: false, advancedLevel: true)
        dataAccessController.LoadWords()
        XCTAssertEqual(dataAccessController.words.count, K.Tests.totalAdvancedWords)
    }
    
    func test2_UpdateScore() {
        
        var numHits = dataAccessController.score.reduce(0) { $0 + ($1.hits) }
        dataAccessController.UpdateScore(hit: true)
        XCTAssertEqual(dataAccessController.score.reduce(0) { $0 + Int(($1.hits)) }, Int(numHits) + 1)
        
        var numFails = dataAccessController.score.reduce(0) { $0 + ($1.fails) }
        dataAccessController.UpdateScore(hit: false)
        XCTAssertEqual(dataAccessController.score.reduce(0) { $0 + Int(($1.fails)) }, Int(numFails) + 1)
        
    }
    
    
    
    func test3_PerformanceLoadWords() throws {
        // This is an example of a performance test case.
        self.measure {
            dataAccessController.LoadWords()
            dataAccessController.LoadScore()
        }
    }

}
