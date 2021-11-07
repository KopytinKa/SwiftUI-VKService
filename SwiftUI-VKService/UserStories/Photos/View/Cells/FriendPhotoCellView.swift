//
//  FriendPhotoCellView.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 13.10.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct FriendPhotoCellView: View {
    @State private var isLiked = false
    
    let photo: PhotoDisplayItem
    
    var body: some View {
        VStack {
            WebImage(url: URL(string: self.photo.url))
                .resizable()
            
            HStack {
                Button(action: {
                    print("press button")
                    withAnimation(.easeInOut(duration: 1.0)) {
                        self.isLiked.toggle()
                    }
                }) {
                    Image(systemName: "\(isLiked ? "heart.fill" : "heart")")
                }
                .scaleEffect(isLiked ? 1.25 : 1)
                
                Text("\(self.photo.likesCount)")
            }
            .lineLimit(1)
        }
    }
}

struct FriendPhotoCellView_Previews: PreviewProvider {
    static var previews: some View {
        FriendPhotoCellView(photo: PhotoDisplayItem(id: 1, url: "vmeste_logo", likesCount: 213, userLikes: 1))
    }
}
