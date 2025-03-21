//
//  SWIN_WebSocket.swift
//  SWIN
//
//  Created by Khalid Mukhtar on 02/03/2025.
//

import Foundation
import Combine

final class SWIN_WebSocket: ObservableObject {
    static let shared = SWIN_WebSocket()
    private var webSocketTask: URLSessionWebSocketTask?
    @Published var realTimePosition: (x: Double, y: Double)?

    func connect() {
        guard let url = URL(string: "\(SWIN_API.baseURL)/track") else { return }
        webSocketTask = URLSession.shared.webSocketTask(with: url)
        webSocketTask?.resume()
        receiveMessage()
    }

    private func receiveMessage() {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .success(.data(let data)):
                if let decoded = try? JSONDecoder().decode([String: Double].self, from: data) {
                    DispatchQueue.main.async {
                        self?.realTimePosition = (decoded["x"] ?? 0, decoded["y"] ?? 0)
                    }
                }
            case .failure(let error):
                print("WebSocket error: \(error)")
            default: break
            }
            self?.receiveMessage()
        }
    }

    func broadcast(_ routes: [EvacuationRoute]) async throws {
        let data = try JSONEncoder().encode(routes)
        webSocketTask?.send(.data(data)) { error in
            if let error = error { print("Broadcast error: \(error)") }
        }
    }
}  
