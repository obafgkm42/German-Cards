import CoreFoundation
import Foundation

/// The JSON Schema used by providers that support Structured Outputs.
struct LLMWordCardSchema {
    static let name = "german_vocabulary_card"

    static func make(includePropertyOrdering: Bool) -> JSONSchema {
        let declensionRow = object(
            [
                "caseName": string(description: "German grammatical case name."),
                "singular": string(description: "Singular form including the article."),
                "plural": string(description: "Plural form including the article.")
            ],
            includePropertyOrdering: includePropertyOrdering
        )
        let verbConjugationRow = object(
            [
                "tense": string(description: "German tense name."),
                "pronoun": string(description: "Pronoun or summary-row label."),
                "form": string(description: "Conjugated verb form.")
            ],
            includePropertyOrdering: includePropertyOrdering
        )
        let adjectiveComparison = object(
            [
                "positive": string(description: "Positive adjective form."),
                "comparative": string(description: "Comparative adjective form."),
                "superlative": string(description: "Superlative adjective form.")
            ],
            includePropertyOrdering: includePropertyOrdering
        )

        return object(
            [
                "word": string(description: "Resolved German dictionary headword."),
                "meaning": string(description: "Concise Traditional Chinese meaning."),
                "englishMeaning": nullable(string(description: "Concise English gloss.")),
                "partOfSpeech": string(
                    description: "Part of speech using an English lowercase value.",
                    enumValues: PartOfSpeech.allCases.map(\.rawValue)
                ),
                "gender": string(
                    description: "German grammatical gender; use none when gender does not apply.",
                    enumValues: GrammaticalGender.allCases.map(\.rawValue)
                ),
                "pluralForm": string(description: "German plural form, or a dash when it does not apply."),
                "declensionTable": array(
                    items: declensionRow,
                    description: "Noun declension rows; use an empty array for non-nouns."
                ),
                "verbConjugation": array(
                    items: verbConjugationRow,
                    description: "Common conjugation rows; use an empty array for non-verbs."
                ),
                "adjectiveComparison": nullable(adjectiveComparison),
                "exampleSentence": string(description: "Concise German example sentence."),
                "exampleTranslation": string(description: "Traditional Chinese translation of the example."),
                "referenceSource": string(description: "Short source description; the app replaces this with provider metadata."),
                "notes": array(
                    items: string(description: "One concise Traditional Chinese learning note."),
                    description: "Relevant learning notes without filler."
                ),
                "isValidGermanWord": JSONSchema(
                    type: "boolean",
                    description: "Whether the query resolves confidently to a useful German vocabulary entry."
                ),
                "suggestedWord": nullable(string(description: "Most likely German lemma when the query is invalid or ambiguous.")),
                "confidence": JSONSchema(
                    type: "number",
                    description: "Confidence from 0 through 1.",
                    minimum: 0,
                    maximum: 1
                )
            ],
            includePropertyOrdering: includePropertyOrdering
        )
    }

    private static func object(
        _ properties: [String: JSONSchema],
        includePropertyOrdering: Bool
    ) -> JSONSchema {
        let required = Array(properties.keys).sorted()
        return JSONSchema(
            type: "object",
            properties: properties,
            required: required,
            additionalProperties: false,
            propertyOrdering: includePropertyOrdering ? required : nil
        )
    }

    private static func string(
        description: String,
        enumValues: [String]? = nil
    ) -> JSONSchema {
        JSONSchema(type: "string", description: description, enumValues: enumValues)
    }

    private static func array(items: JSONSchema, description: String) -> JSONSchema {
        JSONSchema(type: "array", description: description, items: items)
    }

    private static func nullable(_ schema: JSONSchema) -> JSONSchema {
        JSONSchema(anyOf: [schema, JSONSchema(type: "null")])
    }
}

