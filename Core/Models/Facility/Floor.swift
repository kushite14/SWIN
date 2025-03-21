//  Floor.swift
//  SWIN
//
//  Created by Khalid Mukhtar on 18/03/2025.

import Foundation

public struct Floor: Identifiable, Codable, Hashable {
    public let id: UUID
    public var level: Int
    public var name: String
    public var zones: [Zone]
    public var connectors: [Connector]
    public var annotations: [MapAnnotationModel] // ✅ Updated to renamed struct

    public init(level: Int, name: String, zones: [Zone] = [], connectors: [Connector] = [], annotations: [MapAnnotationModel] = []) {
        self.id = UUID()
        self.level = level
        self.name = name
        self.zones = zones
        self.connectors = connectors
        self.annotations = annotations
    }
}

public struct MapAnnotationModel: Identifiable, Codable, Hashable {
    public let id: UUID
    public var type: AnnotationType
    public var x: Double
    public var y: Double
    public var timestamp: Date

    public init(type: AnnotationType, x: Double, y: Double) {
        self.id = UUID()
        self.type = type
        self.x = x
        self.y = y
        self.timestamp = Date()
    }
}

public struct BuildingUnit: Codable, Hashable {
    let Unit_Ref: String
    let Floor_Name: String
    let Unit_Name: String
    let Top_Left: String
    let Bot_Right: String
    let Icon_Path: String
    let Top_Left_Pixel: [Int]
    let Bot_Right_Pixel: [Int]
}

public extension Floor {
    static func loadUnits(from filename: String) -> [BuildingUnit] {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let units = try? JSONDecoder().decode([BuildingUnit].self, from: data) else {
            return []
        }
        return units
    }
}
