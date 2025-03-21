//
//  BuildingData.swift
//  SWIN
//
//  Created by Khalid Mukhtar on 03/03/2025.
//
import Foundation

public struct Building: Identifiable, Codable, Hashable {
    public let id: UUID
    public var name: String
    public var floors: [Floor]
    public var thumbnailName: String
    public var facilityResources: FacilityResources

    public init(id: UUID = UUID(), name: String, floors: [Floor], thumbnailName: String, facilityResources: FacilityResources) {
        self.id = id
        self.name = name
        self.floors = floors
        self.thumbnailName = thumbnailName
        self.facilityResources = facilityResources
    }

    public static func load(from id: UUID) async throws -> Building {
        // Implement data loading logic
        return Building(name: "Default", floors: [], thumbnailName: "", facilityResources: FacilityResources(
            groundFloorImage: "", firstFloorImage: "", gridFile: "", wifiHeatmap: nil))
    }
}

public struct FacilityResources: Codable, Hashable {
    public let groundFloorImage: String
    public let firstFloorImage: String
    public let gridFile: String
    public let wifiHeatmap: String?
}  
