
# 🛰️ SWIN – Smart Wireless Indoor Navigation

**SWIN** is an enterprise-grade, real-time indoor navigation system optimized for hospitals, campuses, and emergency response deployments. It uses RSSI-based WiFi triangulation, grid alignment, and modular Swift components for real-time tracking and routing.

---

## 🚀 Features

- 📡 **RSSI-Based Indoor Localization** (iOS compatible)
- 🗺️ **Grid-Based Coordinate Mapping** (Affine transform engine)
- 🧭 **Pathfinding & Evacuation Guidance** (Dijkstra with floor support)
- 🔁 **WebSocket Communication** (macOS/Linux support)
- 🧩 **Modular SwiftUI Dashboard** (Live map, Emergency mode, Calibration)
- 🔐 **Privacy-Compliant & Offline-Capable**

---

## 📦 Architecture Overview

```
SWIN/
├── Core/              # Swift logic for triangulation, localization, routing
├── Scripts/           # Python tools for RSSI data generation
├── Tests/             # Unit tests (triangulation, routing)
├── Resources/         # Grid JSONs, floor plan metadata
├── Python Backends/   # Experimental server-side tools
├── SWIN.entitlements  # iOS/macOS entitlements for WiFi info access
└── SWIN.xcodeproj     # Swift app project
```

---

## 📍 RSSI Migration Checklist (April 2025)

To support iPhone-compatible WiFi-based localization, we're transitioning from BSSID to **RSSI fingerprinting**.

📄 [View the full migration plan → SWIN_RSSI_Migration_Checklist.md](./SWIN_RSSI_Migration_Checklist.md)

---

## ⚙️ Getting Started

```bash
git clone https://github.com/kushite14/SWIN.git
cd SWIN
open SWIN.xcodeproj
```

For iOS builds: ensure proper `.entitlements` and request `NEHotspotHelper` via Apple.

---

## 🧪 Current Status

| Module          | Status         |
|------------------|----------------|
| Triangulator     | 🟡 In Progress |
| Affine Transform | 🔲 Pending     |
| Pathfinding      | ✅ Complete     |
| Emergency Sync   | 🟡 Partial     |
| WebSocket (Linux)| 🔲 Pending     |

---

## 📜 License

This project is maintained by [@kushite14](https://github.com/kushite14). MIT License.
