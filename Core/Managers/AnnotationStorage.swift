//
//  AnnotationStorage.swift
//  SWIN
//
//  Created by Khalid Mukhtar on 20/03/2025.
//
import Foundation
import MapKit
import _MapKit_SwiftUI

class AnnotationStorage {
    /// ✅ Loads annotations from JSON storage
    static func loadAnnotations() -> [MapAnnotationItem] { // Changed type
            guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?
                .appendingPathComponent("Annotations.json") else { return [] }
            
            do {
                let data = try Data(contentsOf: url)
                return try JSONDecoder().decode([MapAnnotationItem].self, from: data) // Changed decoder
            } catch {
                print("Error loading annotations: \(error.localizedDescription)")
                return []
            }
        }

        /// ✅ Saves annotations to JSON storage
        static func saveAnnotations(_ annotations: [MapAnnotationItem]) { // Changed type
            guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?
                .appendingPathComponent("Annotations.json") else { return }
            
            do {
                let data = try JSONEncoder().encode(annotations)
                try data.write(to: url)
            } catch {
                print("Error saving annotations: \(error.localizedDescription)")
            }
        }
    }
