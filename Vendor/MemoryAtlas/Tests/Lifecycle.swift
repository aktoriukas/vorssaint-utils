// SPDX-License-Identifier: MIT
// Copyright (c) 2026 Gediminas (@aktoriukas)
import AppKit

@main struct LifecycleCheck {
    @MainActor static func main() async throws {
        precondition(Bridge.demo, "Run only with --demo")
        _ = NSApplication.shared
        NSApp.setActivationPolicy(.accessory)
        let session = MemoryAtlasSession.shared
        assert(!session.model.isMonitoring)
        session.setVisible(true)
        session.setVisible(true)
        assert(session.model.isMonitoring)
        for _ in 0..<100 where session.model.lastUpdated == nil && session.model.error == nil {
            try await Task.sleep(nanoseconds: 100_000_000)
        }
        assert(session.model.error == nil, session.model.error ?? "")
        assert(number(session.model.counts["observation"]) > 0, "Bundled bridge must load demo data")
        await session.model.loadMemories()
        assert(!session.model.records.isEmpty)
        await session.model.loadGraph()
        assert(!objects(session.model.graph["nodes"]).isEmpty)
        session.model.busy = true
        session.model.export("json", filtered: false)
        let overlapping = await session.model.operation(["op": "save_settings", "changes": [:]])
        assert(!overlapping && session.model.busy, "Another action must not clear an active write")
        session.model.busy = false
        session.setVisible(false)
        assert(!session.model.isMonitoring, "Closing must stop background polling")
        assert(session.canTerminate)
        session.setVisible(true)
        assert(session.model.isMonitoring)
        session.setVisible(false)
        assert(!session.model.isMonitoring)
        print("PASS: embedded resource loading, memory browser, graph, embedded session, stop/restart monitoring, idle termination")
    }
}
