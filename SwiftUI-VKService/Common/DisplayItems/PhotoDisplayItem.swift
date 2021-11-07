//
//  PhotoDisplayItem.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 07.11.2021.
//

import Foundation

struct PhotoDisplayItem: Identifiable {
    let id: Int
    let url: String
    let likesCount: Int
    let userLikes: Int
}
