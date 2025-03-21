//
//  Untitled.swift
//  SWIN
//
//  Created by Khalid Mukhtar on 07/03/2025.
//
import Foundation

class ResourceManager {
    static let shared = ResourceManager()
    private let fileManager = FileManager.default
    
    func loadResources() throws -> [ResourceItem] {
        guard let url = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first?
            .appendingPathComponent("ProtoWIN/Resources.json") else {
            throw URLError(.badURL)
        }
        
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([ResourceItem].self, from: data)
    }
    
    func saveResources(_ items: [ResourceItem]) throws {
        guard let url = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
            throw URLError(.cannotCreateFile)
        }
        
        let directory = url.appendingPathComponent("ProtoWIN")
        try fileManager.createDirectory(at: directory, withIntermediateDirectories: true)
        let fileURL = directory.appendingPathComponent("Resources.json")
        let data = try JSONEncoder().encode(items)
        try data.write(to: fileURL, options: .atomic)
    }
}

struct ResourceItem: Codable, Identifiable {
    let id: UUID
    let name: String
    let type: String
    let x: Double
    let y: Double

    enum CodingKeys: String, CodingKey {
        case id, name, type, x, y
    }
}

