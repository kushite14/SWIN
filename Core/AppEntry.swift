//
//  AppEntry.swift
//  SWIN
//
//  Created by Khalid Mukhtar on 21/03/2025.
//
// AppEntry.swift
import SwiftUI

@main
struct SWINApp: App {
    var body: some Scene {
        WindowGroup {
            AnnotationManager()
                .frame(minWidth: 800, minHeight: 600)
        }
    }
}
