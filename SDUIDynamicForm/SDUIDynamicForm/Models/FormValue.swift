//
//  FormValue.swift
//  SDUIDynamicForm
//
//  Created by COMVIVA on 25/05/26.
//

import Foundation

enum FormValue: Equatable {

    case text(String)
    case bool(Bool)
    case singleSelection(String)
    case multiSelection(Set<String>)
}
