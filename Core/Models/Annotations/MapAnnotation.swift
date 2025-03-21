//
//  MapAnnotation.swift
//  SWIN
//
//  Created by Khalid Mukhtar on 21/03/2025.
//

import Foundation
import MapKit

public struct MapAnnotationItem: Identifiable, Codable {
    public enum AnnotationKind: String, Codable {
        case userPin
        case wifiHotspot
    }

    public let id: UUID
    public var title: String
    public var coordinate: CLLocationCoordinate2D
    public var kind: AnnotationKind

    public init(id: UUID = UUID(), title: String, coordinate: CLLocationCoordinate2D, kind: AnnotationKind) {
        self.id = id
        self.title = title
        self.coordinate = coordinate
        self.kind = kind
    }

    enum CodingKeys: String, CodingKey {
        case id, title, latitude, longitude, kind
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        kind = try container.decode(AnnotationKind.self, forKey: .kind)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(coordinate.latitude, forKey: .latitude)
        try container.encode(coordinate.longitude, forKey: .longitude)
        try container.encode(kind, forKey: .kind)
    }
}
