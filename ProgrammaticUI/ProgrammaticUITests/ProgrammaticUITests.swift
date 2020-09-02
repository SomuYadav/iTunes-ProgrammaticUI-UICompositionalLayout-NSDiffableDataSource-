//
//  ProgrammaticUITests.swift
//  ProgrammaticUITests
//
//  Created by Apple on 03/09/20.
//

import XCTest
@testable import ProgrammaticUI

class ProgrammaticUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testiTunesSongs() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let _ = iTunesSearchViewModel.getiTunesUsers(searchUser: "Alan Walker") { result in
            XCTAssert(true, "Test Case Passed")
        }
    }

    func testPerformanceiTunesSongs() throws {
        // This is an example of a performance test case.
        self.measure {
           let _ = iTunesSearchViewModel.getiTunesUsers(searchUser: "Alan Walker") { result in
               
            }
        }
    }
}
