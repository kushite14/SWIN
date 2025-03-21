#!/bin/bash

PROJECT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." >/dev/null 2>&1 && pwd )"
SDK_PATH=$(xcrun --show-sdk-path)

# Compile with explicit SDK
find "$PROJECT_ROOT" -name "*.swift" -not -path "*/Tests/*" -print0 | xargs -0 swiftc \
    -sdk "$SDK_PATH" \
    -target arm64-apple-macosx15.2 \
    -F "$SDK_PATH/System/Library/Frameworks" \
    -framework MapKit \
    -o "$PROJECT_ROOT/SWINServer"

if [ $? -eq 0 ]; then
    echo "✅ Compiled: SWINServer"
else
    echo "❌ Failed!"
    exit 1
fi  
