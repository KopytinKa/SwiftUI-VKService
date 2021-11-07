//
//  GroupDisplayItemFabric.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 07.11.2021.
//

import Foundation
import RealmSwift

enum GroupDisplayItemFabric {
    static func makeItems(with groups: Results<GroupModel>) -> [GroupDisplayItem] {
        return groups.map {
            GroupDisplayItem(
                id: $0.id,
                name: $0.name,
                avatar: $0.avatar
            )
        }
    }
}
