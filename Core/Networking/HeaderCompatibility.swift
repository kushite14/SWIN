//
//  HeaderCompatibility.swift
//  SWIN
//
//  Created by Khalid Mukhtar on 17/03/2025.
//
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class HTTPCompatibilityLayer {
    // Fallback implementations for Linux
    #if canImport(FoundationNetworking)
    static func urlSession() -> URLSession {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }
    #endif
}
