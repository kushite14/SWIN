import Foundation

import Foundation

public struct EmergencyAlert: Codable {
    public let timestamp: Date
    public let severity: Int
    public let affectedZones: [String]
}
