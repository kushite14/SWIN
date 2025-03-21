//
//  StoredLocation.swift
//  SWIN
//
//  Created by Khalid Mukhtar on 18/03/2025.
//
import Foundation



public struct StoredLocation: Identifiable, Codable, Hashable {
    public let id: UUID
    public let buildingName: String
    public let unitName: String
    public let coordinates: GridPoint
    
    public init(buildingName: String, unitName: String, coordinates: GridPoint) {
        self.id = UUID()
        self.buildingName = buildingName
        self.unitName = unitName
        self.coordinates = coordinates
    }
}
