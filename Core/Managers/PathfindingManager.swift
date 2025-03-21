// MARK: - Pathfinding Manager
import Foundation
import MapKit

// MARK: - Pathfinding Data Models
public struct PathNode: Codable, Identifiable {
    public var id: UUID  // Changed to UUID
    public var x: Double
    public var y: Double
}

public struct NavigationPath: Codable {
    public let steps: [Coordinate]
    public let hazardWarnings: [String]
    public init(steps: [Coordinate], hazardWarnings: [String]) {
        self.steps = steps
        self.hazardWarnings = hazardWarnings
    }
}

public struct PathEdge: Codable {
    public var from: UUID  // Changed to UUID
    public var to: UUID    // Changed to UUID
    public var weight: Double
}

public class PathfindingManager {
    public static let shared = PathfindingManager()
    private var nodes: [UUID: PathNode] = [:]
    private var edges: [UUID: [PathEdge]] = [:]

    public func calculateEmergencyPath() async throws -> EvacuationRoute {
        return EvacuationRoute(path: [], exitID: UUID())
    }

    public func loadGraph(from filePath: URL) {
        do {
            let data = try Data(contentsOf: filePath)
            let graph = try JSONDecoder().decode([PathNode].self, from: data)
            self.nodes = Dictionary(uniqueKeysWithValues: graph.map { ($0.id, $0) })
        } catch {
            print("❌ Error loading graph: \(error)")
        }
    }

    public func findShortestPath(from startID: UUID, to endID: UUID) -> PathfindingResponse? {
        guard nodes[startID] != nil, nodes[endID] != nil else { return nil }
        var distances = [UUID: Double]()  // Changed to UUID
        var previousNodes = [UUID: UUID?]() // Changed to UUID
        var priorityQueue = [(nodeID: UUID, cost: Double)]() // Changed to UUID

        for node in nodes.keys { distances[node] = .infinity }
        distances[startID] = 0
        priorityQueue.append((startID, 0))

        while !priorityQueue.isEmpty {
            priorityQueue.sort { $0.cost < $1.cost }
            let (currentID, currentCost) = priorityQueue.removeFirst()
            if currentID == endID { break }

            for edge in edges[currentID] ?? [] {
                let newCost = currentCost + edge.weight
                if newCost < distances[edge.to] ?? .infinity {
                    distances[edge.to] = newCost
                    previousNodes[edge.to] = currentID
                    priorityQueue.append((edge.to, newCost))
                }
            }
        }

        var nodeIDs = [UUID]() // Changed to UUID
        var currentNode: UUID? = endID
        while let id = currentNode {
            nodeIDs.append(id)
            currentNode = previousNodes[id] ?? nil
        }

        let reversedIDs = nodeIDs.reversed()

        let pathSteps: [PathfindingResponse.PathStep] = reversedIDs.compactMap { id in
            guard let node = nodes[id] else { return nil }
            return PathfindingResponse.PathStep(
                coordinate: CLLocationCoordinate2D(latitude: node.y, longitude: node.x),
                cost: 1
            )
        }

        guard let totalCost = distances[endID], totalCost < .infinity else { return nil }
        return PathfindingResponse(path: pathSteps, totalCost: Int(totalCost))
    }
}

extension PathfindingManager {
    public func generateEvacuationRoutes(for building: Building, dangerZone: GridPoint) async throws -> [EvacuationRoute] {
        return [EvacuationRoute(path: [], exitID: UUID())]
    }
}

