//
//  FriendPhotoCellView.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 13.10.2021.
//

import SwiftUI

struct FriendPhotoCellView: View {
    let photo: Photo
    
    var body: some View {
        VStack {
            Image("\(self.photo.url)")
                .resizable()
                .frame(width: 90, height: 90)
            
            HStack {
                Button(action: { print("press button") }) {
                    Image(systemName: "\(self.photo.userLikes > 0 ? "heart.fill" : "heart")")
                }
                
                Text("\(self.photo.likesCount)")
            }
            .lineLimit(1)
        }
        .frame(width: 100, height: 125)
    }
}

struct FriendPhotoCellView_Previews: PreviewProvider {
    static var previews: some View {
        FriendPhotoCellView(photo: Photo(url: "vmeste_logo", likesCount: 213, userLikes: 1))
    }
}
