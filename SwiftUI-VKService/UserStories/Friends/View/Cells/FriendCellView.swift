//
//  FriendCellView.swift
//  SwiftUI-VKService
//
//  Created by Кирилл Копытин on 06.10.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct FriendCellView: View {
    let friend: FriendDisplayItem
    
    var body: some View {
        HStack {
            
            AvatarImage {
                WebImage(url: URL(string: self.friend.avatar))
                    .placeholder(Image("camera"))
            }
            
            VStack (alignment: .leading) {
                Text("\(self.friend.fullName)")
                
                Text("\(self.friend.userInfo)")
                    .font(.footnote)
                    .fontWeight(.thin)
            }
            .lineLimit(1)

            Spacer()
        }
    }
}

struct FriendCellView_Previews: PreviewProvider {
    static var previews: some View {
        FriendCellView(friend: FriendDisplayItem(id: 1, fullName: "Ivanov Ivan", avatar: "", userInfo: "dfsdf"))
    }
}
