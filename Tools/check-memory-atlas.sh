#!/bin/zsh
# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright (C) 2026 Gediminas (@aktoriukas)
set -euo pipefail
cd "$(dirname "$0")/.."
ATLAS_CHECK_DIR="$(mktemp -d)"
trap 'rm -rf "$ATLAS_CHECK_DIR"' EXIT
ATLAS_CHECK_APP="$ATLAS_CHECK_DIR/Atlas Check.app"
mkdir -p "$ATLAS_CHECK_APP/Contents/MacOS" "$ATLAS_CHECK_APP/Contents/Resources"
cp -R Vendor/MemoryAtlas/Resources "$ATLAS_CHECK_APP/Contents/Resources/MemoryAtlas"
cp Vendor/MemoryAtlas/scripts/fixtures/claude-mem-13.29.0.sql "$ATLAS_CHECK_APP/Contents/Resources/MemoryAtlas/demo-schema.sql"
cat > "$ATLAS_CHECK_APP/Contents/Info.plist" <<'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<plist version="1.0"><dict>
<key>CFBundleIdentifier</key><string>io.github.aktoriukas.vorssaint-memory.check</string>
<key>CFBundleExecutable</key><string>AtlasCheck</string>
<key>CFBundlePackageType</key><string>APPL</string>
<key>LSUIElement</key><true/>
</dict></plist>
PLIST
swiftc -Onone -parse-as-library -sdk "$(xcrun --show-sdk-path)" \
    Vendor/MemoryAtlas/Sources/MemoryAtlas/*.swift Vendor/MemoryAtlas/Tests/Lifecycle.swift \
    -o "$ATLAS_CHECK_APP/Contents/MacOS/AtlasCheck"
"$ATLAS_CHECK_APP/Contents/MacOS/AtlasCheck" --demo
