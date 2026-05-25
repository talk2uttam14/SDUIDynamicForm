//
//  SupportingTypes.swift
//  SDUIDynamicForm
//
//  Created by COMVIVA on 25/05/26.
//

import Foundation

struct FieldOption: Codable, Identifiable, Equatable, Sendable {
    let id: String
    let label: String
}

struct FormTheme: Codable, Equatable, Sendable {
    let backgroundColor: String
    let textColor: String
    let borderColor: String
    let errorColor: String

    enum CodingKeys: String, CodingKey {
        case backgroundColor = "background_color"
        case textColor = "text_color"
        case borderColor = "border_color"
        case errorColor = "error_color"
    }
}

struct FormDefinition: Codable, Equatable, Sendable {
    let theme: FormTheme
    let formTitle: String
    let fields: [FormField]

    enum CodingKeys: String, CodingKey {
        case theme
        case formTitle = "form_title"
        case fields
    }

    var sortedFields: [FormField] {
        fields.sorted { $0.order < $1.order }
    }
}
