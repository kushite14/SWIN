//
//  Tests_PathfindingTests.swift
//  SWIN
//
//  Created by Khalid Mukhtar on 17/03/2025.
//
#if canImport(XCTest)
import XCTest
#else
// Fallback for Linux
#endif

final class PathfindingTests: XCTestCase {
    func testEvacuationPath() async throws {
        let testBuilding = Building.mockHospital()
        let path = try await PathfindingManager.shared.findShortestPath(
            from: GridPoint(x: 10, y: 20),
            to: GridPoint(x: 50, y: 60),
            in: testBuilding.id
        )
        XCTAssertGreaterThan(path.nodes.count, 0)
    }
}  
