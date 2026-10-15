# Embedded Memory Atlas

Vendored from [aktoriukas/memory-atlas](https://github.com/aktoriukas/memory-atlas) at `87daab961b49211df6e6dc8d53ad7d319be8682d` (v0.1.0).
The MIT license and claude-mem Apache-2.0 notices are retained here and in the built app.

The Swift sources compile as the static `MemoryAtlasKit` module. Atlas Bar owns the process,
menu bar and login item. The standalone app entry point is omitted; `EmbeddedWindow.swift`
provides one reusable dashboard window. Monitoring runs only while that window is open.
An in-flight memory operation blocks normal host termination. Closing or disabling the
feature stops polling without cancelling a memory write already in progress.

The Python bridge is unchanged. Existing memories, revisions, backups and manual links
stay in their original locations; no migration or copying is performed. Edits remain
guarded to claude-mem 13.29.0. The dashboard retains its original English interface.
The host feature description is translated for all host locales.

Checks:

```sh
./Tools/check-memory-atlas.sh
python3 -B Vendor/MemoryAtlas/scripts/check.py
```

The Swift check uses a temporary app bundle and invented memories. The Python check
uses temporary SQLite/Chroma stores and the existing cached Chroma runtime. Neither
check edits real memories. Run from the repository root on macOS.
