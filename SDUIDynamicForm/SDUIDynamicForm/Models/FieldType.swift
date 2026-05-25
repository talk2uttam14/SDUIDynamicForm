//
//  FieldType.swift
//  SDUIDynamicForm
//
//  Created by COMVIVA on 25/05/26.
//

import Foundation
enum FieldType: Codable, Equatable, Hashable, Sendable {
    case text
    case dropdown
    case toggle
    case checkbox
    case unknown(String)

    init(from decoder: Decoder) throws {
        let raw = try decoder.singleValueContainer().decode(String.self)

        switch raw.uppercased() {
        case "TEXT":
            self = .text
        case "DROPDOWN":
            self = .dropdown
        case "TOGGLE":
            self = .toggle
        case "CHECKBOX":
            self = .checkbox
        default:
            self = .unknown(raw)
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }

    var rawValue: String {
        switch self {
        case .text:
            return "TEXT"
        case .dropdown:
            return "DROPDOWN"
        case .toggle:
            return "TOGGLE"
        case .checkbox:
            return "CHECKBOX"
        case .unknown(let value):
            return value
        }
    }

    var isKnown: Bool {
        if case .unknown = self {
            return false
        }

        return true
    }
}
