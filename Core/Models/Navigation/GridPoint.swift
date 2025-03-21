import Foundation

public struct Coordinate: Codable, Hashable {
    public let x: Double
    public let y: Double
}

public struct GridPoint: Identifiable, Codable, Hashable {
    public let id: UUID
    public let x: Double
    public let y: Double
    
    public init(id: UUID = UUID(), x: Double, y: Double) {
        self.id = id
        self.x = x
        self.y = y
    }
}

public struct BJCGrid: Codable, Hashable {
    public let scaleFactor: Double
    public let referencePoints: [GridPoint]
}

public struct AffineTransform {
    public var a, b, c: Double
    public var d, e, f: Double
}  
