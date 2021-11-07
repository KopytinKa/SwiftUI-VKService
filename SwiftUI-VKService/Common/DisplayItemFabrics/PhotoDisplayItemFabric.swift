//
//  PhotoDisplayItemFabric.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 07.11.2021.
//

import Foundation
import RealmSwift

enum PhotoDisplayItemFabric {
    static func makeItems(with photos: Results<PhotoModel>) -> [PhotoDisplayItem] {
        return photos.map {
            PhotoDisplayItem(
                id: $0.id,
                url: $0.urlByPhoto,
                likesCount: $0.likesCount,
                userLikes: $0.userLikes
            )
        }
    }
}
