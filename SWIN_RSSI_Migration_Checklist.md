
# ✅ SWIN RSSI Migration Checklist

This document tracks required changes to migrate SWIN from BSSID-dependent triangulation to a fully RSSI-based, iPhone-compatible indoor localization system.

---

## 🧭 Objective 1: RSSI-Based Localization (iPhone-Compatible)

### 1.1 Replace `WiFiScanPoint` with `RSSIFingerprint`
- **Need**: iOS no longer allows access to BSSID.
- **Goal**: Adopt `[Double]`-based signal strength fingerprinting compatible with iOS/macOS.

### 1.2 Refactor `WiFiTestTriangulator`
- **Need**: Old logic depends on BSSID-location mapping.
- **Goal**: Implement `estimateUserLocation(from: [Double])` using k-NN matching with `RSSIFingerprint`.

### 1.3 Generate and load `BJC_RSSIFingerprint.json`
- **Need**: Source data is large and redundant.
- **Goal**: Python script to compress raw scan data into averaged RSSI vectors by location.

---

## 🔁 Objective 2: Coordinate Transformation (Grid Alignment)

### 2.1 Complete `LocalizationManager.calculateAffineTransform()`
- **Need**: Current transform matrix uses stubbed values.
- **Goal**: Implement matrix solution using Accelerate (macOS) and LASwift (Linux).

### 2.2 Validate Affine Accuracy with Test GridPoints
- **Need**: Ensure physical-to-grid accuracy.
- **Goal**: Visual debug tool or test suite to confirm 3-point transform consistency.

---

## 🌐 Objective 3: Cross-Platform WebSocket Server

### 3.1 Complete Linux WebSocket broadcast
- **Need**: Linux server logic incomplete.
- **Goal**: Implement connection accept/read/broadcast using SwiftNIO or `Socket` API.

### 3.2 Sync `SWIN_WebSocket` with `EmergencySystem`
- **Need**: Evacuation messages must propagate platform-wide.
- **Goal**: Ensure Linux/macOS message parity in `broadcast(data:)`.

---

## 🧪 Objective 4: Testing & Validation Infrastructure

### 4.1 Implement `Building.mockHospital()`
- **Need**: Required by `PathfindingTests.swift`
- **Goal**: Load synthetic or sample `Building` and `PathNode` objects.

### 4.2 Create unit tests for triangulation
- **Need**: Validate estimated location accuracy
- **Goal**: Simulate known RSSI input → expect (x, y) output ≈ truth

---

## 🧩 Objective 5: SwiftUI Modularization

### 5.1 Refactor `AnnotationManager` into Tabs
- **Need**: UI will expand: live map, emergency, calibration.
- **Goal**: Use SwiftUI `TabView` with LiveMap, EmergencyView, GridConfigView.

### 5.2 Visualize k-NN Location in UI
- **Need**: User feedback on triangulation result.
- **Goal**: Overlay triangulated location pin via `MapAnnotationItem`

---

## 🔐 Objective 6: Compliance & Privacy

### 6.1 Update `.entitlements` for iOS/macOS
- **Need**: Access RSSI via `NEHotspotHelper` / `wifi-info`
- **Goal**: Add approved entitlements + feedback submission to Apple

### 6.2 Sanitize stored data (optional)
- **Need**: Avoid user tracking concerns
- **Goal**: Replace identifiers with anonymized IDs / timestamps

---

## ✅ Tracking Summary

| Area                        | Task Count | Status       |
|-----------------------------|------------|--------------|
| RSSI Localization           | 3          | 🟡 In Progress |
| Grid Alignment              | 2          | 🔲 Pending     |
| WebSocket (Linux)          | 2          | 🔲 Pending     |
| Testing Infrastructure     | 2          | 🔲 Pending     |
| SwiftUI UI/UX               | 2          | 🔲 Pending     |
| Compliance & Privacy       | 2          | 🟡 In Progress |
