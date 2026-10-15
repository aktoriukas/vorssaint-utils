// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Gediminas (@aktoriukas)
import MemoryAtlasKit

@MainActor final class MemoryAtlasIntegration {
    static let shared = MemoryAtlasIntegration()
    private var dashboard: MemoryAtlasWindowController?

    func open() {
        guard AppFeature.memoryAtlas.isAvailable else { return }
        if dashboard == nil { dashboard = MemoryAtlasWindowController() }
        dashboard?.open()
    }

    func syncWithPreferences() {
        if !AppFeature.memoryAtlas.isAvailable { dashboard?.close() }
    }

    var canTerminate: Bool { dashboard?.canTerminate ?? true }
}
