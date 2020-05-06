//
//  TimeCalculatorTests.swift
//  DoughtTests
//
//  Created by Lee Watkins on 05/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

@testable import Dought
import XCTest

class TimeCalculatorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddingTimeToADate() throws {
        let startTime = Date()
        let endTime = TimeCalculator.add(5, to: startTime)
        XCTAssert(endTime == (startTime + (5 * 60)))
    }
    
    func testAddingArrayOfTimesToADate() throws {
        let startTime = Date()
        let endTime = TimeCalculator.add([5, 10, 15], to: startTime)
        XCTAssert(endTime == (startTime + (30 * 60)))
    }
    
    func testDurationFormatter() throws {
        let result = try TimeCalculator.formatted(duration: Minutes(75))
        let expected = "1h 15m"
        XCTAssertEqual(result, expected)
    }
    
    func testStartTimeFormatter() throws {
        let startTime = Date(timeIntervalSince1970: TimeInterval(1588669200))
        let endTime = TimeCalculator.add([5, 10, 15], to: startTime)
        
        let result = TimeCalculator.formatted(startTime: endTime)
        
        let expected = "Tue 10:30"
        XCTAssertEqual(result, expected)
    }
}
