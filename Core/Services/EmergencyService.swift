import Foundation

public class EmergencyService {
    static let shared = EmergencyService()

    public func handleEmergency(_ trigger: EmergencyTrigger) async throws -> [EvacuationRoute] {
        let building = try await Building.load(from: trigger.buildingID)
        let routes = try await PathfindingManager.shared.generateEvacuationRoutes(
            for: building,
            dangerZone: trigger.origin
        )
        try await SWIN_WebSocket.shared.broadcast(routes)
        return routes
    }
}
