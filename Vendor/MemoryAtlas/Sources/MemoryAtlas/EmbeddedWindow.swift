// SPDX-License-Identifier: MIT
// Copyright (c) 2026 Gediminas (@aktoriukas)
import AppKit
import SwiftUI

@MainActor public final class MemoryAtlasWindowController: NSWindowController, NSWindowDelegate {
    let model = AtlasModel()

    public init() {
        let window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 1380, height: 900),
                              styleMask: [.titled, .closable, .miniaturizable, .resizable],
                              backing: .buffered, defer: false)
        super.init(window: window)
        window.title = "Memory Atlas"
        window.minSize = NSSize(width: 1080, height: 700)
        window.isReleasedWhenClosed = false
        window.contentView = NSHostingView(rootView: Dashboard().environmentObject(model))
        window.delegate = self
        window.center()
        window.setFrameAutosaveName("MemoryAtlasDashboard")
    }

    required init?(coder: NSCoder) { fatalError("Use init()") }

    public func open() {
        model.startMonitoring()
        showWindow(nil)
        window?.deminiaturize(nil)
        window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }

    public func windowWillClose(_ notification: Notification) {
        model.stopMonitoring()
    }

    public var canTerminate: Bool {
        guard model.busy else { return true }
        let alert = NSAlert()
        alert.messageText = "Memory Atlas is still working"
        alert.informativeText = "Wait for the memory operation to finish before quitting Atlas Bar."
        alert.runModal()
        return false
    }
}
