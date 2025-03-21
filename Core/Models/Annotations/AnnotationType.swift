//
//  AnnotationType.swift
//  SWIN
//
//  Created by Khalid Mukhtar on 18/03/2025.
//
import Foundation

public enum AnnotationType: String, Codable, CaseIterable, Hashable {
    case landmark = "Landmark"
    case exit = "Emergency Exit"
    case wifiHotspot = "WiFi Hotspot"
    case entrance = "Main Entrance"
    case elevator = "Elevator"
    case stairs = "Stairs"
    case escalator = "Escalator"
}

