import Foundation

public protocol EmergencyTriggerProtocol: Codable {
    var buildingID: UUID { get }
    var emergencyType: String { get }
    var origin: GridPoint { get } // ✅ Ensure origin is in protocol
}

public struct EmergencyTrigger: EmergencyTriggerProtocol {
    public let buildingID: UUID
    public let emergencyType: String
    public let origin: GridPoint // ✅ Included as required
}

public struct EvacuationRoute: Codable {
    public let path: [GridPoint]
    public let exitID: UUID
}

public class EmergencySystem {
    private let webSocketManager: WebSocketServer
    private let pathfinder: PathfindingManager

    public init(webSocketManager: WebSocketServer, pathfinder: PathfindingManager) {
        self.webSocketManager = webSocketManager
        self.pathfinder = pathfinder
    }

    public func triggerFireProtocol(using trigger: EmergencyTrigger) async throws {
        // 🔄 Fully implemented integration
        let building = try await Building.load(from: trigger.buildingID)
        let evacRoutes = try await pathfinder.generateEvacuationRoutes(for: building, dangerZone: trigger.origin)
        let data = try JSONEncoder().encode(evacRoutes)
        webSocketManager.broadcast(data: data)
    }
}
