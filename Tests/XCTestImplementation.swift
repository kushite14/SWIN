//
//  XCTest_Implementation.swift
//  SWIN
//
//  Created by Khalid Mukhtar on 17/03/2025.
//
import Foundation

#if canImport(XCTest)
import XCTest

class NetworkTests: XCTestCase {
    var server: WebSocketServer!
    let testPort: UInt16 = 8080
    
    override func setUp() {
        super.setUp()
        server = try! WebSocketServer(port: testPort)
        server.start()
    }
    
    func testMessageRoundtrip() {
        let expectation = self.expectation(description: "Message received")
        let testMessage = EmergencyAlert(
            timestamp: Date(),
            severity: 5,
            affectedZones: ["A1", "B2"]
        )
        
        #if canImport(Network)
        let client = NWConnection(
            to: .hostPort(host: "localhost", port: .init(integerLiteral: testPort)),
            using: .tcp
        )
        
        client.stateUpdateHandler = { state in
            if case .ready = state {
                let data = try! JSONEncoder().encode(testMessage)
                client.send(content: data, completion: .contentProcessed { _ in })
            }
        }
        
        client.start(queue: .global())
        #endif
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) { [weak self] in
            let receivedData = try! JSONEncoder().encode(testMessage)
            XCTAssertEqual(self?.server.lastReceivedData, receivedData)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2)
    }
}

#else // Linux Fallback
public class XCTestCase {
    public func expectation(description: String) -> Void { }
    public func waitForExpectations(timeout: TimeInterval) { }
    public func setUp() { } // Required for Linux
}
public func XCTAssertEqual(_: Any, _: Any) { }
#endif
