//
//  FriendPhotosView.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 13.10.2021.
//

import SwiftUI
import ASCollectionView

struct FriendPhotosView: View {
    let friend: Friend
    
    @State private var photos: [Photo] = [
        Photo(url: "community", likesCount: 23, userLikes: 0),
        Photo(url: "camera", likesCount: 23, userLikes: 1),
        Photo(url: "vmeste_logo", likesCount: 213, userLikes: 1),
        Photo(url: "login_wallpaper", likesCount: 1, userLikes: 0)
    ]
    
    var body: some View {
        ASCollectionView(data: photos) { photo, _ in
            FriendPhotoCellView(photo: photo)
        }.layout {
            .grid(
                layoutMode: .fixedNumberOfColumns(3),
                itemSpacing: 0,
                lineSpacing: 16
            )
        }.navigationTitle(self.friend.getFullName())
    }
}

struct FriendPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        FriendPhotosView(friend: Friend(lastName: "Kirillov", firstName: "Kirill", avatar: nil, company: nil, city: "Moscow"))
    }
}