final class JSONSchema: Encodable {
    let type: String?
    let description: String?
    let properties: [String: JSONSchema]?
    let required: [String]?
    let additionalProperties: Bool?
    let propertyOrdering: [String]?
    let items: JSONSchema?
    let enumValues: [String]?
    let anyOf: [JSONSchema]?
    let minimum: Double?
    let maximum: Double?

    init(
        type: String? = nil,
        description: String? = nil,
        properties: [String: JSONSchema]? = nil,
        required: [String]? = nil,
        additionalProperties: Bool? = nil,
        propertyOrdering: [String]? = nil,
        items: JSONSchema? = nil,
        enumValues: [String]? = nil,
        anyOf: [JSONSchema]? = nil,
        minimum: Double? = nil,
        maximum: Double? = nil
    ) {
        self.type = type
        self.description = description
        self.properties = properties
        self.required = required
        self.additionalProperties = additionalProperties
        self.propertyOrdering = propertyOrdering
        self.items = items
        self.enumValues = enumValues
        self.anyOf = anyOf
        self.minimum = minimum
        self.maximum = maximum
    }

    private enum CodingKeys: String, CodingKey {
        case type
        case description
        case properties
        case required
        case additionalProperties
        case propertyOrdering
        case items
        case enumValues = "enum"
        case anyOf
        case minimum
        case maximum
    }

    func validates(_ value: Any) -> Bool {
        if let anyOf {
            return anyOf.contains { $0.validates(value) }
        }

        switch type {
        case "object":
            guard let object = value as? [String: Any] else { return false }
            if let required, !Set(required).isSubset(of: Set(object.keys)) {
                return false
            }
            if additionalProperties == false,
               let properties,
               !Set(object.keys).isSubset(of: Set(properties.keys)) {
                return false
            }
            return properties?.allSatisfy { key, propertySchema in
                guard let propertyValue = object[key] else { return true }
                return propertySchema.validates(propertyValue)
            } ?? true
        case "array":
            guard let values = value as? [Any] else { return false }
            guard let items else { return true }
            return values.allSatisfy(items.validates)
        case "string":
            guard let stringValue = value as? String else { return false }
            return enumValues?.contains(stringValue) ?? true
        case "boolean":
            guard let number = value as? NSNumber else { return false }
            return CFGetTypeID(number) == CFBooleanGetTypeID()
        case "number":
            guard
                let number = value as? NSNumber,
                CFGetTypeID(number) != CFBooleanGetTypeID()
            else {
                return false
            }
            let doubleValue = number.doubleValue
            guard doubleValue.isFinite else { return false }
            if let minimum, doubleValue < minimum { return false }
            if let maximum, doubleValue > maximum { return false }
            return true
        case "null":
            return value is NSNull
        case nil:
            return true
        default:
            return false
        }
    }
}

enum ChatResponseFormat: Encodable {
    case structuredOutputs
    case jsonObject

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .structuredOutputs:
            try container.encode("json_schema", forKey: .type)
            try container.encode(
                OpenAIJSONSchema(
                    name: LLMWordCardSchema.name,
                    strict: true,
                    schema: LLMWordCardSchema.make(includePropertyOrdering: false)
                ),
                forKey: .jsonSchema
            )
        case .jsonObject:
            try container.encode("json_object", forKey: .type)
        }
    }

    private enum CodingKeys: String, CodingKey {
        case type
        case jsonSchema = "json_schema"
    }
}

private struct OpenAIJSONSchema: Encodable {
    let name: String
    let strict: Bool
    let schema: JSONSchema
}

struct GeminiGenerationConfig: Encodable {
    let responseMimeType = "application/json"
    let responseJsonSchema = LLMWordCardSchema.make(includePropertyOrdering: true)
}

extension LLMConfiguration {
    var chatResponseFormat: ChatResponseFormat {
        guard
            provider == .openAICompatible,
            URLComponents(string: normalizedBaseURL)?.host?.lowercased() == "api.openai.com"
        else {
            // OpenAI-compatible endpoints vary widely; only opt in when support is known.
            return .jsonObject
        }
        return .structuredOutputs
    }
}
