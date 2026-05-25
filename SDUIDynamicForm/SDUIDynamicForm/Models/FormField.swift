//
//  FormField.swift
//  SDUIDynamicForm
//
//  Created by COMVIVA on 25/05/26.
//

import Foundation

import Foundation

struct FormField: Codable, Identifiable, Equatable, Sendable {

    // MARK: - Core

    let id: String
    let order: Int
    let type: FieldType
    let label: String

    // MARK: - Common

    let required: Bool
    let placeholder: String?
    let errorMessage: String?

    // MARK: - TEXT

    let subtype: TextSubtype?
    let maxLength: Int?

    // MARK: - DROPDOWN

    let allowMultiple: Bool
    let options: [FieldOption]

    // MARK: - Defaults

    let defaultValue: JSONValue?
    let defaultValues: [String]

    // MARK: - Metadata

    let metadata: [String: JSONValue]
    let clickableTextColor: String?

    // MARK: - Forward Compatibility

    let extraProperties: [String: JSONValue]

    // MARK: - Coding Keys

    enum CodingKeys: String, CodingKey {
        case id
        case order
        case type
        case label
        case required
        case placeholder

        case errorMessage = "error_message"

        case subtype
        case maxLength = "max_length"

        case allowMultiple = "allow_multiple"
        case options

        case defaultValue = "default_value"
        case defaultValues = "default_values"

        case metadata
        case clickableTextColor = "clickable_text_color"
    }

    // MARK: - Decoder

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: DynamicCodingKey.self)

        id = try container.decode(
            String.self,
            forKey: DynamicCodingKey(stringValue: "id")!
        )

        order = try container.decode(
            Int.self,
            forKey: DynamicCodingKey(stringValue: "order")!
        )

        type = try container.decode(
            FieldType.self,
            forKey: DynamicCodingKey(stringValue: "type")!
        )

        label = try container.decode(
            String.self,
            forKey: DynamicCodingKey(stringValue: "label")!
        )

        // MARK: Common

        required = try container.decodeIfPresent(
            Bool.self,
            forKey: DynamicCodingKey(stringValue: "required")!
        ) ?? false

        placeholder = try container.decodeIfPresent(
            String.self,
            forKey: DynamicCodingKey(stringValue: "placeholder")!
        )

        errorMessage = try container.decodeIfPresent(
            String.self,
            forKey: DynamicCodingKey(stringValue: "error_message")!
        )

        // MARK: Text

        subtype = try container.decodeIfPresent(
            TextSubtype.self,
            forKey: DynamicCodingKey(stringValue: "subtype")!
        )

        maxLength = try container.decodeIfPresent(
            Int.self,
            forKey: DynamicCodingKey(stringValue: "max_length")!
        )

        // MARK: Dropdown

        allowMultiple = try container.decodeIfPresent(
            Bool.self,
            forKey: DynamicCodingKey(stringValue: "allow_multiple")!
        ) ?? false

        options = try container.decodeIfPresent(
            [FieldOption].self,
            forKey: DynamicCodingKey(stringValue: "options")!
        ) ?? []

        // MARK: Defaults

        defaultValue = try container.decodeIfPresent(
            JSONValue.self,
            forKey: DynamicCodingKey(stringValue: "default_value")!
        )

        defaultValues = try container.decodeIfPresent(
            [String].self,
            forKey: DynamicCodingKey(stringValue: "default_values")!
        ) ?? []

        // MARK: Metadata

        metadata = try container.decodeIfPresent(
            [String: JSONValue].self,
            forKey: DynamicCodingKey(stringValue: "metadata")!
        ) ?? [:]

        clickableTextColor = try container.decodeIfPresent(
            String.self,
            forKey: DynamicCodingKey(stringValue: "clickable_text_color")!
        )

        // MARK: Extra Properties

        let knownKeys: Set<String> = [
            "id",
            "order",
            "type",
            "label",
            "required",
            "placeholder",
            "error_message",
            "subtype",
            "max_length",
            "allow_multiple",
            "options",
            "default_value",
            "default_values",
            "metadata",
            "clickable_text_color"
        ]

        var extras: [String: JSONValue] = [:]

        for key in container.allKeys where !knownKeys.contains(key.stringValue) {

            extras[key.stringValue] = try container.decode(
                JSONValue.self,
                forKey: key
            )
        }

        extraProperties = extras
    }
}
