//
//  TextSubtype.swift
//  SDUIDynamicForm
//
//  Created by COMVIVA on 25/05/26.
//

import Foundation
enum TextSubtype: String, Codable, CaseIterable, Sendable {
    case plain = "PLAIN"
    case multiline = "MULTILINE"
    case number = "NUMBER"
    case uri = "URI"
    case secure = "SECURE"

    init(from decoder: Decoder) throws {
        let raw = try decoder.singleValueContainer().decode(String.self)
        self = TextSubtype(rawValue: raw.uppercased()) ?? .plain
    }
}
