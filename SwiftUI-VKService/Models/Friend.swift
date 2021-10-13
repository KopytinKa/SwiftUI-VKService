//
//  Friend.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 12.10.2021.
//

import Foundation

class Friend: Identifiable {
    let id: UUID = UUID()
    let lastName: String
    let firstName: String
    let avatar: String?
    let company: String?
    let city: String?
    
    init(lastName: String, firstName: String, avatar: String?, company: String?, city: String?) {
        self.lastName = lastName
        self.firstName = firstName
        self.avatar = avatar
        self.company = company
        self.city = city
    }
    
    func getFullName() -> String {
        return "\(self.firstName) \(self.lastName)"
    }
}
