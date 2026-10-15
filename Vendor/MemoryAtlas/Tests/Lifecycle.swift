// SPDX-License-Identifier: MIT
// Copyright (c) 2026 Gediminas (@aktoriukas)
import AppKit

@main struct LifecycleCheck {
    @MainActor static func main() async throws {
        precondition(Bridge.demo, "Run only with --demo")
        _ = NSApplication.shared
        NSApp.setActivationPolicy(.accessory)
        let controller = MemoryAtlasWindowController()
        assert(!controller.model.isMonitoring)
        let window = controller.window
        controller.open()
        controller.open()
        assert(controller.window === window, "Reopening must reuse the dashboard")
        assert(controller.model.isMonitoring)
        for _ in 0..<100 where controller.model.lastUpdated == nil && controller.model.error == nil {
            try await Task.sleep(nanoseconds: 100_000_000)
        }
        assert(controller.model.error == nil, controller.model.error ?? "")
        assert(number(controller.model.counts["observation"]) > 0, "Bundled bridge must load demo data")
        await controller.model.loadMemories()
        assert(!controller.model.records.isEmpty)
        await controller.model.loadGraph()
        assert(!objects(controller.model.graph["nodes"]).isEmpty)
        controller.model.busy = true
        controller.model.export("json", filtered: false)
        let overlapping = await controller.model.operation(["op": "save_settings", "changes": [:]])
        assert(!overlapping && controller.model.busy, "Another action must not clear an active write")
        controller.model.busy = false
        controller.close()
        assert(!controller.model.isMonitoring, "Closing must stop background polling")
        assert(controller.canTerminate)
        controller.open()
        assert(controller.window === window && controller.model.isMonitoring)
        controller.close()
        assert(!controller.model.isMonitoring)
        print("PASS: embedded resource loading, memory browser, graph, single window, stop/restart monitoring, idle termination")
    }
}
