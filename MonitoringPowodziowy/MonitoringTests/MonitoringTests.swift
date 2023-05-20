//
//  MonitoringTests.swift
//  MonitoringTests
//
//  Created by Lukasz on 20/05/2023.
//

import XCTest
@testable import MonitoringPowodziowy

final class MonitoringTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let mainViewModel = MainViewModel()
        let stations = mainViewModel.getStations()
        
        XCTAssertTrue(stations.count > 0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetStations() throws {
        let mainViewModel = MainViewModel()
    }

}
