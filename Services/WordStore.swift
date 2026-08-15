import Foundation
import Combine

@MainActor
final class WordStore: ObservableObject {
    @Published private(set) var history: [GermanWordData] = []
    @Published private(set) var storageDescription = "Local dictionary"

    private let storageKey = "german_cards_history_v1"
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        load()
    }

    var count: Int { history.count }

    func findCached(_ word: String, partOfSpeech: PartOfSpeech? = nil) -> GermanWordData? {
        let normalized = normalize(word)
        let eligibleCards = history.filter { card in
            partOfSpeech == nil || card.partOfSpeech == partOfSpeech
        }

        if let exactMatch = eligibleCards.first(where: { normalize($0.word) == normalized }) {
            return exactMatch
        }
        if let inflectedMatch = eligibleCards.first(where: { matchesNounForm($0, normalized: normalized) }) {
            return inflectedMatch
        }

        // German nouns are capitalized. A query such as "Route" must reach the
        // German lookup instead of being captured by an English gloss on another card.
        guard shouldUseTranslationCache(for: word) else { return nil }
        return eligibleCards.first { matchesTranslation($0, normalized: normalized) }
    }

    private func matchesNounForm(_ card: GermanWordData, normalized: String) -> Bool {
        guard isNoun(card) else { return false }
        return normalize(card.pluralForm) == normalized ||
            card.declensionTable.contains { row in
                normalize(row.singular) == normalized || normalize(row.plural) == normalized
            }
    }

    private func isNoun(_ card: GermanWordData) -> Bool {
        card.partOfSpeech == .noun || card.gender != .none
    }

    private func matchesTranslation(_ card: GermanWordData, normalized: String) -> Bool {
        guard !normalized.isEmpty else { return false }

        if let englishMeaning = card.englishMeaning, matchesSeparatedGloss(englishMeaning, normalized: normalized) {
            return true
        }
        return matchesSeparatedGloss(card.meaning, normalized: normalized)
    }

    private func matchesSeparatedGloss(_ value: String, normalized: String) -> Bool {
        let normalizedValue = normalize(value)
        guard !normalizedValue.isEmpty else { return false }
        if normalizedValue == normalized { return true }

        let separators = CharacterSet(charactersIn: ",，、;；/／()（）[]【】")
            .union(.whitespacesAndNewlines)
        let components = normalizedValue
            .components(separatedBy: separators)
            .filter { !$0.isEmpty }

        if components.contains(normalized) {
            return true
        }

        // Chinese glosses are often stored without spaces, so allow a conservative substring match.
        return normalized.count >= 2 &&
            containsCJK(normalized) &&
            normalizedValue.contains(normalized)
    }

    func save(_ data: GermanWordData) {
        history.removeAll { $0.id == data.id }
        history.insert(data, at: 0)
        persist()
    }

    func replace(original: GermanWordData, with updated: GermanWordData) {
        history.removeAll { item in
            item.id == original.id || item.id == updated.id
        }
        history.insert(updated, at: 0)
        persist()
    }

    func delete(_ data: GermanWordData) {
        history.removeAll { $0.id == data.id }
        persist()
    }

    func delete(at offsets: IndexSet) {
        for index in offsets.sorted(by: >) where history.indices.contains(index) {
            history.remove(at: index)
        }
        persist()
    }

    func reload() {
        load()
    }

    func exportData() throws -> Data {
        let archive = DictionaryArchive(cards: history)
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        return try encoder.encode(archive)
    }

    @discardableResult
    func importData(_ data: Data) throws -> Int {
        let cards = try decodeImportedCards(from: data)
        for card in cards {
            history.removeAll { $0.id == card.id }
            history.append(card)
        }
        history.sort { $0.timestamp > $1.timestamp }
        persist()
        return cards.count
    }

    private func load() {
        guard let data = userDefaults.data(forKey: storageKey) else {
            history = []
            storageDescription = "Local dictionary"
            return
        }
        history = ((try? JSONDecoder().decode([GermanWordData].self, from: data)) ?? [])
            .sorted { $0.timestamp > $1.timestamp }
        storageDescription = "Local dictionary"
    }

    private func persist() {
        // UserDefaults is the local store; export/import handles user-controlled sync.
        guard let data = try? JSONEncoder().encode(history) else { return }
        userDefaults.set(data, forKey: storageKey)
        storageDescription = "Local dictionary"
    }

    private func decodeImportedCards(from data: Data) throws -> [GermanWordData] {
        let decoder = JSONDecoder()
        if let archive = try? decoder.decode(DictionaryArchive.self, from: data) {
            return archive.cards
        }
        return try decoder.decode([GermanWordData].self, from: data)
    }

    private func normalize(_ word: String) -> String {
        word.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }

    private func containsCJK(_ value: String) -> Bool {
        value.unicodeScalars.contains { scalar in
            (0x4E00...0x9FFF).contains(scalar.value)
        }
    }

    private func shouldUseTranslationCache(for query: String) -> Bool {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !containsCJK(trimmed) else { return true }
        guard !trimmed.contains(where: { $0.isWhitespace }) else { return true }
        guard let firstLetter = trimmed.unicodeScalars.first(where: CharacterSet.letters.contains) else {
            return true
        }
        return !CharacterSet.uppercaseLetters.contains(firstLetter)
    }
}


private struct DictionaryArchive: Codable {
    let archiveVersion: Int
    let exportedAt: TimeInterval
    let cards: [GermanWordData]

    init(cards: [GermanWordData]) {
        self.archiveVersion = 1
        self.exportedAt = Date().timeIntervalSince1970
        self.cards = cards
    }
}
