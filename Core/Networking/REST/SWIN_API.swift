import Foundation

final class SWIN_API {
    static let baseURL = ProcessInfo.processInfo.environment["SWIN_API_BASE_URL"] ?? "https://api.swin-server.com"

    static func getPosition(bssids: [String], completion: @escaping (Result<(Double, Double), Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/triangulate") else {
            completion(.failure(URLError(.badURL)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = ["bssids": bssids]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoded = try JSONDecoder().decode([String: Double].self, from: data)
                    let x = decoded["x"] ?? 0.0
                    let y = decoded["y"] ?? 0.0
                    completion(.success((x, y)))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }

    static func getConnectedUsers(completion: @escaping (Result<Int, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/connected_users") else {
            completion(.failure(URLError(.badURL)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let count = try JSONDecoder().decode(Int.self, from: data)
                    completion(.success(count))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }

    static func syncFloorPlans(completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/sync_updates") else {
            completion(.failure(URLError(.badURL)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { _, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                completion(.success(true))
            } else {
                completion(.failure(URLError(.badServerResponse)))
            }
        }
        task.resume()
    }
}  
