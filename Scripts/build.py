import os
import platform
import subprocess
from pathlib import Path

def main():
    # Get project root and find all Swift files
    project_root = Path(__file__).parent.parent
    swift_files = []
    
    # Include AppEntry.swift and exclude test files
    for path in project_root.rglob("*.swift"):
        if "Tests" not in path.parts and "xcodeproj" not in path.parts:
            swift_files.append(str(path))
    
    # Get SDK and target information
    sdk_path = subprocess.check_output(["xcrun", "--show-sdk-path"]).decode().strip()
    arch = "arm64" if platform.processor() == "arm" else "x86_64"
    target = f"{arch}-apple-macosx15.2"
    
    # Updated build command with critical fixes
    cmd = [
        "swiftc",
        "-sdk", sdk_path,
        "-target", target,
        "-parse-as-library",
        "-emit-executable",  # Crucial for executable generation
        "-F", f"{sdk_path}/System/Library/Frameworks",
        "-framework", "SwiftUI",
        "-framework", "AppKit",  # Required for macOS UI
        "-framework", "MapKit",
        "-framework", "Combine",
        "-Xlinker", "-no_application_extension",  # Bypass framework restrictions
        "-o", str(project_root/"SWIN")
    ] + swift_files
    
    # Execute build with detailed error handling
    result = subprocess.run(cmd, capture_output=True, text=True)
    
    if result.returncode == 0:
        print("\033[32m✅ Build successful!\033[0m")
    else:
        print("\033[31m❌ Build failed!\033[0m")
        print("\nError details:")
        print(result.stderr)
        exit(1)

if __name__ == "__main__":
    main()
