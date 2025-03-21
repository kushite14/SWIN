//
//  Zone.swift
//  SWIN
//
//  Created by Khalid Mukhtar on 18/03/2025.
//
import Foundation

public struct Zone: Identifiable, Codable, Hashable {
    public let id: UUID
    public var name: String
    public var type: AnnotationType
    public var x: Double
    public var y: Double
    
    public init(name: String, type: AnnotationType, x: Double, y: Double) {
        self.id = UUID()
        self.name = name
        self.type = type
        self.x = x
        self.y = y
    }
}
  
