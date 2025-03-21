//
//  Connector.swift
//  SWIN
//
//  Created by Khalid Mukhtar on 18/03/2025.
//

import Foundation

public struct Connector: Identifiable, Codable, Hashable {
    public let id: UUID
    public var type: AnnotationType
    public var x: Double
    public var y: Double
    public var connectedFloors: [UUID]
    
    public init(type: AnnotationType, x: Double, y: Double, connectedFloors: [UUID] = []) {
        self.id = UUID()
        self.type = type
        self.x = x
        self.y = y
        self.connectedFloors = connectedFloors
    }
}
