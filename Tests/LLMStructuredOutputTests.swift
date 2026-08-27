import Foundation

@main
struct LLMStructuredOutputTests {
    static func main() throws {
        try testOpenAIStructuredOutputFormat()
        try testCustomJSONModeFormat()
        try testUnknownOpenAICompatibleProviderUsesJSONMode()
        try testGeminiStructuredOutputFormat()
        try testValidPayloadPassesClientValidation()
        try testUnknownPropertyFailsClientValidation()
        try testMissingPropertyFailsClientValidation()
        try testInvalidConfidenceFailsClientValidation()
        print("structured-output regression passed")
    }

    private static func testOpenAIStructuredOutputFormat() throws {
        let object = try encodedObject(ChatResponseFormat.structuredOutputs)
        try expect(object["type"] as? String == "json_schema", "OpenAI should request json_schema output")

        let jsonSchema = try objectValue(object["json_schema"], name: "json_schema")
        try expect(jsonSchema["name"] as? String == LLMWordCardSchema.name, "schema name should be stable")
        try expect(jsonSchema["strict"] as? Bool == true, "OpenAI schema should be strict")

        let schema = try objectValue(jsonSchema["schema"], name: "schema")
        try expect(schema["additionalProperties"] as? Bool == false, "root should reject unknown properties")
        try expect(schema["propertyOrdering"] == nil, "OpenAI schema should not contain Gemini extensions")
        try expect((schema["required"] as? [String])?.count == 16, "all card fields should be required")
    }

    private static func testCustomJSONModeFormat() throws {
        let object = try encodedObject(ChatResponseFormat.jsonObject)
        try expect(object["type"] as? String == "json_object", "Custom should retain JSON mode")
        try expect(object["json_schema"] == nil, "Custom should not assume Structured Outputs support")
    }

    private static func testUnknownOpenAICompatibleProviderUsesJSONMode() throws {
        let configuration = LLMConfiguration(
            provider: .openAICompatible,
            baseURL: "https://provider.example/v1",
            model: "example-model",
            apiKey: "test-key",
            additionalRequestBody: ""
        )
        let object = try encodedObject(configuration.chatResponseFormat)
        try expect(object["type"] as? String == "json_object", "unknown compatible providers should retain JSON mode")
    }

    private static func testGeminiStructuredOutputFormat() throws {
        let object = try encodedObject(GeminiGenerationConfig())
        try expect(object["responseMimeType"] as? String == "application/json", "Gemini should request JSON")

        let schema = try objectValue(object["responseJsonSchema"], name: "responseJsonSchema")
        let required = schema["required"] as? [String]
        try expect(schema["propertyOrdering"] as? [String] == required, "Gemini should receive explicit property ordering")
    }

    private static func testValidPayloadPassesClientValidation() throws {
        let result = try LLMWordClient().decodeWordData(
            from: validPayload,
            fallbackWord: "Sonne"
        )
        try expect(result.word == "Sonne", "valid payload should decode")
        try expect(result.partOfSpeech == .noun, "part of speech should be preserved")
    }

    private static func testUnknownPropertyFailsClientValidation() throws {
        let payload = validPayload.replacingOccurrences(
            of: "\"confidence\":0.95",
            with: "\"confidence\":0.95,\"unexpected\":true"
        )
        try expectDecodeFailure(payload, message: "unknown properties should be rejected locally")
    }

    private static func testMissingPropertyFailsClientValidation() throws {
        let payload = validPayload.replacingOccurrences(
            of: "\"referenceSource\":\"LLM generated\",",
            with: ""
        )
        try expectDecodeFailure(payload, message: "missing required properties should be rejected locally")
    }

    private static func testInvalidConfidenceFailsClientValidation() throws {
        let payload = validPayload.replacingOccurrences(of: "\"confidence\":0.95", with: "\"confidence\":1.5")
        try expectDecodeFailure(payload, message: "out-of-range confidence should be rejected locally")
    }

    private static func expectDecodeFailure(_ payload: String, message: String) throws {
        do {
            _ = try LLMWordClient().decodeWordData(from: payload, fallbackWord: "Sonne")
            throw TestFailure(message)
        } catch is WordLookupError {
            return
        }
    }

    private static func encodedObject<T: Encodable>(_ value: T) throws -> [String: Any] {
        let data = try JSONEncoder().encode(value)
        return try objectValue(JSONSerialization.jsonObject(with: data), name: "encoded value")
    }

    private static func objectValue(_ value: Any?, name: String) throws -> [String: Any] {
        guard let object = value as? [String: Any] else {
            throw TestFailure("\(name) should be a JSON object")
        }
        return object
    }

    private static func expect(_ condition: @autoclosure () -> Bool, _ message: String) throws {
        guard condition() else { throw TestFailure(message) }
    }

    private static let validPayload = #"""
    {
      "word":"Sonne",
      "meaning":"太陽",
      "englishMeaning":"sun",
      "partOfSpeech":"noun",
      "gender":"die",
      "pluralForm":"Sonnen",
      "declensionTable":[],
      "verbConjugation":[],
      "adjectiveComparison":null,
      "exampleSentence":"Die Sonne scheint.",
      "exampleTranslation":"太陽正在照耀。",
      "referenceSource":"LLM generated",
      "notes":[],
      "isValidGermanWord":true,
      "suggestedWord":null,
      "confidence":0.95
    }
    """#
}

private struct TestFailure: LocalizedError {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    var errorDescription: String? { message }
}
