//
//  ServerStubsTest.swift
//  CheckinAppChallengeTests
//
//  Created by Renan Trapp on 09/12/18.
//  Copyright © 2018 Renan Trapp. All rights reserved.
//

import XCTest

@testable import CheckinAppChallenge

import Mockingjay

class ServerStubsTest: XCTestCase {
    var events: [Event]?
    
    override func setUp() {
        guard let path    = Bundle.main.path(forResource: "data", ofType: "json") else {
            print("Error")
            return
        }
    
        let data = NSData(contentsOfFile: path)!
        stub(uri("/api/event/valid"), jsonData(data as Data))
    }

    func setEvents(events: [Event]? = []) {
        self.events = events
    }
    
    func testUrl() {
        let promise = expectation(description: "Request With valid data")
        let event = EventsController()
        event.getListOfEvents(url: "/api/event/valid") { (success, result, error) in
            if success {
                self.setEvents(events: result)
                XCTAssert(true, "Data is valid")
                XCTAssertNotNil(self.events)
            } else {
                XCTAssert(false, "Return fail, becouse, in this case, the json is valid")
            }
            promise.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testInvalidJson() {
        let promise = expectation(description: "Request without data")
        let event = EventsController()
        event.getListOfEvents(url: "/api/event/eventsErorr") { (success, result, error) in
            if success {
                self.setEvents(events: self.events)
                
                XCTAssert(false, "Data is valid")
            } else {
                XCTAssertNil(self.events)
                XCTAssert(true, "Return fail, becouse, in this case, the json is valid")
            }
            
            promise.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testCheckin() {
        let name = "Teste"
        let email = "email@email.com"
        let controller = CheckinControlller()
        let promise = expectation(description: "Request without data")
        controller.checkinToEvent(url: "\(serverLink)/checkin", eventId: "1", name: name, email: email) { (success, error) in
            XCTAssert(success)
            promise.fulfill()

        }
        waitForExpectations(timeout: 5, handler: nil)

    }
    
    func testContant() {
        XCTAssertNotNil(serverLink)
    }
    
    func testPerformanceExample() {
        self.measure {
        }
    }

}
