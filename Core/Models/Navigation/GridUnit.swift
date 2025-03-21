//
//  GridUnit.swift
//  SWIN
//
//  Created by Khalid Mukhtar on 19/03/2025.
//
import Foundation
// Define GridUnit (Add to Models/Navigation/GridUnit.swift)
public struct GridUnit: Codable, Hashable {
    public let unitRef: String
    public let topLeftPixel: GridPoint
    public let botRightPixel: GridPoint
}
