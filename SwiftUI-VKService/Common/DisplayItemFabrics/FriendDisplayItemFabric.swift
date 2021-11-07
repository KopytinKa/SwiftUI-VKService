//
//  FriendDisplayItemFabric.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 06.11.2021.
//

import Foundation
import RealmSwift

enum FriendDisplayItemFabric {
    static func makeItems(with friends: Results<UserModel>) -> [FriendDisplayItem] {
        return friends.map {
            FriendDisplayItem(
                id: $0.id,
                fullName: $0.getFullName(),
                avatar: $0.avatar,
                userInfo: $0.getUserInfo()
            )
        }
    }
}
