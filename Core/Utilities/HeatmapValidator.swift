import Foundation

public struct HeatmapValidator {
    public static func validateFloorPlanAndHeatmap(in directory: URL, floorName: String) -> (planExists: Bool, heatmapExists: Bool) {
        let planPath = directory.appendingPathComponent("\(floorName).png")
        let csvPath = directory.appendingPathComponent("\(floorName)_heatmap.csv")
        
        return (
            FileManager.default.fileExists(atPath: planPath.path),
            FileManager.default.fileExists(atPath: csvPath.path)
        )
    }
}
