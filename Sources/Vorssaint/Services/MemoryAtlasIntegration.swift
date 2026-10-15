// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Gediminas (@aktoriukas)
import MemoryAtlasKit

@MainActor final class MemoryAtlasIntegration {
    static let shared = MemoryAtlasIntegration()

    func syncWithPreferences() {
        if !AppFeature.memoryAtlas.isAvailable { MemoryAtlasSession.shared.stopMonitoring() }
    }

    var canTerminate: Bool { MemoryAtlasSession.shared.canTerminate }
}
