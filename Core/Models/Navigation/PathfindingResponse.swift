//
//  PathfindingResponse.swift
//  SWIN
//
//  Created by Khalid Mukhtar on 21/03/2025.
//
// MARK: - Pathfinding Response Model
import Foundation
import CoreLocation

public struct PathfindingResponse: Codable {
    public let path: [PathStep]
    public let totalCost: Int

    public struct PathStep: Codable {
        public let coordinate: CLLocationCoordinate2D
        public let cost: Int

        enum CodingKeys: String, CodingKey {
            case latitude, longitude, cost
        }

        public init(coordinate: CLLocationCoordinate2D, cost: Int) {
            self.coordinate = coordinate
            self.cost = cost
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let latitude = try container.decode(Double.self, forKey: .latitude)
            let longitude = try container.decode(Double.self, forKey: .longitude)
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            self.cost = try container.decode(Int.self, forKey: .cost)
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(coordinate.latitude, forKey: .latitude)
            try container.encode(coordinate.longitude, forKey: .longitude)
            try container.encode(cost, forKey: .cost)
        }
    }
}

