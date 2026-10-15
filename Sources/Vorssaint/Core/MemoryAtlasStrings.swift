// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Gediminas (@aktoriukas)
import Foundation

enum MemoryAtlasStrings {
    static func description(_ language: AppLanguage) -> String {
        switch language {
        case .enUS: return "Browse, connect and manage your local Claude and Codex memories."
        case .ptBR: return "Explore, conecte e gerencie suas memórias locais do Claude e Codex."
        case .tr: return "Yerel Claude ve Codex anılarınızı inceleyin, bağlayın ve yönetin."
        case .ru: return "Просматривайте, связывайте и управляйте локальной памятью Claude и Codex."
        case .es: return "Explora, conecta y gestiona tus recuerdos locales de Claude y Codex."
        case .sk: return "Prehliadajte, prepájajte a spravujte lokálne spomienky Claude a Codex."
        case .de: return "Lokale Claude- und Codex-Erinnerungen durchsuchen, verknüpfen und verwalten."
        case .fr: return "Parcourez, reliez et gérez vos souvenirs locaux Claude et Codex."
        case .it: return "Esplora, collega e gestisci le memorie locali di Claude e Codex."
        case .ja: return "ClaudeとCodexのローカルメモリを閲覧、接続、管理します。"
        case .ko: return "Claude와 Codex의 로컬 메모리를 탐색하고 연결하고 관리합니다."
        case .zhHans: return "浏览、关联和管理本地 Claude 和 Codex 记忆。"
        case .zhTW: return "瀏覽、連結及管理本機 Claude 和 Codex 記憶。"
        case .zhHK: return "瀏覽、連結及管理本機 Claude 和 Codex 記憶。"
        case .uk: return "Переглядайте, пов’язуйте та керуйте локальною пам’яттю Claude і Codex."
        }
    }
}
