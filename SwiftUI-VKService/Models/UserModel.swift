//
//  UserModel.swift
//  VKClient
//
//  Created by Кирилл Копытин on 30.06.2021.
//

import Foundation
import DynamicJSON
import RealmSwift

class UserModel: Object {

    @objc dynamic var id = 0
    @objc dynamic var lastName = ""
    @objc dynamic var firstName = ""
    @objc dynamic var avatar = ""
    @objc dynamic var company: String?
    @objc dynamic var city: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }

    convenience required init(data: JSON) {
        self.init()

        self.id = data.id.int ?? 0
        self.lastName = data.last_name.string ?? ""
        self.firstName = data.first_name.string ?? ""
        self.avatar = data.photo_50.string ?? ""
        self.company = data.career[0].company.string
        self.city = data.city.title.string
    }
    
    func getFullName() -> String {
        return "\(self.firstName) \(self.lastName)"
    }
    
    func getUserInfo() -> String {
        [self.company, self.city]
            .compactMap { $0 }
            .joined(separator: ", ")
    }
}
