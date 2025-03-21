import Foundation
import Combine

final class RealTimeDataFetcher: ObservableObject {
    @Published var userPosition: (x: Double, y: Double)?
    @Published var connectedUsers: Int = 0  // ✅ Keeps track of connected users

    func updatePosition(bssid: String) {
        SWIN_API.getPosition(bssids: [bssid]) { result in
            switch result {
            case .success(let position):
                DispatchQueue.main.async {
                    self.userPosition = (x: position.0, y: position.1)
                }
            case .failure(let error):
                print("Error fetching position:", error)
            }
        }
    }

    /// ✅ Restored `fetchConnectedUsers` function
    func fetchConnectedUsers() {
        SWIN_API.getConnectedUsers { result in
            switch result {
            case .success(let count):
                DispatchQueue.main.async {
                    self.connectedUsers = count
                }
            case .failure(let error):
                print("Error fetching connected users:", error)
            }
        }
    }

    /// ✅ Fetch real-time user position (Fixes type mismatch)
    static func fetchUserPosition(bssids: [String]) async -> (Double, Double, String) {
        return await withCheckedContinuation { continuation in
            SWIN_API.getPosition(bssids: bssids) { result in
                switch result {
                case .success(let position):
                    continuation.resume(returning: (position.0, position.1, "Unknown"))
                case .failure(let error):
                    print("Error fetching position:", error)
                    continuation.resume(returning: (0.0, 0.0, "Unknown"))
                }
            }
        }
    }
}
