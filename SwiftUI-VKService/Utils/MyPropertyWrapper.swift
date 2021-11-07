//
//  MyPropertyWrapper.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 07.11.2021.
//

import UIKit

enum CodeStyle {
    case camelCase // следующее слово с большой буквы
    case snakeCase // нижнее подчеркивание
    case kebabCase // тире
}
    
@propertyWrapper
struct CodingStyle {
    private var value: String
    private let codeStyle: CodeStyle
    
    init(wrappedValue: String, codeStyle: CodeStyle) {
        self.value = wrappedValue
        self.codeStyle = codeStyle
    }
    
    private func get() -> String {
        return value
    }
    
    private mutating func set(_ newValue: String) {
        switch self.codeStyle {
        case .camelCase:
            self.value = newValue.lowercased()
                .split(separator: " ")
                .map { String($0) }
                .enumerated()
                .map { $0.offset > 0 ? $0.element.capitalized : $0.element.lowercased() }
                .joined()
        case .kebabCase:
            self.value = newValue.lowercased().replacingOccurrences(of: "[\\s_]", with: "-", options: .regularExpression)
        case .snakeCase:
            self.value = newValue.lowercased().replacingOccurrences(of: "[\\s-]", with: "_", options: .regularExpression)
        }
    }
    
    public var wrappedValue: String {
        get {
            get()
        }
        set {
            set(newValue)
        }
    }
}
