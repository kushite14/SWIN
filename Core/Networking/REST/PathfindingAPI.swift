//
//  API_PathfindingAPI.swift
//  SWIN
//
//  Created by Khalid Mukhtar on 17/03/2025.
//
import Foundation

struct PathfindingRequest: Codable {
    let start: GridPoint
    let destination: GridPoint
    let buildingID: UUID  // Changed to UUID
}

class PathfindingAPI {
    static func handleRequest(_ data: Data) -> Data? {
        guard let request = try? JSONDecoder().decode(PathfindingRequest.self, from: data) else {
            return nil
        }
        
        let path = PathfindingManager.shared.findShortestPath(
            from: request.start.id,
            to: request.destination.id
        )
        
        return try? JSONEncoder().encode(PathfindingResponse(
            path: path?.path ?? [],  // Changed from pathSteps to path
            totalCost: path?.totalCost ?? 0
        ))
    }
}
