// SPDX-License-Identifier: MIT
// Copyright (c) 2026 Gediminas (@aktoriukas)
import AppKit
import SwiftUI

@MainActor public final class MemoryAtlasSession {
    public static let shared = MemoryAtlasSession()
    let model = AtlasModel()

    public func setVisible(_ visible: Bool) {
        if visible { model.startMonitoring() } else { model.stopMonitoring() }
    }

    public func stopMonitoring() { model.stopMonitoring() }

    public var canTerminate: Bool {
        guard model.busy else { return true }
        let alert = NSAlert()
        alert.messageText = "A memory operation is still running"
        alert.informativeText = "Wait for it to finish before quitting."
        alert.runModal()
        return false
    }
}

@MainActor public struct MemoryAtlasContent: View {
    private let isVisible: Bool
    public init(isVisible: Bool) { self.isVisible = isVisible }

    public var body: some View {
        Dashboard()
            .environmentObject(MemoryAtlasSession.shared.model)
            .onChange(of: isVisible, initial: true) { _, visible in MemoryAtlasSession.shared.setVisible(visible) }
            .onDisappear { MemoryAtlasSession.shared.stopMonitoring() }
    }
}
