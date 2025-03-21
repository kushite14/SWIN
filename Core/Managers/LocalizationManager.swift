import Foundation

class LocalizationManager {
    static let shared = LocalizationManager()
    private var routerLocations: [String: GridPoint] = [:]
    private var transformMatrix: AffineTransform?
    
    // MARK: - Coordinate Transformation
    func loadAlignmentData(
        gridUnits: [GridUnit],
        wifiRouters: [WiFiRouter],
        manualReferencePoints: [(gridPixel: GridPoint, wifiReal: GridPoint)]
    ) {
        calculateAffineTransform(referencePoints: manualReferencePoints)
        routerLocations = wifiRouters.reduce(into: [:]) { result, router in
            if let transformed = applyTransformation(to: GridPoint(x: router.x, y: router.y)) {
                result[router.macAddress] = transformed
            }
        }
    }
    
    private func calculateAffineTransform(referencePoints: [(gridPixel: GridPoint, wifiReal: GridPoint)]) {
        guard referencePoints.count >= 3 else { return }
        var A = [[Double]]()
        var Bx = [Double]()
        var By = [Double]()
        
        for point in referencePoints {
            let (x, y) = (point.wifiReal.x, point.wifiReal.y)
            let (u, v) = (point.gridPixel.x, point.gridPixel.y)
            A.append([x, y, 1, 0, 0, 0])
            A.append([0, 0, 0, x, y, 1])
            Bx.append(u)
            By.append(v)
        }
        
        // Solve using Accelerate (Replace with actual implementation)
        let solutionX = [Double](repeating: 0, count: 6)
        let solutionY = [Double](repeating: 0, count: 6)
        
        transformMatrix = AffineTransform(
            a: solutionX[0], b: solutionX[1], c: solutionX[2],
            d: solutionY[0], e: solutionY[1], f: solutionY[2]
        )
    }
    
    func applyTransformation(to point: GridPoint) -> GridPoint? {
        guard let t = transformMatrix else { return nil }
        return GridPoint(
            id: UUID(),  // Add ID
            x: t.a * point.x + t.b * point.y + t.c,
            y: t.d * point.x + t.e * point.y + t.f
        )
    }
    
    // MARK: - Router Data
    func loadRouterData(_ routers: [WiFiRouter]) {
        routerLocations = routers.reduce(into: [:]) { result, router in
            result[router.macAddress] = GridPoint(x: router.x, y: router.y)
        }
    }
    
    func locateUser(using bssid: String) -> GridPoint? {
        return routerLocations[bssid]
    }
}
