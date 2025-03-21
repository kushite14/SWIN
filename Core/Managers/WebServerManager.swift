#if canImport(Network)
import Foundation
import Network

public class WebSocketServer {
    public var lastReceivedData: Data?
    private let listener: NWListener
    private var connections = [NWConnection]()
    
    public init(port: UInt16) throws {
        let parameters = NWParameters.tcp
        parameters.allowLocalEndpointReuse = true
        listener = try NWListener(using: parameters, on: .init(rawValue: port)!)
    }
    
    public func start() {
        // Fixed state handler with proper parameter naming
        listener.stateUpdateHandler = { newState in
            print("Server state: \(newState)")
        }
        
        listener.newConnectionHandler = { [weak self] connection in
            self?.handleConnection(connection)
            connection.start(queue: .global())
        }
        
        listener.start(queue: .main)
    }
    
    private func handleConnection(_ connection: NWConnection) {
        connections.append(connection)
        
        connection.receiveMessage { [weak self] data, _, _, _ in
            guard let data = data else { return }
            self?.lastReceivedData = data // Track received data
            self?.broadcast(data: data)
            self?.handleConnection(connection)
        }
    }
    
    public func broadcast(data: Data) {
        connections.forEach { connection in
            connection.send(content: data, completion: .contentProcessed { [weak self] error in
                if let error = error {
                    print("Broadcast error: \(error)")
                    self?.removeConnection(connection)
                }
            })
        }
    }
    
    private func removeConnection(_ connection: NWConnection) {
        connection.cancel()
        connections.removeAll { $0 === connection }
    }
}

#else // Linux implementation
import Socket

public class WebSocketServer {
    private var socket: Socket?
    private let port: Int
    public var lastReceivedData: Data? // For testing
    
    public init(port: UInt16) throws {
        self.port = Int(port)
        socket = try Socket.create()
    }
    
    public func start() {
        try? socket?.listen(on: port)
        // Add Linux-specific message handling here
    }
    
    public func broadcast(data: Data) {
        // Implement Linux broadcast logic
    }
}
#endif
