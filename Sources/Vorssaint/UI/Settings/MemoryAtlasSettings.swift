// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Gediminas (@aktoriukas)
import SwiftUI
import MemoryAtlasKit

struct MemoryAtlasSettings: View {
    @ObservedObject private var settingsWindow = SettingsWindowVisibility.shared

    var body: some View {
        if AppFeature.memoryAtlas.isAvailable {
            MemoryAtlasContent(isVisible: settingsWindow.isVisible)
        }
    }
}
