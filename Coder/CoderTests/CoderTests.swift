//
//  CoderTests.swift
//  CoderTests
//
//  Created by Константин Степанов on 16.04.2023.
//

import XCTest
@testable import Coder

final class CoderTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testFetchData() {
        let sut = NetworkManager()
        let expactation = XCTestExpectation(description: "response")
        
        sut.fetchData { employees in
            XCTAssert(!employees.items.isEmpty, "incorrect execution of the fetchData method")
            expactation.fulfill()
        } errorComplition: { errorDescription in }
        
        wait(for: [expactation], timeout: 1)
    }
}

